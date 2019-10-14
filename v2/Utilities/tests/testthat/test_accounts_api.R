library(httr)

source("../test_constants.R")

context("Test Accounts Api")

accountsApi <- AccountsApi$new(apiClient = apiClient)

test_that("Accounts Api Test - GetAccounts", {
  
  response <- accountsApi$GetAccountsWithHttpInfo(path = lookup_directory)

  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(is.null(response$content), FALSE, info = "Response data should not be NULL")
  expect_equal(class(response$content), c("AccountDirectories", "R6"), info = "Response data should be of class AccountDirectories")
})
