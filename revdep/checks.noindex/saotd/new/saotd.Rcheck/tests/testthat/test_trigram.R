
testthat::context("Compute Trigrams")

# Test Data
text <- "Trigrams provide significant awesome information pertaining to the world up down around them.  
Awesome information, empowers the world to make everything better."
test_trigram_df <- as.data.frame(x = text)


correct_trigram_df <- dplyr::tribble(
  ~word1, ~word2, ~word3, ~n,
  "awesome", "information", "empowers", as.integer(1),
  "awesome", "information", "pertaining", as.integer(1),
  "provide", "significant", "awesome", as.integer(1),
  "significant", "awesome", "information", as.integer(1),  
  "trigrams", "provide", "significant", as.integer(1)
)

testthat::test_that("Trigrams are computed properly", {
  
  expect_equal(saotd::trigram(DataFrame = test_trigram_df), correct_trigram_df)  
  expect_error(object = saotd::trigram(DataFrame = text), "The input for this function is a data frame.")
  
})