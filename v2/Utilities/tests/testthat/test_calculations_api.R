library(httr)
library(factset.protobuf.stach)

source("../test_constants.R")

context("Test Calculations Api")

componentsApi <- ComponentsApi$new(apiClient = apiClient)
configurationsApi <- ConfigurationsApi$new(apiClient = apiClient)
calculationsApi <- CalculationsApi$new(apiClient = apiClient)
utilityApi <- UtilityApi$new(apiClient = apiClient)

runCalculation <- function() {
  # Build PA Calculation Parameters List ----------------
  paComponents <- componentsApi$GetPAComponents(document = pa_document)
  paComponentId <- names(paComponents[1])
  paCalculationParamsList <- list(
    "1" = PACalculationParameters$new(
      componentid = paComponentId, 
      accounts = list(pa_account1, pa_account2), 
      benchmarks = list(pa_benchmark1), 
      dates = pa_dates
    )
  )
  
  # Build SPAR Calculation Parameters List ----------------
  sparComponents <- componentsApi$GetSPARComponents(document = spar_document)
  sparComponentId <- names(sparComponents[1])
  sparCalculationParamsList <- list(
    "2" = SPARCalculationParameters$new(
      componentid = sparComponentId, 
      accounts = list(spar_account1, spar_account2), 
      benchmark = spar_benchmark, 
      dates = spar_dates
    )
  )
  
  # Build Vault Calculation Parameters List ----------------
  vaultComponents <- componentsApi$GetVaultComponents(document = vault_document)
  vaultComponentId <- names(vaultComponents[1])
  vaultConfigurations <- configurationsApi$GetVaultConfigurations(account = vault_account$id)
  vaultConfigId <- names(vaultConfigurations[1])
  vaultCalculationParamsList <- list(
    "3" = VaultCalculationParameters$new(
      componentid = vaultComponentId,
      account = vault_account,
      dates = vault_dates,
      configid = vaultConfigId
    )
  )
  
  # Create Calculation Request ----------------
  calculation <- Calculation$new(
    pa = paCalculationParamsList, 
    spar = sparCalculationParamsList, 
    vault = vaultCalculationParamsList
  )
  
  createResponse <- calculationsApi$RunCalculationWithHttpInfo(calculation = calculation)
  return(createResponse)
}

testCalculationStatuses <- function(calculationStatuses) {
  if(is.null(calculationStatuses)) {
    return  
  }
  
  expect_equal(FALSE %in% lapply(calculationStatuses, 
                                 function(calculation){ 
                                   return(calculation$status == "Success") 
                                 }), 
               FALSE, 
               info = paste("Status response data should have all calculations statuses as success")
  )
  
  expect_equal(FALSE %in% lapply(calculationStatuses, 
                                 function(calculation){ 
                                   return(!is.null(calculation$result)) 
                                 }), 
               FALSE, 
               info = paste("Status response data should have all calculation results")
  )
  
  for (calculationId in names(calculationStatuses)) {
    resultResponse <- utilityApi$GetByUrlWithHttpInfo(url = calculationStatuses[[calculationId]]$result)
    
    expect_equal(resultResponse$response$status_code, 200, info = "Result response status code should be 200")
    expect_equal(is.null(resultResponse$content), FALSE, info = "Status response body should not be NULL")
    
    package <- read(factset.protobuf.stach.Package, resultResponse$content)
    
    expect_equal(package@type, "factset.protobuf.stach.Package", info = "Result response data should be of type Package")
  }
}

test_that("Calculations Api Test - RunCalculation, GetCalculationById, GetByUrl", {
  
  createResponse <- runCalculation()
  
  expect_equal(createResponse$response$status_code, 202, info = "Create response status code should be 202")
  expect_equal(createResponse$content, NULL, info = "Create response body should be NULL")
  
  locationList <- strsplit(createResponse$response$headers$location, split = "/")
  calculationRequestId <- tail(unlist(locationList), n = 1)
  
  expect_equal(is.null(calculationRequestId), FALSE, info = "Create response calculation id should be present")
  
  statusResponse <- calculationsApi$GetCalculationStatusByIdWithHttpInfo(id = calculationRequestId)
  
  while (statusResponse$response$status_code == 200
         && (statusResponse$content$status == "Queued" || statusResponse$content$status == "Executing")) {
    maxAge <- 5
    if ("cache-control" %in% names(statusResponse$response$headers)) {
      maxAge <- as.numeric(unlist(strsplit(statusResponse$response$headers$`cache-control`, "="))[2])
    }
    print(paste("Sleeping:", maxAge, "secs"))
    Sys.sleep(maxAge)
    
    statusResponse <- calculationsApi$GetCalculationStatusByIdWithHttpInfo(id = calculationRequestId)
  }
  
  expect_equal(statusResponse$response$status_code, 200, info = "Status response status code should be 200")
  expect_equal(is.null(statusResponse$content), FALSE, info = "Status response body should not be NULL")
  expect_equal(class(statusResponse$content), c("CalculationStatus", "R6"), info = "Status response data should be of class CalculationStatus")
  expect_equal(statusResponse$content$status, "Completed", info = "Status response data should have calculation status as completed")
  
  testCalculationStatuses(statusResponse$content$pa)
  testCalculationStatuses(statusResponse$content$spar)
  testCalculationStatuses(statusResponse$content$vault)
})


test_that("Calculations Api Test - RunCalculation, CancelCalculationById ", {

  createResponse <- runCalculation()
  
  expect_equal(createResponse$response$status_code, 202, info = "Create response status code should be 202")
  expect_equal(createResponse$content, NULL, info = "Create response body should be NULL")
  
  locationList <- strsplit(createResponse$response$headers$location, split = "/")
  calculationRequestId <- tail(unlist(locationList), n = 1)
  
  expect_equal(is.null(calculationRequestId), FALSE, info = "Create response calculation id should be present")
  
  cancelResponse = calculationsApi$CancelCalculationByIdWithHttpInfo(id = calculationRequestId)

  expect_equal(cancelResponse$response$status_code, 204, info = "Cancel response status code should be 204")
  expect_equal(cancelResponse$content, NULL, info = "Cancel response body should be NULL")

})

test_that("Calculations Api Test - RunCalculation, GetCalculationStatusSummaries ", {

  createResponse <- runCalculation()
  
  expect_equal(createResponse$response$status_code, 202, info = "Create response status code should be 202")
  expect_equal(createResponse$content, NULL, info = "Create response body should be NULL")
  
  locationList <- strsplit(createResponse$response$headers$location, split = "/")
  calculationRequestId <- tail(unlist(locationList), n = 1)
  
  expect_equal(is.null(calculationRequestId), FALSE, info = "Create response calculation id should be present")

  allCalculationsResponse = calculationsApi$GetCalculationStatusSummariesWithHttpInfo()
  
  expect_equal(allCalculationsResponse$response$status_code, 200, info = "Get All response status code should be 200")
  expect_equal(typeof(allCalculationsResponse$content), "list", info = "Get All response body should be type list")
  expect_equal(calculationRequestId %in% names(allCalculationsResponse$content), TRUE, info = "Get All response data does not include the created calculation")
  
  cancelResponse = calculationsApi$CancelCalculationByIdWithHttpInfo(id = calculationRequestId)
  
  expect_equal(cancelResponse$response$status_code, 204, info = "Cancel response status code should be 204")
  expect_equal(cancelResponse$content, NULL, info = "Cancel response body should be NULL")
})
