context("pairwise_similarity")

suppressPackageStartupMessages(library(dplyr))

d <- data_frame(col = rep(c("a", "b", "c"), each = 3),
                row = rep(c("d", "e", "f"), 3),
                value = c(1, 2, 3, 6, 5, 4, 7, 9, 8))

cosine_similarity <- function(x, y) {
  sum(x * y) / (sqrt(sum(x^2)) * sqrt(sum(y^2)))
}

test_that("pairwise_similarity computes pairwise cosine similarity", {
  ret <- d %>%
    pairwise_similarity(col, row, value)

  ret1 <- ret$similarity[ret$item1 == "a" & ret$item2 == "b"]
  expect_equal(ret1, cosine_similarity(1:3, 6:4))

  ret2 <- ret$similarity[ret$item1 == "b" & ret$item2 == "c"]
  expect_equal(ret2, cosine_similarity(6:4, c(7, 9, 8)))

  expect_equal(sum(ret$item1 == ret$item2), 0)
})

test_that("pairwise_similarity retains factor levels", {
  d$col <- factor(d$col, levels = c("b", "c", "a"))

  ret <- d %>%
    pairwise_similarity(col, row, value)

  expect_is(ret$item1, "factor")
  expect_is(ret$item2, "factor")
  expect_equal(levels(ret$item1), c("b", "c", "a"))
  expect_equal(levels(ret$item2), c("b", "c", "a"))
})
