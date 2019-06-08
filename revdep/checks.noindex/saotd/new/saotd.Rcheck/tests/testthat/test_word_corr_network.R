
testthat::context("Word Correlation Network Diagram")

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

incorrect_WordCorr_df <- dplyr::tribble(
  ~item1, ~item2, ~c,
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


p <- saotd::word_corr_network(WordCorr = test, Correlation = .1)

# Tests
test_that("The word_corr_network function is working as properly", {

  expect_error(object = saotd::word_corr_network(WordCorr = text), "The input for this function is a Correlation data frame.")
  expect_error(object = saotd::word_corr_network(WordCorr = test, Correlation = 0), "A correlation value between 0 and 1 must be selected.")
  expect_error(object = saotd::word_corr_network(WordCorr = test, Correlation = 1.1), "A correlation value between 0 and 1 must be selected.")

})

test_that("The word_corr_network retunrs ggplot object", {

  expect_is(p, "ggplot")
  
})

