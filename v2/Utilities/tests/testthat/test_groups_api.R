library(httr)

source("../test_constants.R")

context("Test Groups Api")

groupsApi <- GroupsApi$new(apiClient = apiClient)

test_that("Groups Api Test - GetPAGroups", {

  response = groupsApi$GetPAGroupsWithHttpInfo()

  expect_equal(response$response$status_code, 200, info = "Response status should be 200")
  expect_equal(typeof(response$content), "list", info = "Response data should be a list")
  expect_equal(class(response$content[[1]]), c("Group", "R6"), info = "Response data should of class Group")
})
