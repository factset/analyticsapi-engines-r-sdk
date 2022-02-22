library(httr)
library(factset.protobuf.stach.v2)
library(stringr)

# Reading environment variables

host <- Sys.getenv("FACTSET_HOST")
username <- Sys.getenv("FACTSET_USERNAME")
password <- Sys.getenv("FACTSET_API_KEY")
#proxyUrl <-
#Sys.getenv("CLIENT_PROXY_URL") # To Set Up Proxy Configuration

# This is a helper function used to construct PA Identifier list
GetPAIdentifier <- function(Id, holdingsMode)
{
  Id = c(Id) # Account Id
  holdingsMode = c(holdingsMode) # It can be B&H, TBR, OMS or EXT
  paAccounts <- data.frame(Id, holdingsMode)
  return(paAccounts)
}

paDocument <- "PA_DOCUMENTS:DEFAULT"
paComponentName <- "Weights"
paComponentCategory <- "Weights / Exposures"

paAccounts1 <- GetPAIdentifier("BENCH:SP50", "OMS")
#paAccounts2 <- GetPAIdentifier("BENCH:SP50DIV", "OMS")
paAccounts <-
  rbind(paAccounts1) # paAccounts <- rbind(paAccounts1,paAccounts2)

paBenchmarks1 <- GetPAIdentifier("BENCH:R.1000", "B&H")
paBenchmarks <- rbind(paBenchmarks1)

paDates <- list(frequency = "Single",
                startdate = "0",
                enddate =  "0")

# building list of status codes to be ignored for retry.
# only the 429 and 503 status codes will be retried.
statusCodesRange <- c(100, 599)
terminateonStatusCodes <- setdiff(statusCodesRange, c(429, 503))

maxCalls <- 3 # Maximum number of times to retry api requests

# This is a helper function used to get the response from an api end point
GetApiResponse <- function(methodType,
                           url,
                           username,
                           password,
                           requestBody = NULL,
                           customHeaders = NULL)
{
  switch(
    methodType,
    "GET" = apiResponse <- RETRY(
      "GET",
      url,
      #use_proxy(url = proxyUrl), # uncomment this to set up proxy url
      authenticate(username, password),
      add_headers(Accept = "application/json"),
      content_type("application/json"),
      pause_min = 2,
      # pause for 'two' seconds of time
      times = maxCalls,
      # Maximum number of requests to attempt
      terminate_on = terminateonStatusCodes
    ),
    "POST" = apiResponse <- RETRY(
      "POST",
      url,
      #use_proxy(url = proxyUrl), # uncomment this to set up proxy url
      authenticate(username, password),
      add_headers("Accept" = "application/json", customHeaders),
      content_type("application/json"),
      pause_min = 2,
      times = maxCalls,
      # Maximum number of requests to attempt
      body =  requestBody,
      terminate_on = terminateonStatusCodes
    )
  )
  if (http_error(apiResponse) == TRUE)
  {
    print(paste("Request to api failed", http_status(apiResponse)))
    PrintApiErrorResponse(apiResponse)
    stop("Api exception encountered")
  }
  return(apiResponse)
}

# This is a helper function used to print api error response
PrintApiErrorResponse <- function(apiResponse) {
  message <- content(apiResponse, "text", encoding = "UTF-8")
  if (nchar(message) > 0) {
    print(paste0("message : ", message))
  }
  print("Response Headers:")
  print(headers(apiResponse))
}

# This is a helper function used to get stach json data from calculation result api response
ProcessCalcUnitApiResponse <- function(apiResponse) {
  responseObj <-
    jsonlite::fromJSON(httr::content(apiResponse, "text", encoding = "UTF-8"))
  responseData <- responseObj$data
  stachdata <- jsonlite::toJSON(responseData, na = "null")
  return(stachdata)
}

# This is a helper function used to convert stach data to data frame using 'factset.protobuf.stachextensions' package
ConvertStachToDataframe <- function(stachdata) {
  package <-
    readJSON(factset.protobuf.stach.v2.RowOrganizedPackage,
             input = as.character(stachdata))
  stachExtensionrow <-
    factset.protobuf.stachextensions::V2RowOrganizedStachExtension$new()
  dflst <- stachExtensionrow$ConvertToDataFrame(package)
  return(dflst)
}

# This is a helper function used to process each unit id and print the result
ProcessUnitIdResponses <- function(calculationStatus) {
  totalunits <- length(calculationStatus$data$units)
  unitresult <- list()
  calculationId <- calculationStatus$data$calculationid
  for (i in 1:totalunits)
  {
    uniturl <- calculationStatus$data$units[[i]]$result
    unitstatus <- calculationStatus$data$units[[i]]$status
    if (tolower(unitstatus) == tolower("Success"))
    {
      print(paste0(
        "Calculation id - ",
        calculationId,
        " with unit id - ",
        i,
        " Succeeded"
      ))
      
      calcunitResultResponse <-
        GetApiResponse("GET", uniturl, username, password, requestBody = NULL)
      stachdata <-
        ProcessCalcUnitApiResponse(calcunitResultResponse)
      dataFrameResult <- ConvertStachToDataframe(stachdata)
      PrintDataFrameResult(dataFrameResult)
    }
    else{
      print(paste0(
        "Calculation id - ",
        calculationId,
        " with unit id - ",
        i,
        " Failed"
      ))
      print(paste0(
        "Error message : ",
        calculationStatus$data$units[[i]]$errors$detail
      ))
    }
  }
}

