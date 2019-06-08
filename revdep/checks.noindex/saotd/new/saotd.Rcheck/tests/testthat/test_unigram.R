
testthat::context("Compute Unigrams")

# Test Data

text <- "I really love my dog, he is the best friend anyone could ever ask for!"
test_unigram_df <- as.data.frame(x = text)

correct_unigram_df <- dplyr::tribble(
  ~word, ~n,
  "dog", as.integer(1),
  "friend", as.integer(1),
  "love", as.integer(1)
)

test_that("unigrams are computed properly", {
  
  expect_equal(saotd::unigram(DataFrame = test_unigram_df), correct_unigram_df)
  expect_error(object = saotd::unigram(DataFrame = text), "The input for this function is a data frame.")
  
})

