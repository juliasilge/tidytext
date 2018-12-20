context("Load packages from CRAN")

test_that("Can find dplyr", {
  expect_false(available_on_cran("dplyr"))
})

test_that("Can't find made up package", {
  expect_true(available_on_cran("This_is_not_a_pkg"))
})

