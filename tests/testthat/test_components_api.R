library(httr)

source("../test_constants.R")

context("Test Components Api")

componentsApi <- ComponentsApi$new(apiClient = apiClient)

test_that("Components Api Test - GetPAComponents", {
  
  response = componentsApi$GetPAComponentsWithHttpInfo(document = pa_document)
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(typeof(response$content), "list", info = "Response data should be a list")
  expect_equal(class(response$content[[1]]), c("ComponentSummary", "R6"), info = "Response data should contain a list of class type ComponentSummary")
})


test_that("Components Api Test - GetPAComponents, GetPAComponentById", {
  
  response = componentsApi$GetPAComponentsWithHttpInfo(document = pa_document)
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(typeof(response$content), "list", info = "Response data should be a list")
  expect_equal(class(response$content[[1]]), c("ComponentSummary", "R6"), info = "Response data should contain a list of class type ComponentSummary")
  
  response = componentsApi$GetPAComponentByIdWithHttpInfo(id = names(response$content)[1])

  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(class(response$content), c("PAComponent","R6"), info = "Response data should be of class PAComponent")
})


test_that("Components Api Test - GetSPARComponents", {
  
  response = componentsApi$GetSPARComponentsWithHttpInfo(document = spar_document)
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(typeof(response$content), "list", info = "Response data should be a list")
  expect_equal(class(response$content[[1]]), c("ComponentSummary", "R6"), info = "Response data should contain a list of class type ComponentSummary")
})


test_that("Components Api Test - GetVaultComponents", {
  
  response = componentsApi$GetVaultComponentsWithHttpInfo(document = vault_document)
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(typeof(response$content), "list", info = "Response data should be a list")
  expect_equal(class(response$content[[1]]), c("ComponentSummary", "R6"), info = "Response data should contain a list of class type ComponentSummary")
})


test_that("Components Api Test - GetVaultComponents, GetVaultComponentById", {
  
  response = componentsApi$GetVaultComponentsWithHttpInfo(document = vault_document)
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(typeof(response$content), "list", info = "Response data should be a list")
  expect_equal(class(response$content[[1]]), c("ComponentSummary", "R6"), info = "Response data should contain a list of class type ComponentSummary")
  
  response = componentsApi$GetVaultComponentByIdWithHttpInfo(id = names(response$content)[1])
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(class(response$content), c("VaultComponent","R6"), info = "Response data should be of class VaultComponent")
})
