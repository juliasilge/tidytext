library(polmineR)

testthat::context("misc")

test_that("count_one_query", {expect_equal(size("REUTERS"), 4050)})

