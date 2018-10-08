library(polmineR)
testthat::context("decode")
use("polmineR")


test_that(
  "decode entire corpus",
  {
    dt <- decode("GERMAPARLMINI")
    expect_equal(ncol(dt), 7)
    expect_equal(nrow(dt), 222201)
    expect_equal(dt[["word"]][1:6], c("Guten", "Morgen", ",", "meine", "sehr", "verehrten"))
    expect_equal(length(unique(dt[["date"]])), 5)
  }
)

test_that(
  "decode one structural attribute",
  {
    dt <- decode("GERMAPARLMINI", sAttribute = "date")
    expect_equal(length(unique(dt[["date"]])), 5)
    expect_equal(sum(dt[["cpos_left"]]), 540378099)
  }
)

test_that(
  "decode several structural attributes",
  {
    dt <- decode("GERMAPARLMINI", sAttribute = c("date", "speaker"))
    expect_equal(ncol(dt), 4)
    expect_equal(length(unique(dt[["speaker"]])), 124)
  }
)
