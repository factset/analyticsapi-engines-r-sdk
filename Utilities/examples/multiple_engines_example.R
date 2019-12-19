library(factset.analyticsapi.engines)
library(factset.protobuf.stach)
library(httr)

source("stach_extensions.R")

username <- "<username-serial>"
password <- "<apikey>"
url <- "https://api.factset.com"

pa_document <- "PA_DOCUMENTS:DEFAULT"
pa_account1 <- PAIdentifier$new(id = "BENCH:SP50")
pa_account2 <- PAIdentifier$new(id = "BENCH:R.2000")
pa_benchmark1 <- PAIdentifier$new(id = "BENCH:R.2000")
pa_dates <- PADateParameters$new(startdate = "20180601", enddate = "20181231", frequency = "Monthly")
pa_component_name = "Weights"
pa_component_category = "Weights / Exposures"

spar_document <- "SPAR_DOCUMENTS:Factset Default Document"
spar_account1 <- SPARIdentifier$new(id = "R.1000", returntype = "GTR", prefix = "RUSSELL")
spar_account2 <- SPARIdentifier$new(id = "R.2000", returntype = "GTR", prefix = "RUSSELL")
spar_benchmark <- SPARIdentifier$new(id = "R.2000", returntype = "GTR", prefix = "RUSSELL")
spar_dates <- SPARDateParameters$new(startdate = "20180101", enddate = "20181231", frequency = "Monthly")
spar_component_name = "Returns Data"
spar_component_category = "Raw Data / Returns"

vault_document <- "PA_DOCUMENTS:DEFAULT"
vault_account <- VaultIdentifier$new(id = "Client:/analytics/data/US_MID_CAP_CORE.ACTM")
vault_dates = VaultDateParameters$new(startdate = "20190830", enddate = "20190904", frequency = "Monthly")
vault_component_name = "Exposures"
vault_component_category = "General / Positioning"

apiClient <- ApiClient$new(basePath = url, username = username, password = password)

componentsApi <- ComponentsApi$new(apiClient = apiClient)

# Build PA Calculation Parameters List ----------------
paComponents <- tryCatch(
  componentsApi$GetPAComponents(document = pa_document),
  ApiException = function(ex) ex
)
if(!is.null(paComponents$ApiException)){
  cat(paComponents$ApiException$toString())
  stop("Api exception encountered")
}

paComponentId <- ""

for (id in names(paComponents)) {
  if(paComponents[[id]]$name == pa_component_name && paComponents[[id]]$category == pa_component_category) {
    paComponentId <- id
    break
  }
}

if(paComponentId == "") {
  print(paste("PA Component Id not found for Component Name", pa_component_name, "and Component Category", pa_component_category))
  stop("Invalid PA Component Id Error")
}

print(paste("PA Component Id:", paComponentId))

paCalculations <- list(
  "1" = PACalculationParameters$new(
    componentid = paComponentId, 
    accounts = list(pa_account1, pa_account2), 
    benchmarks = list(pa_benchmark1), 
    dates = pa_dates
  )
)

# Build SPAR Calculation Parameters List ----------------
sparComponents <- tryCatch(
  componentsApi$GetSPARComponents(document = spar_document),
  ApiException = function(ex) ex
)
if(!is.null(sparComponents$ApiException)){
  cat(sparComponents$ApiException$toString())
  stop("Api exception encountered")
}

sparComponentId <- ""

for (id in names(sparComponents)) {
  if(sparComponents[[id]]$name == spar_component_name && sparComponents[[id]]$category == spar_component_category) {
    sparComponentId <- id
    break
  }
}

if(sparComponentId == "") {
  print(paste("SPAR Component Id not found for Component Name", spar_component_name, "and Component Category", spar_component_category))
  stop("Invalid SPAR Component Id Error")
}

print(paste("SPAR Component Id:", sparComponentId))

sparCalculations <- list(
  "2" = SPARCalculationParameters$new(
    componentid = sparComponentId, 
    accounts = list(spar_account1, spar_account2), 
    benchmark = spar_benchmark, 
    dates = spar_dates
  )
)


# Build Vault Calculation Parameters List ----------------
vaultComponents <- tryCatch(
  componentsApi$GetVaultComponents(document = vault_document),
  ApiException = function(ex) ex
)
if(!is.null(vaultComponents$ApiException)){
  cat(vaultComponents$ApiException$toString())
  stop("Api exception encountered")
}

vaultComponentId <- ""

for (id in names(vaultComponents)) {
  if(vaultComponents[[id]]$name == vault_component_name && vaultComponents[[id]]$category == vault_component_category) {
    vaultComponentId <- id
    break
  }
}

if(vaultComponentId == "") {
  print(paste("Vault Component Id not found for Component Name", vault_component_name, "and Component Category", vault_component_category))
  stop("Invalid Vault Component Id Error")
}

print(paste("Vault Component Id:", vaultComponentId))

configurationsApi <- ConfigurationsApi$new(apiClient = apiClient)
vaultConfigurations <- tryCatch(
  configurationsApi$GetVaultConfigurations(account = vault_account$id),
  ApiException = function(ex) ex
)
if(!is.null(vaultConfigurations$ApiException)){
  cat(vaultConfigurations$ApiException$toString())
  stop("Api exception encountered")
}

vaultConfigId <- names(vaultConfigurations[1])

print(paste("Vault Configuration Id:", vaultConfigId))

vaultCalculations <- list(
  "3" = VaultCalculationParameters$new(
    componentid = vaultComponentId, 
    account = vault_account, 
    dates = vault_dates, 
    configid = vaultConfigId
  )
)

