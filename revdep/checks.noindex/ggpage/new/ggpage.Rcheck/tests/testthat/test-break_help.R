context("test-break_help.R")

test_that("break_help returns a integer vector.", {
  expect_equal(is.numeric(break_help(c(1, 2, 3))), TRUE)
  expect_equal(is.list(break_help(c(1, 2, 3))), FALSE)
})

test_that("break_help returns the right length.", {
  a <- 1
  b <- 1:2
  c <- 1:100

  expect_equal(length(break_help(a)), sum(a))
  expect_equal(length(break_help(b)), sum(b))
  expect_equal(length(break_help(c)), sum(c))
})

test_that("break_help returns the right values", {
  a <- 1
  b <- 1:2
  c <- 1:100

  expect_equal(as.numeric(table(break_help(a))), a)
  expect_equal(as.numeric(table(break_help(b))), b)
  expect_equal(as.numeric(table(break_help(c))), c)
})
