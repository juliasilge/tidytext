context("Reorder within")

suppressPackageStartupMessages(library(ggplot2))

test_that("Can reorder within", {
  mtcars_reordered <- reorder_within(mtcars$cyl,
                                     mtcars$mpg,
                                     mtcars$vs)

  expect_is(mtcars_reordered, "factor")
  expect_equal(length(levels(mtcars_reordered)), 5)
})

test_that("Can reorder within multiple variables", {
  mtcars_reordered <- reorder_within(mtcars$cyl,
                                     mtcars$mpg,
                                     list(mtcars$vs, mtcars$am))

  expect_is(mtcars_reordered, "factor")
  expect_equal(length(levels(mtcars_reordered)), 7)
})

test_that("Can make a plot", {
  p <- ggplot(mtcars, aes(reorder_within(vs, mpg, cyl), mpg)) +
    geom_boxplot() +
    scale_x_reordered() +
    facet_wrap(~ cyl, scales = "free_x")

  expect_is(p, "ggplot")
  vdiffr::expect_doppelganger("reordered boxplot", p)

})

test_that("Can make a multi-facet plot", {

  expect_doppelganger <- function(title, fig, path = NULL, ...) {
    testthat::skip_if_not_installed("vdiffr")
    vdiffr::expect_doppelganger(title, fig, path = path, ...)
  }

  p <- ggplot(mtcars, aes(reorder_within(carb, mpg, list(vs, am)), mpg)) +
    geom_boxplot() +
    scale_x_reordered() +
    facet_wrap(vs ~ am, scales = "free_x")

  expect_is(p, "ggplot")
  expect_doppelganger("reordered multi-facet boxplot", p)
})