# Create Calculation ----------------
calculation <- Calculation$new(
  pa = paCalculations, 
  spar = sparCalculations, 
  vault = vaultCalculations
)

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
for (calculationUnitId in names(getCalculationStatusResponse$content$pa)) {
  if(getCalculationStatusResponse$content$pa[[calculationUnitId]]$status == "Failed") {
    print(paste("PA Calculation Unit Id:", calculationUnitId, "Failed!!!"))
    print(paste("Error message:", getCalculationStatusResponse$content$pa[[calculationUnitId]]$error))
  }
}

for (calculationUnitId in names(getCalculationStatusResponse$content$spar)) {
  if(getCalculationStatusResponse$content$spar[[calculationUnitId]]$status == "Failed") {
    print(paste("SPAR Calculation Unit Id:", calculationUnitId, "Failed!!!"))
    print(paste("Error message:", getCalculationStatusResponse$content$spar[[calculationUnitId]]$error))
  }
}

for (calculationUnitId in names(getCalculationStatusResponse$content$vault)) {
  if(getCalculationStatusResponse$content$vault[[calculationUnitId]]$status == "Failed") {
    print(paste("Vault Calculation Unit Id:", calculationUnitId, "Failed!!!"))
    print(paste("Error message:", getCalculationStatusResponse$content$vault[[calculationUnitId]]$error))
  }
}

# Get Result of Successful Calculation Units ----------------
utilityApi <- UtilityApi$new(apiClient = apiClient)
PATables <- list()
SPARTables <- list()
VaultTables <- list()

for (calculationUnitId in names(getCalculationStatusResponse$content$pa)) {
  if(getCalculationStatusResponse$content$pa[[calculationUnitId]]$status == "Success") {
    getCalculationUnitResultResponse <- tryCatch(
      utilityApi$GetByUrlWithHttpInfo(url = getCalculationStatusResponse$content$pa[[calculationUnitId]]$result),
      ApiException = function(ex) ex
    )
    if(!is.null(getCalculationUnitResultResponse$ApiException)){
      cat(getCalculationUnitResultResponse$ApiException$toString())
      stop("Api exception encountered")
    }
    
    if (getCalculationUnitResultResponse$response$status_code != 200) {
      print(paste("Error getting result of PA Calculation Unit Id:", calculationUnitId))
      print(paste("x-datadirect-request-key:", getCalculationUnitResultResponse$response$headers$`x-datadirect-request-key`))
      print(paste("Response status code:", getCalculationUnitResultResponse$response$status_code))
      print(paste("Response message:", getCalculationUnitResultResponse$response$content))
      stop("Api invalid response status code encountered")
    }
    
    print(paste("PA Calculation Unit Id :", calculationUnitId, "Succeeded!!!"));
    
    package <- read(factset.protobuf.stach.Package, getCalculationUnitResultResponse$content)
    
    stachExtension <- StachExtension$new()
    
    # Converting result to data frame
    PATables[[calculationUnitId]] <- stachExtension$convertToDataFrame(package)
    
    # Dump data frame to .csv files
    # stachExtension$generateCSV(package)
  }
}

for (calculationUnitId in names(getCalculationStatusResponse$content$spar)) {
  if(getCalculationStatusResponse$content$spar[[calculationUnitId]]$status == "Success") {
    getCalculationUnitResultResponse <- tryCatch(
      utilityApi$GetByUrlWithHttpInfo(url = getCalculationStatusResponse$content$spar[[calculationUnitId]]$result),
      ApiException = function(ex) ex
    )
    if(!is.null(getCalculationUnitResultResponse$ApiException)){
      cat(getCalculationUnitResultResponse$ApiException$toString())
      stop("Api exception encountered")
    }
    
    if (getCalculationUnitResultResponse$response$status_code != 200) {
      print(paste("Error getting result of SPAR Calculation Unit Id:", calculationUnitId))
      print(paste("x-datadirect-request-key:", getCalculationUnitResultResponse$response$headers$`x-datadirect-request-key`))
      print(paste("Response status code:", getCalculationUnitResultResponse$response$status_code))
      print(paste("Response message:", getCalculationUnitResultResponse$response$content))
      stop("Api invalid response status code encountered")
    }
    
    print(paste("SPAR Calculation Unit Id :", calculationUnitId, "Succeeded!!!"));
    
    package <- read(factset.protobuf.stach.Package, getCalculationUnitResultResponse$content)
    
    stachExtension <- StachExtension$new()
    
    # Converting result to data frame
    SPARTables[[calculationUnitId]] <- stachExtension$convertToDataFrame(package)
    
    # Dump data frame to .csv files
    # stachExtension$generateCSV(package)
  }
}

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
      print(paste("Error getting result of Vault Calculation Unit Id:", calculationUnitId))
      print(paste("x-datadirect-request-key:", getCalculationUnitResultResponse$response$headers$`x-datadirect-request-key`))
      print(paste("Response status code:", getCalculationUnitResultResponse$response$status_code))
      print(paste("Response message:", getCalculationUnitResultResponse$response$content))
      stop("Api invalid response status code encountered")
    }
    
    print(paste("Vault Calculation Unit Id :", calculationUnitId, "Succeeded!!!"));
    
    package <- read(factset.protobuf.stach.Package, getCalculationUnitResultResponse$content)
    
    stachExtension <- StachExtension$new()
    
    # Converting result to data frame
    VaultTables[[calculationUnitId]] <- stachExtension$convertToDataFrame(package)
    
    # Dump data frame to .csv files
    # stachExtension$generateCSV(package)
  }
}

# Printing first 6 records in the first data frame of each engine to console
print(paste("Printing first 6 records in the first data frame of each engine"));
print(head(PATables[[1]][[1]]))
print(head(SPARTables[[1]][[1]]))
print(head(VaultTables[[1]][[1]]))
