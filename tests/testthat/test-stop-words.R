suppressPackageStartupMessages(library(dplyr))

test_that("get_stopwords works for multiple languages", {
  skip_if_not_installed("stopwords")
  de <- get_stopwords("de")
  ru <- get_stopwords("ru")

  expect_s3_class(de, "tbl_df")
  expect_s3_class(ru, "tbl_df")
  expect_gt(nrow(de), nrow(ru))
  expect_equal(unique(de$lexicon), "snowball")
})
