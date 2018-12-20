context("Load packages from GitHub")

test_that("Can find ", {
  expect_false(available_on_github("svrepmisc")$available)
})

test_that("Can't find made up package", {
  expect_true(available_on_github("This_is_not_a_pkg")$available)
})
