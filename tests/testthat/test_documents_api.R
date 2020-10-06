library(httr)

source("../test_constants.R")

context("Test Documents Api")

documentsApi <- DocumentsApi$new(apiClient = apiClient)

test_that("Documents Api Test - GetPA3Documents", {
  
  response <- documentsApi$GetPA3DocumentsWithHttpInfo(path = lookup_directory)
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(class(response$content), c("DocumentDirectories", "R6"), info = "Response data should be of class DocumentDirectories")
})

test_that("Documents Api Test - GetSPAR3Documents", {
  
  response <- documentsApi$GetSPAR3DocumentsWithHttpInfo(path = lookup_directory)
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(class(response$content), c("DocumentDirectories", "R6"), info = "Response data should be of class DocumentDirectories")
})

test_that("Documents Api Test - GetVaultDocuments", {
  
  response <- documentsApi$GetVaultDocumentsWithHttpInfo(path = lookup_directory)
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(class(response$content), c("DocumentDirectories", "R6"), info = "Response data should be of class DocumentDirectories")
})