# This is a helper function used to print data frame result
PrintDataFrameResult <- function(dataFrameResult) {
  for (dataFramelstidx in 1:length(dataFrameResult))
  {
    print(paste0(
      "Printing first 10 Rows of Primary Table - ",
      names(dataFrameResult[dataFramelstidx])
    ))
    primaryTableData <-
      head(dataFrameResult[[dataFramelstidx]], n = 10)
    print(primaryTableData)
  }
}

# This is a helper function used to construct request body
CreateCalculationRequestBody <- function(paComponentId) {
  # PAComponentId
  paCalculation  <- list(componentid = paComponentId)
  
  # PAAccounts
  paCalculation  <-
    append(paCalculation, list(accounts = paAccounts))
  
  # PABenchmarks
  paCalculation  <-
    append(paCalculation, list(benchmarks = paBenchmarks))
  
  # DateParameters
  paCalculation  <- append(paCalculation, list(dates = paDates))
  
  # currency override
  paCalculation  <-
    append(paCalculation, list(currencyisocode = "USD"))
  
  requestBodyparam <-
    list("data" = list("1" = paCalculation, "2" = paCalculation))
  
  return(requestBodyparam)
}


main <- function() {
  # Get all components from PA_DEFAULT_DOCUMENT with Name COMPONENT_NAME & category COMPONENT_CATEGORY
  
  componentsLookupUrl <-
    paste0(host,
           "/analytics/engines/pa/v3/components?document=",
           paDocument)
  
  componentsResponse <-
    GetApiResponse("GET", componentsLookupUrl, username, password)
  
  componentResponseObj <-
    jsonlite::fromJSON(httr::content(componentsResponse, "text", encoding = "UTF-8"))
  componentResponseData <- componentResponseObj$data
  lstnames <- names(componentResponseData)
  for (i in 1:length(componentResponseData)) {
    name <- componentResponseData[[i]]$name
    category <- componentResponseData[[i]]$category
    if (tolower(name) == tolower(paComponentName) &&
        tolower(category) == tolower(paComponentCategory))
    {
      paComponentId <- lstnames[i]
      break
    }
  }
  
  if (is.null(paComponentId))
  {
    print(
      paste(
        "Component Id not found for Component Name:",
        paComponentName,
        "and Component Category:",
        paComponentCategory
      )
    )
    stop("Invalid Component Id Error")
  }
  
  
  # Process to get PA V3 Calculations
  
  calculationUrl <-
    paste0(host, "/analytics/engines/pa/v3/calculations")
  requestBodyparam <- CreateCalculationRequestBody(paComponentId)
  calcRequestParameters <-
    jsonlite::toJSON(requestBodyparam, auto_unbox = T)
  print("Post Body")
  print(calcRequestParameters)
  customHeaders <- NULL
  # uncomment the below line to add cache control configuration. Results are by default cached for 12 hours; Setting max-stale=300 will fetch a cached result which is at max 5 minutes older.
  # customHeaders <- c("cache-control" = "max-stale=300")
  apiResponse <-
    GetApiResponse("POST",
                   calculationUrl,
                   username,
                   password,
                   calcRequestParameters,
                   customHeaders)
  if (status_code(apiResponse) == "200")
  {
    # For the Multiple PA Units, process each unit id and print the result
    responseObj <-
      jsonlite::fromJSON(httr::content(apiResponse, "text", encoding = "UTF-8"))
    ProcessUnitIdResponses(responseObj) # Process each unit id and print the result
    
  } else if (status_code(apiResponse) == "202")
  {
    # constructing the Calculation Id Status URL using calculation id from the response body
    # which is used to get status of complete calculation
    responseObj <-
      jsonlite::fromJSON(httr::content(apiResponse, "text", encoding = "UTF-8"))
    calculationId <- responseObj$data$calculationid
    calcIdStatusUrl <- paste0(host,
                              "/analytics/engines/pa/v3/calculations/",
                              calculationId,
                              "/status")
    
    apiResponse <-
      GetApiResponse("GET", calcIdStatusUrl, username, password)
    # For the Multiple PA Units, process each unit id and print the result
    responseObj <-
      jsonlite::fromJSON(httr::content(apiResponse, "text", encoding = "UTF-8"))
    status <- responseObj$data$status
    while (tolower(status) == tolower("Queued") ||
           tolower(status) == tolower("Executing"))
    {
      age <-
        str_replace(apiResponse$headers$`cache-control`, "max-age=", "")
      
      if (is.null(age) || length(age) == 0) {
        print("Sleeping for 2 seconds")
        Sys.sleep(2) # if no age value is returned from response header sleep for 2 seconds
      }
      else{
        print(paste0("Sleeping for ", age, " Seconds"))
        Sys.sleep(age) # Based on the age value returned from response header pause(sleep) for {age} seconds
      }
      apiResponse <-
        GetApiResponse("GET", calcIdStatusUrl, username, password)
      responseObj <-
        jsonlite::fromJSON(httr::content(apiResponse, "text", encoding = "UTF-8"))
      status <- responseObj$data$status
    }
    # Sanity check for the status of group of unit id's
    if (tolower(status) == tolower("Completed"))
    {
      ProcessUnitIdResponses(responseObj) # Process each unit id and print the result
    }
  } else
  {
    print(paste0("Status code returned from api : ",
                 status_code(apiResponse)))
    PrintApiErrorResponse(apiResponse)
  }
}

main()
