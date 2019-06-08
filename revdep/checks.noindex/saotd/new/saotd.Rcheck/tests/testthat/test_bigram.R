
testthat::context("Compute Bigrams")

# Test Data
text <- "This is the website for “R for Data Science”. 
  This book will teach you how to do data science with R: 
You’ll learn how to get your data into R, get it into the most useful structure, transform it, visualise it and model it." 
test_bigram_df <- as.data.frame(x = text)

correct_bigram_df <- dplyr::tribble(
  ~word1, ~word2, ~n,
  "data", "science", as.integer(2),
  "structure", "transform", as.integer(1),
  "youll", "learn", as.integer(1)
)

test_that("bigrams are computed properly", {
  
  expect_equal(saotd::bigram(DataFrame = test_bigram_df), correct_bigram_df)
  expect_error(object = saotd::bigram(DataFrame = text), "The input for this function is a data frame.")
  
})
