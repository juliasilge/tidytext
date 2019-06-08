
testthat::context("Compute the Sentiment Tweet Distribution")

# Test Data
# Data for hashtag
test_HT_df <- dplyr::data_frame(
  text = c("I really love and hate my dog, he is the best most amazing friend anyone could ever ask for!
           I really hate my love to hate on my stupid dog, he is the worst friend anyone could ever ask for!",
           "cats are the best most amazing friends anyone could ask for "),
  hashtag = c("dog", "cat"),
  created = lubridate::as_datetime(c('2018-02-09 17:56:30', '2018-02-10 18:46:10')),
  key = c("coolguy123", "crazycatperson1234"))

test_HT_Tidy_df <- saotd::tweet_tidy(DataFrame = test_HT_df)
test_HT_Tidy_Scores <- saotd::tweet_scores(DataFrameTidy = test_HT_Tidy_df, HT_Topic = "hashtag")

p <- saotd::tweet_distribution(DataFrameTidyScores = test_HT_Tidy_Scores, HT_Topic = "hashtag")

# Data for topic 
test_Topic_df <- dplyr::data_frame(
  text = c("I really love and hate my dog, he is the best most amazing friend anyone could ever ask for!  
           I really hate my love to hate on my stupid dog, he is the worst friend anyone could ever ask for!",
           "cats are the best most amazing friends anyone could ask for except when they are being miserable horrible terrible demon spawn"),
  Topic = c("dog", "cat"), 
  created = lubridate::as_datetime(c('2018-02-09 17:56:30', '2018-02-10 18:46:10')),
  key = c("coolguy123", "crazycatperson1234"))

test_Topic_Tidy_df <- saotd::tweet_tidy(DataFrame = test_Topic_df)
test_Topic_Tidy_Scores <- saotd::tweet_scores(DataFrameTidy = test_Topic_Tidy_df, HT_Topic = "topic")

t <- saotd::tweet_distribution(DataFrameTidyScores = test_Topic_Tidy_Scores, HT_Topic = "topic")


# Tests
test_that("The tweet_distribution function properly ingests data frame", {
  
  expect_error(object = saotd::tweet_distribution(DataFrameTidyScores = text), "The input for this function is a data frame.")
  expect_error(object = saotd::tweet_distribution(DataFrameTidyScores = test_HT_Tidy_Scores, HT_Topic = "HT"), "HT_Topic requires an input of either hashtag for analysis using hashtags, or topic for analysis looking at topics.")
  
  
})

test_that("The tweet_distribution plot retunrs ggplot object when using hashtags", {
  
  expect_is(p, "ggplot")
  
})

test_that("The tweet_distribution plot retunrs ggplot object when using topics", {
  
  expect_is(t, "ggplot")
  
})