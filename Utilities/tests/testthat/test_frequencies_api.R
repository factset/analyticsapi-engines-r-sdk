library(httr)

source("../test_constants.R")

context("Test Frequencies Api")

frequenciesApi <- FrequenciesApi$new(apiClient = apiClient)

test_that("Frequencies Api Test - GetPAFrequencies", {
  
  response = frequenciesApi$GetPAFrequenciesWithHttpInfo()
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(typeof(response$content), "list", info = "Response data should be a list")
  expect_equal(class(response$content[[1]]), c("Frequency", "R6"), info = "Response data should of class Frequency")
})

test_that("Frequencies Api Test - GetSPARFrequencies", {
  
  response = frequenciesApi$GetSPARFrequenciesWithHttpInfo()
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(typeof(response$content), "list", info = "Response data should be a list")
  expect_equal(class(response$content[[1]]), c("Frequency", "R6"), info = "Response data should of class Frequency")
})

test_that("Frequencies Api Test - GetVaultFrequencies", {
  
  response = frequenciesApi$GetVaultFrequenciesWithHttpInfo()
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(typeof(response$content), "list", info = "Response data should be a list")
  expect_equal(class(response$content[[1]]), c("Frequency", "R6"), info = "Response data should of class Frequency")
})
