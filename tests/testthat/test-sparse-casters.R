context("Sparse casters")

library(Matrix)

test_that("Can cast tables into a sparse Matrix", {
  dat <- data_frame(a = c("row1", "row1", "row2", "row2", "row2"),
                    b = c("col1", "col2", "col1", "col3", "col4"),
                    val = 1:5)

  m <- cast_sparse(dat, a, b)
  m2 <- cast_sparse_(dat, "a", "b")

  expect_is(m, "dgCMatrix")
  expect_equal(m, m2)
  expect_equal(sum(m), 5)

  expect_equal(nrow(m), length(unique(dat$a)))
  expect_equal(ncol(m), length(unique(dat$b)))

  m3 <- cast_sparse(dat, a, b, val)

  expect_equal(sum(m3), sum(dat$val))
  expect_equal(m3["row2", "col3"], 4)
})
