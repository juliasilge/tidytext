library(kdtools)
context("Sorting")

check_median <- function(x, j = 1) {
  if (nrow(x) == 1) return(TRUE)
  i <- nrow(x) %/% 2 + 1
  if (x[i, j] != sort(x[, j])[i]) return(FALSE)
  left_ans <- ifelse(i > 1, check_median(x[1:(i - 1), , drop = FALSE], j %% ncol(x) + 1), TRUE)
  right_ans <- ifelse(i < nrow(x), check_median(x[(i + 1):nrow(x), , drop = FALSE], j %% ncol(x) + 1), TRUE)
  return(left_ans & right_ans)
}

test_that("sort works on single point", {
  for (i in c(0, 10))
    expect_error(kd_sort(matrix(i, nc = i)))
  for (i in 1:9)
    expect_equal(kd_sort(matrix(i, nc = i)), matrix(i, nc = i))
})

test_that("handles ties", {
  x <- rnorm(10)
  expect_equal(kd_sort(cbind(0, x)), cbind(0, sort(x)))
  expect_equal(kd_sort(cbind(0, 1, x)), cbind(0, 1, sort(x)))
  expect_equal(kd_sort(cbind(0, 1, 2, x)), cbind(0, 1, 2, sort(x)))
  expect_equal(kd_sort(cbind(0, x, 1)), cbind(0, sort(x), 1))
})

test_that("correct sort order", {
  nr <- 1e2
  for (nc in 1:9)
  {
    x <- matrix(runif(nr * nc), nr)
    y <- kd_sort(x)
    expect_false(kd_is_sorted(x))
    expect_true(kd_is_sorted(y))
    expect_false(check_median(x))
    expect_true(check_median(y))
  }
})
