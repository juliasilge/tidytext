context("Sparse casters")

library(Matrix)

dat <- tibble(
  a = c("row1", "row1", "row2", "row2", "row2"),
  b = c("col1", "col2", "col1", "col3", "col4"),
  val = 1:5
)

test_that("Can cast tables into a sparse Matrix", {
  m <- cast_sparse(dat, a, b)
  m2 <- cast_sparse(dat, "a", "b")

  expect_is(m, "dgCMatrix")
  expect_equal(m, m2)
  expect_equal(sum(m), 5)

  expect_equal(nrow(m), length(unique(dat$a)))
  expect_equal(ncol(m), length(unique(dat$b)))

  m3 <- cast_sparse(dat, a, b, val)

  expect_equal(sum(m3), sum(dat$val))
  expect_equal(m3["row2", "col3"], 4)
})

test_that("cast_sparse ignores groups", {
  m <- cast_sparse(dat, a, b)
  m2 <- cast_sparse(group_by(dat, a), a, b)

  expect_identical(m, m2)
})

test_that("Can cast_sparse with tidyeval", {
  m <- cast_sparse(dat, a, b)
  rowvar <- quo("a")
  m2 <- cast_sparse(dat, !!rowvar, b)

  expect_identical(m, m2)
})


test_that("Can cast tables into a sparse DocumentTermMatrix", {
  skip_if_not_installed("tm")
  d <- cast_dtm(dat, a, b, val)
  d2 <- cast_dtm(dat, "a", "b", "val")
  expect_equal(d, d2)
  expect_is(d, "DocumentTermMatrix")
  expect_equal(dim(d), c(2, 4))
  expect_equal(sort(tm::Docs(d)), sort(unique(dat$a)))
  expect_equal(sort(tm::Terms(d)), sort(unique(dat$b)))
  expect_equal(as.numeric(as.matrix(d[1:2, 1:2])), c(1, 3, 2, 0))
  expect_equal(as.numeric(as.matrix(d[2, 3])), 4)
})

test_that("Can cast tables into a sparse TermDocumentMatrix", {
  skip_if_not_installed("tm")
  d <- cast_tdm(dat, b, a, val)
  d2 <- cast_tdm(dat, "b", "a", "val")
  expect_equal(d, d2)
  expect_is(d, "TermDocumentMatrix")

  expect_equal(dim(d), c(4, 2))
  expect_equal(sort(tm::Terms(d)), sort(unique(dat$b)))
})

test_that("Can cast tables into a sparse dfm", {
  skip_if_not_installed("quanteda")

  library(methods)
  d <- cast_dfm(dat, a, b, val)
  d2 <- cast_dfm(dat, "a", "b", "val")
  expect_equal(d, d2)
  expect_true(quanteda::is.dfm(d))
  expect_equal(dim(d), c(2, 4))
  expect_equal(as.numeric(d[1, 1]), 1)
  expect_equal(as.numeric(d[2, 3]), 4)
})
