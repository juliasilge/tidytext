context("Stop words")

suppressPackageStartupMessages(library(dplyr))

test_that("get_quanteda_stopwords works for multiple languages", {

  skip_if_not_installed("quanteda")
  de <- get_quanteda_stopwords("german")
  ru <- get_quanteda_stopwords("russian")

  expect_is(de, "tbl_df")
  expect_is(ru, "tbl_df")
  expect_gt(nrow(de), nrow(ru))
  expect_equal(unique(de$lexicon), "quanteda")

})
