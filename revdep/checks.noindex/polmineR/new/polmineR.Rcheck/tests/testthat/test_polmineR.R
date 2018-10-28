library(polmineR)

testthat::context("testing polmineR")

test_that(
  "corpora present",
  {
    use("polmineR")
    expect_equal("GERMAPARLMINI" %in% corpus()[["corpus"]], TRUE)
    expect_equal("REUTERS" %in% corpus()[["corpus"]], TRUE)
  }
)
