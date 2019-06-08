
testthat::context("Word Correlation")

# Test Data

test_WordCorr_df <- dplyr::tibble(
  text = c("I am happy and joyful",
           "I am sad and annoyed",
           "I am supremely happy and gratefully annoyed",
           "I am super duper happy and joyful"),
  key = c("coolguy123",
          "whoknowswhat45847",
          "al;sdkjf8978",
          "kalsdfj9087"))

correct_WordCorr_df <- dplyr::tribble(
  ~item1, ~item2, ~correlation,
  "joyful", "happy", as.double(0.577), 
  "happy", "joyful", as.double(0.577), 
  "annoyed", "happy", as.double(-0.577),
  "happy", "annoyed", as.double(-0.577),
  "annoyed", "joyful", as.double(-1.000),
  "joyful", "annoyed", as.double(-1.000)
)

test_WordCorr_Tidy_df <- saotd::tweet_tidy(DataFrame = test_WordCorr_df)

test <- saotd::word_corr(DataFrameTidy = test_WordCorr_Tidy_df, number = 2) %>% 
  dplyr::mutate(correlation = round(x = correlation, digits = 3))
  
# Tests
test_that("Word Correlations has correct input dataframe", {

  expect_error(object = saotd::word_corr(DataFrameTidy = text), "The input for this function is a data frame.")
  expect_error(object = saotd::word_corr(DataFrameTidy = correct_WordCorr_df), "The data frame is not properly constructed.  The data frame must contain at minimum the columns: Token and key.")
  expect_error(object = saotd::word_corr(DataFrameTidy = test_WordCorr_Tidy_df, number = 1), "Must choose number of Correlation pairs greater than 1.")

})

test_that("Word Correlations are properly computed", {
  
  expect_equal(test, correct_WordCorr_df)
})


