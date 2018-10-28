context("test-para_index.R")

test_that("break_help returns a integer vector.", {
  n <- 100
  expect_equal(is.numeric(para_index(n, FUN = rpois, lambda = 10)), TRUE)
  expect_equal(is.list(para_index(n, FUN = rpois, lambda = 10)), FALSE)
})

test_that("Returns output of correct length.", {
  n <- 100
  expect_equal(sum(para_index(n, FUN = rpois, lambda = 10)), n)
})
