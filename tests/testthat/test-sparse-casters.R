context("Sparse casters")

library(Matrix)

dat <- data_frame(a = c("row1", "row1", "row2", "row2", "row2"),
                  b = c("col1", "col2", "col1", "col3", "col4"),
                  val = 1:5)

test_that("Can cast tables into a sparse Matrix", {
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

test_that("cast_sparse ignores groups", {
  m <- cast_sparse(dat, a, b)
  m2 <- cast_sparse(group_by(dat, a), a, b)

  expect_identical(m, m2)
})

test_that("Can cast tables into a sparse DocumentTermMatrix", {
  if (require("tm", quietly = TRUE)) {
    d <- cast_dtm(dat, a, b, val)
    expect_is(d, "DocumentTermMatrix")
    expect_equal(dim(d), c(2, 4))
    expect_equal(sort(tm::Docs(d)), sort(unique(dat$a)))
    expect_equal(sort(tm::Terms(d)), sort(unique(dat$b)))
    expect_equal(as.numeric(as.matrix(d[1:2, 1:2])), c(1, 3, 2, 0))
    expect_equal(as.numeric(as.matrix(d[2, 3])), 4)
  }
})

test_that("Can cast tables into a sparse TermDocumentMatrix", {
  if (require("tm", quietly = TRUE)) {
    d <- cast_tdm(dat, b, a, val)
    expect_is(d, "TermDocumentMatrix")

    expect_equal(dim(d), c(4, 2))
    expect_equal(sort(tm::Terms(d)), sort(unique(dat$b)))
  }
})

test_that("Can cast tables into a sparse dfm", {
  library(methods)
  if (requireNamespace("quanteda", quietly = TRUE)) {
    # tm package examples
    data("data_corpus_inaugural", package = "quanteda")

    d <- cast_dfm(dat, a, b, val)
    expect_is(d, "dfmSparse")
    expect_equal(dim(d), c(2, 4))
    expect_equal(as.numeric(d[1, 1]), 1)
    expect_equal(as.numeric(d[2, 3]), 4)
  }

})
