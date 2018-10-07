context("pairwise_dist")

suppressPackageStartupMessages(library(dplyr))

test_that("pairwise_dist computes a distance matrix", {
  d <- data.frame(col = rep(c("a", "b", "c"), each = 3),
                  row = rep(c("d", "e", "f"), 3),
                  value = c(1, 2, 3, 6, 5, 4, 7, 9, 8))

  ret <- d %>%
    pairwise_dist(col, row, value)

  ret1 <- ret$distance[ret$item1 == "a" & ret$item2 == "b"]
  expect_equal(ret1, sqrt(sum((1:3 - 6:4) ^ 2)))

  ret2 <- ret$distance[ret$item1 == "b" & ret$item2 == "c"]
  expect_equal(ret2, sqrt(sum((6:4 - c(7, 9, 8)) ^ 2)))

  expect_equal(sum(ret$item1 == ret$item2), 0)
})
