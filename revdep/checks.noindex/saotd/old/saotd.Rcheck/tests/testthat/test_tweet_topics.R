
testthat::context("Compute the numer of Tweet Topics")

# Test Data
test_df <- dplyr::data_frame(
  text = c("I really love and hate my dog, he is the best most amazing friend anyone could ever ask for!",
           "cats are the best most amazing friends anyone could ask for",
           "if you are looking for a job, come on down to the local Tire Exchange"),
  hashtag = c("dog", "cat", "job"),
  key = c("coolguy123", "crazycatperson1234", "tireworld876"))

test_TweetTopics <- saotd::tweet_topics(DataFrame = test_df, clusters = 3, num_terms = 5)

check_TweetTopics <- dplyr::data_frame(
  text = c("I really love and hate my dog, he is the best most amazing friend anyone could ever ask for!",
           "cats are the best most amazing friends anyone could ask for",
           "if you are looking for a job, come on down to the local Tire Exchange"),
  hashtag = c("dog", "cat", "job"),
  key = c("coolguy123", "crazycatperson1234", "tireworld876"),
  Topic = as.integer(c(1, 3, 2)))


# Tests
test_that("The tweet_topics function properly accepts input items", {
  
  expect_error(object = saotd::tweet_topics(DataFrame = text), "The input for this function is a data frame.")
  expect_error(object = saotd::tweet_topics(DataFrame = test_df, clusters = "two"), "The input must be a numerical value.")
  
})

test_that("The tweet_topics is being computed correctly", {
  
  expect_identical(test_TweetTopics, check_TweetTopics)
})

