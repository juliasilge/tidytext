context("cor_sparse")

library(Matrix)

test_that("cor_sparse returns the same results as cor(as.matrix(m))", {
  m <- Matrix(0, nrow = 100000, ncol = 6)

  ind <- cbind(sample(100000, 1000, replace = TRUE),
               sample(6, 1000, replace = TRUE))
  m[ind] <- rnorm(1000)

  co1 <- cor(as.matrix(m))
  co2 <- cor_sparse(m)

  expect_is(co2, "matrix")
  expect_is(c(co2), "numeric")
  expect_equal(dim(co2), c(6, 6))
  expect_equal(c(co1), c(co2))
})
