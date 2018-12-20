library(polmineR)
use("polmineR")
testthat::context("as.TermDocumentMatrix")

test_that(
  "generate as.TermDocumentMatrix from corpus",
  {
    dtm <- as.DocumentTermMatrix("REUTERS", p_attribute = "word", sAttribute = "id")
    expect_equal(
      length(sAttributes("REUTERS", "id")), dim(dtm)[1]
    )
    expect_equal(
      polmineR:::CQI$lexicon_size("REUTERS", "word"), dim(dtm)[2]
    )
    expect_equal(sum(dtm[,"is"]), count("REUTERS", "is")[["count"]])
  }
)

