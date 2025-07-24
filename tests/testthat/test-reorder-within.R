skip_if_not_installed("ggplot2")
suppressPackageStartupMessages(library(ggplot2))

test_that("Can reorder within", {
  mtcars_reordered <- reorder_within(mtcars$cyl, mtcars$mpg, mtcars$vs)

  expect_s3_class(mtcars_reordered, "factor")
  expect_equal(length(levels(mtcars_reordered)), 5)
})

test_that("Can reorder within multiple variables", {
  mtcars_reordered <- reorder_within(
    mtcars$cyl,
    mtcars$mpg,
    list(mtcars$vs, mtcars$am)
  )

  expect_s3_class(mtcars_reordered, "factor")
  expect_equal(length(levels(mtcars_reordered)), 7)
})

test_that("Can make a plot", {
  p <- ggplot(mtcars, aes(reorder_within(vs, mpg, cyl), mpg)) +
    geom_boxplot() +
    scale_x_reordered() +
    facet_wrap(~cyl, scales = "free_x")

  expect_s3_class(p, "ggplot")
  vdiffr::expect_doppelganger("reordered boxplot", p)
})

test_that("Can make a plot with custom labels", {
  custom_labeler <- function(x) {
    x %>%
      stringr::str_replace("___[0-9]+$", "") %>%
      stringr::str_replace("0", "ZERO")
  }

  p <- ggplot(mtcars, aes(reorder_within(vs, mpg, cyl), mpg)) +
    geom_boxplot() +
    scale_x_reordered(labels = custom_labeler) +
    facet_wrap(~cyl, scales = "free_x")

  expect_s3_class(p, "ggplot")
  vdiffr::expect_doppelganger("custom label boxplot", p)
})

test_that("Can make a multi-facet plot", {
  expect_doppelganger <- function(title, fig, ...) {
    testthat::skip_if_not_installed("vdiffr")
    vdiffr::expect_doppelganger(title, fig, ...)
  }

  p <- ggplot(mtcars, aes(reorder_within(carb, mpg, list(vs, am)), mpg)) +
    geom_boxplot() +
    scale_x_reordered() +
    facet_wrap(vs ~ am, scales = "free_x")

  expect_s3_class(p, "ggplot")
  expect_doppelganger("reordered multi-facet boxplot", p)
})
