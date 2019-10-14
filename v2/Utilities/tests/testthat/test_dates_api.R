library(httr)

source("../test_constants.R")

context("Test Dates Api")

componentsApi <- ComponentsApi$new(apiClient = apiClient)
datesApi <- DatesApi$new(apiClient = apiClient)

test_that("Dates Api Test - ConvertPADatesToAbsoluteFormat", {
  
  response = componentsApi$GetPAComponentsWithHttpInfo(document = pa_document)
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(typeof(response$content), "list", info = "Response data should be a list")
  expect_equal(class(response$content[[1]]), c("ComponentSummary", "R6"), info = "Response data should contain a list of class type ComponentSummary")
  
  response = datesApi$ConvertPADatesToAbsoluteFormatWithHttpInfo(startdate = start_date, enddate = end_date, componentid = names(response$content)[1], account = account)

  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(class(response$content), c("DateParametersSummary", "R6"), info = "Response data should be of class DateParametersSummary")
})

test_that("Dates Api Test - ConvertVaultDatesToAbsoluteFormat", {
  
  response = componentsApi$GetVaultComponentsWithHttpInfo(document = vault_document)
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(typeof(response$content), "list", info = "Response data should be a list")
  expect_equal(class(response$content[[1]]), c("ComponentSummary", "R6"), info = "Response data should contain a list of class type ComponentSummary")
  
  response = datesApi$ConvertVaultDatesToAbsoluteFormatWithHttpInfo(startdate = start_date, enddate = end_date, componentid = names(response$content)[1], account = account)
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(class(response$content), c("DateParametersSummary", "R6"), info = "Response data should be of class DateParametersSummary")
})
