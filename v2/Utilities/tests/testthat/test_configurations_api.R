library(httr)

source("../test_constants.R")

context("Test Configurations Api")

configurationsApi <- ConfigurationsApi$new(apiClient = apiClient)

test_that("Configurations Api Test - GetVaultConfigurations", {
  
  response <- configurationsApi$GetVaultConfigurationsWithHttpInfo(account = vault_account$id)
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(class(response$content), "list", info = "Response data should be a list")
  expect_equal(class(response$content[[1]]), c("VaultConfigurationSummary", "R6"), info = "Response data should be list of class VaultConfigurationSummary")
})

test_that("Configurations Api Test - GetVaultConfigurations, GetVaultConfigurationById", {

  response <- configurationsApi$GetVaultConfigurationsWithHttpInfo(account = vault_account$id)
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(class(response$content), "list", info = "Response data should be a list")
  expect_equal(class(response$content[[1]]), c("VaultConfigurationSummary", "R6"), info = "Response data should be list of class VaultConfigurationSummary")
  
  response = configurationsApi$GetVaultConfigurationByIdWithHttpInfo(id = names(response$content)[1])

  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(class(response$content), c("VaultConfiguration", "R6"), info = "Response data should be of class VaultConfiguration")
})
