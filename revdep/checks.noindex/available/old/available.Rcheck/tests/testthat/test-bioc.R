context("Load packages from Bioconductor")

test_that("Can find dplyr", {
  expect_false(available_on_bioc("ACME"))
})

test_that("Can't find made up package", {
  expect_true(available_on_bioc("This_is_not_a_pkg"))
})

