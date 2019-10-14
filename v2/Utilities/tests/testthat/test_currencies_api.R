library(httr)

source("../test_constants.R")

context("Test Currencies Api")

currenciesApi <- CurrenciesApi$new(apiClient = apiClient)

test_that("Currencies Api Test - GetPACurrencies", {

  response = currenciesApi$GetPACurrenciesWithHttpInfo()

  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(class(response$content), "list", info = "Response data should be a list")
  expect_equal(class(response$content[[1]]), c("Currency", "R6"), info = "Response data should be list of class Currency")
})
