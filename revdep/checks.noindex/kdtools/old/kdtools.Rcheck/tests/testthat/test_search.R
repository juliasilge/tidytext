library(kdtools)
context("Searching")

r_lower_bound <- function(x, y) {
  for (i in 1:nrow(x))
    if (all(x[i, ] >= y)) return(i)
  return(as.integer(NA))
}

test_that("correct lower bound", {
  for (ignore in 1:10)
  {
    for (n in 1:9)
    {
      x <- kd_sort(matrix(runif(n * 100), ncol = n))
      y <- rep(0.5, n)
      i <- kd_lower_bound(x, y)
      j <- r_lower_bound(x, y)
      expect_equal(i, j)
    }
  }
})

r_upper_bound <- function(x, y) {
  for (i in 1:nrow(x))
    if (all(x[i, ] > y)) return(i)
  return(as.integer(NA))
}

test_that("correct upper bound", {
  for (ignore in 1:10)
  {
    for (n in 1:9)
    {
      x <- kd_sort(matrix(runif(n * 100), ncol = n))
      y <- rep(0.5, n)
      i <- kd_upper_bound(x, y)
      j <- r_upper_bound(x, y)
      expect_equal(i, j)
    }
  }
})

r_contains <- function(x, a, b) {
  res <- matrix(nrow = 0, ncol = ncol(x))
  for (i in 1:nrow(x))
    if (all(x[i, ] >= a) && all(x[i, ] < b)) {
      res <- rbind(res, x[i, ])
    }
  return(res)
}

test_that("range query works", {
  for (ignore in 1:10)
  {
    for (n in 1:9)
    {
      x <- matrix(runif(n * 100), ncol = n)
      y <- kd_sort(x)
      l <- rep(0.25, n)
      u <- rep(0.75, n)
      z1 <- kd_range_query(y, l, u)
      z2 <- r_contains(x, l, u)
      z1 <- kd_sort(z1)
      z2 <- kd_sort(z2)
      expect_equal(z1, z2)
    }
  }
})

r_search <- function(x, y) {
  for (i in 1:nrow(x))
    if (all(x[i, ] == y)) {
      return(TRUE)
    }
  return(FALSE)
}

test_that("binary search works", {
  for (ignore in 1:10)
  {
    for (n in 1:9)
    {
      x <- kd_sort(matrix(runif(n * 100), ncol = n))
      y <- x[sample(1:nrow(x), 1), , drop = FALSE]
      expect_equal(r_search(x, y), kd_binary_search(x, y))
      expect_equal(r_search(x, rep(-1, n)), kd_binary_search(x, rep(-1, n)))
    }
  }
})
