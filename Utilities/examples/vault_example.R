library(factset.analyticsapi.engines)
library(factset.protobuf.stach)
library(httr)

source("stach_extensions.R")

username <- "<username-serial>"
password <- "<apikey>"
url <- "https://api.factset.com"

vault_document <- "PA_DOCUMENTS:DEFAULT"
vault_account <- VaultIdentifier$new(id = "Client:/analytics/data/US_MID_CAP_CORE.ACTM")
vault_dates = VaultDateParameters$new(startdate = "FIRST_REPOSITORY", enddate = "LAST_REPOSITORY", frequency = "Monthly")
vault_component_name = "Exposures"
vault_component_category = "General / Positioning"

apiClient <- ApiClient$new(basePath = url, username = username, password = password)

# Build Vault Calculation Parameters List ----------------
componentsApi <- ComponentsApi$new(apiClient = apiClient)
components <- tryCatch(
  componentsApi$GetVaultComponents(document = vault_document),
  ApiException = function(ex) ex
)
if(!is.null(components$ApiException)){
  cat(components$ApiException$toString())
  stop("Api exception encountered")
}

componentId <- ""

for (id in names(components)) {
  if(components[[id]]$name == vault_component_name && components[[id]]$category == vault_component_category) {
    componentId <- id
    break
  }
}

if(componentId == "") {
  print(paste("Component Id not found for Component Name", vault_component_name, "and Component Category", vault_component_category))
  stop("Invalid Component Id Error")
}

print(paste("Component Id:", componentId))

configurationsApi <- ConfigurationsApi$new(apiClient = apiClient)
configurations <- tryCatch(
  configurationsApi$GetVaultConfigurations(account = vault_account$id),
  ApiException = function(ex) ex
)
if(!is.null(configurations$ApiException)){
  cat(configurations$ApiException$toString())
  stop("Api exception encountered")
}

configId <- names(configurations[1])

print(paste("Configuration Id:", configId))

vaultCalculations <- list(
  "1" = VaultCalculationParameters$new(
    componentid = componentId, 
    account = vault_account, 
    dates = vault_dates, 
    configid = configId
  )
)

# Create Calculation ----------------
calculation <- Calculation$new(vault = vaultCalculations)

calculationsApi <- CalculationsApi$new(apiClient = apiClient)

runCalculationResponse <- tryCatch(
  calculationsApi$RunCalculationWithHttpInfo(calculation = calculation),
  ApiException = function(ex) ex
)
if(!is.null(runCalculationResponse$ApiException)){
  cat(runCalculationResponse$ApiException$toString())
  stop("Api exception encountered")
}

if (runCalculationResponse$response$status_code != 202) {
  print(paste("x-datadirect-request-key:", runCalculationResponse$response$headers$`x-datadirect-request-key`))
  print(paste("Response status code:", runCalculationResponse$response$status_code))
  print(paste("Response message:", runCalculationResponse$response$content))
  stop("Error running Calculation")
}

locationList <- strsplit(runCalculationResponse$response$headers$location, split = "/")
calculationId <- tail(unlist(locationList), n = 1)
print(paste("Calculation Id:", calculationId))

# Get Calculation Status ----------------
getCalculationStatusResponse <- tryCatch(
  calculationsApi$GetCalculationStatusByIdWithHttpInfo(id = calculationId),
  ApiException = function(ex) ex
)
if(!is.null(getCalculationStatusResponse$ApiException)){
  cat(getCalculationStatusResponse$ApiException$toString())
  stop("Api exception encountered")
}

while (getCalculationStatusResponse$response$status_code == 200 
       && (getCalculationStatusResponse$content$status == "Queued" || getCalculationStatusResponse$content$status == "Executing")) {
  maxAge <- 5
  if ("cache-control" %in% names(getCalculationStatusResponse$response$headers)) {
    maxAge <- as.numeric(unlist(strsplit(getCalculationStatusResponse$response$headers$`cache-control`, "="))[2])
  }
  print(paste("Sleeping:", maxAge, "secs"))
  Sys.sleep(maxAge)
  
  getCalculationStatusResponse <- tryCatch(
    calculationsApi$GetCalculationStatusByIdWithHttpInfo(id = calculationId),
    ApiException = function(ex) ex
  )
  if(!is.null(getCalculationStatusResponse$ApiException)){
    cat(getCalculationStatusResponse$ApiException$toString())
    stop("Api exception encountered")
  }
}

if (getCalculationStatusResponse$response$status_code != 200) {
  print(paste("Error getting status of Calculation Id:", calculationId))
  print(paste("x-datadirect-request-key:", getCalculationStatusResponse$response$headers$`x-datadirect-request-key`))
  print(paste("Response status code:", getCalculationStatusResponse$response$status_code))
  print(paste("Response message:", getCalculationStatusResponse$response$content))
  stop("Api invalid response status code encountered")
}

print("Calculation Completed!!!");

# Check for Failed Calculation Units ----------------
for (calculationUnitId in names(getCalculationStatusResponse$content$vault)) {
  if(getCalculationStatusResponse$content$vault[[calculationUnitId]]$status == "Failed") {
    print(paste("Calculation Unit Id:", calculationUnitId, "Failed!!!"))
    print(paste("Error message:", getCalculationStatusResponse$content$vault[[calculationUnitId]]$error))
  }
}

# Get Result of Successful Calculation Units ----------------
utilityApi <- UtilityApi$new(apiClient = apiClient)
tables <- list()

for (calculationUnitId in names(getCalculationStatusResponse$content$vault)) {
  if(getCalculationStatusResponse$content$vault[[calculationUnitId]]$status == "Success") {
    getCalculationUnitResultResponse <- tryCatch(
      utilityApi$GetByUrlWithHttpInfo(url = getCalculationStatusResponse$content$vault[[calculationUnitId]]$result),
      ApiException = function(ex) ex
    )
    if(!is.null(getCalculationUnitResultResponse$ApiException)){
      cat(getCalculationUnitResultResponse$ApiException$toString())
      stop("Api exception encountered")
    }
    
    if (getCalculationUnitResultResponse$response$status_code != 200) {
      print(paste("Error getting result of Calculation Unit Id:", calculationUnitId))
      print(paste("x-datadirect-request-key:", getCalculationUnitResultResponse$response$headers$`x-datadirect-request-key`))
      print(paste("Response status code:", getCalculationUnitResultResponse$response$status_code))
      print(paste("Response message:", getCalculationUnitResultResponse$response$content))
      stop("Api invalid response status code encountered")
    }
    
    print(paste("Calculation Unit Id :", calculationUnitId, "Succeeded!!!"));
    
    package <- read(factset.protobuf.stach.Package, getCalculationUnitResultResponse$content)
    
    stachExtension <- StachExtension$new()
    
    # Converting result to data frame
    tables[[calculationUnitId]] <- stachExtension$convertToDataFrame(package)
    
    # Dump data frame to .csv files
    # stachExtension$generateCSV(package)
  }
}

# Printing first 6 records in the first data frame to console
print(paste("Printing first 6 records in the first data frame"));
print(head(tables[[1]][[1]]))
