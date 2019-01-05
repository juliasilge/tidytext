context("Reorder within")

suppressPackageStartupMessages(library(ggplot2))

test_that("Can reorder within", {
  mtcars_reordered <- reorder_within(mtcars$cyl,
                                     mtcars$mpg,
                                     mtcars$vs)

  expect_is(mtcars_reordered, "factor")
  expect_equal(length(levels(mtcars_reordered)), 5)
})


test_that("Can make a plot", {
  p <- ggplot(mtcars, aes(reorder_within(vs, mpg, cyl), mpg)) +
    geom_boxplot() +
    scale_x_reordered() +
    facet_wrap(~ cyl, scales = "free_x")

  expect_is(p, "ggplot")
  vdiffr::expect_doppelganger("reordered boxplot", p)

})
