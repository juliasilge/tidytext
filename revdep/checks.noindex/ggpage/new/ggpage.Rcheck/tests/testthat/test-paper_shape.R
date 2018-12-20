context("test-paper_shape.R")

test_that("The number of rows and cols are correct", {
  expect_equal(NROW(paper_shape(ggpage_build(tinderbox))), 9)
  expect_equal(names(paper_shape(ggpage_build(tinderbox))),
               c("page", "xmin", "xmax", "ymin", "ymax"))
})
