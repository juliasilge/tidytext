library(testthat)

context("Loading packages")

test_that('loaded packages', {
  loaded <- names(sessionInfo()$otherPkgs)
  expect_true(
    all(tidymodels:::core %in% loaded)
  )
})


test_that('should not be loaded', {
  loaded <- names(sessionInfo()$otherPkgs)
  expect_true(
    all(!(c("rlang", "tidyselect") %in% loaded))
  )
})
