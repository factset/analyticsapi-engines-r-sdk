library(httr)

source("../test_constants.R")

context("Test Columns Api")

columnsApi <- ColumnsApi$new(apiClient = apiClient)

test_that("Columns Api Test - GetPAColumns", {
  
  response <- columnsApi$GetPAColumnsWithHttpInfo()
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(class(response$content), "list", info = "Response data should be a list")
  expect_equal(class(response$content[[1]]), c("ColumnSummary", "R6"), info = "Response data should be list of class ColumnSummary")
})

test_that("Columns Api Test - GetPAColumns, getPAColumnById", {
  
  response <- columnsApi$GetPAColumnsWithHttpInfo()
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(class(response$content), "list", info = "Response data should be a list")
  expect_equal(class(response$content[[1]]), c("ColumnSummary", "R6"), info = "Response data should be list of class ColumnSummary")
  
  response <- columnsApi$GetPAColumnByIdWithHttpInfo(id = names(response$content)[1])
  
  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(class(response$content), c("Column", "R6"), info = "Response data should be of class Column")
})