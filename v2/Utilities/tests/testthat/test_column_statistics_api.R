library(httr)

source("../test_constants.R")

context("Test Column Statistics Api")

columnStatisticsApi <- ColumnStatisticsApi$new(apiClient = apiClient)

test_that("Column Statistics Api Test - GetPAColumnStatistics", {

  response <- columnStatisticsApi$GetPAColumnStatisticsWithHttpInfo()

  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(class(response$content), "list", info = "Response data should be a list")
  expect_equal(class(response$content[[1]]), c("ColumnStatistic", "R6"), info = "Response data should be list of class ColumnStatistic")
})