library(polmineR)
testthat::context("decode")
use("polmineR")


test_that(
  "get size of corpus",
  expect_equal(size("GERMAPARLMINI"), 222201)
)


test_that(
  "size of corpus, split by one s-attribute",
  {
    y <- size("GERMAPARLMINI", sAttribute = "date")
    expect_equal(sum(y[["size"]]), size("GERMAPARLMINI"))
    expect_equal(nrow(y), length(sAttributes("GERMAPARLMINI", "date")))
    expect_equal(y[["size"]][1:3], c(9341, 2793, 68316))
    
  }
)

test_that(
  "size of corpus, two s-attributes",
  {
    y <- size("GERMAPARLMINI", sAttribute = c("date", "party"))
    expect_equal(length(unique(y[["party"]])), 6)
    expect_equal(sum(y[["size"]]), size("GERMAPARLMINI"))
    expect_equal(y[["size"]][1:3], c(17,71,25))
  }
)

test_that(
  "size of partition",
  {
    P <- partition("GERMAPARLMINI", date = "2009-11-11")
    expect_equal(size(P), 117614)
    expect_equal(sum(size(P, sAttribute = "speaker")[["size"]]), size(P))
    expect_equal(sum(size(P, sAttribute = c("speaker", "party"))[["size"]]), size(P))
  }
)

