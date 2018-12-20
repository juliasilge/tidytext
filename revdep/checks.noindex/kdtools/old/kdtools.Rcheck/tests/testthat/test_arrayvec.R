library(kdtools)
context("Arrayvec")

test_that("Arrayvec works", {
  nr <- 1e4
  for (nc in 1:9)
  {
    x <- matrix(1:(nc * nr), nr)
    y <- matrix_to_tuples(x)
    expect_equal(dim(x), dim(y))
    expect_equal(ncol(y), nc)
    expect_equal(nrow(y), nr)
    expect_equal(x[1, ], y[1, ])
    expect_equal(x[, 1], y[, 1])
    expect_equal(x[nr, ], y[nr, ])
    expect_equal(x[, nc], y[, nc])
    i <- sample(1:nr, 3, replace = TRUE)
    j <- sample(1:nc, 3, replace = TRUE)
    expect_equal(x[i, j], y[i, j])
    z <- tuples_to_matrix(y)
    expect_equal(x, z)
  }
})
