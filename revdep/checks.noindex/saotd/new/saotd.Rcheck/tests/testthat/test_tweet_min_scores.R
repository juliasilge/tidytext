
testthat::context("Compute Tweet Minimum Sentiment Scores")

# Test Data

# Data for hashtag without "HT_Topic_Selection"
test_HT_df <- dplyr::data_frame(
  text = c("I really love and hate my dog, he is the best most amazing friend anyone could ever ask for!  
           I really hate my love to hate on my stupid dog, he is the worst friend anyone could ever ask for!",
           "cats are the best most amazing friends anyone could ask for except when they are being miserable horrible terrible demon spawn"),
  hashtag = c("dog", "cat"), 
  created = lubridate::as_datetime(c('2018-02-09 17:56:30', '2018-02-10 18:46:10')),
  key = c("coolguy123", "crazycatperson1234"))

test_HT_Tidy_df <- saotd::tweet_tidy(DataFrame = test_HT_df)
test_HT_Scores_Tidy_df <- saotd::tweet_scores(DataFrameTidy = test_HT_Tidy_df, HT_Topic = "hashtag")
test_HT <- saotd::tweet_min_scores(DataFrameTidyScores = test_HT_Scores_Tidy_df, HT_Topic = "hashtag")
test_HT <- test_HT$TweetSentimentScore[1]

check_HT <- -3

# Data for hashtag with "HT_Topic_Selection"
test_HT_selection <- saotd::tweet_min_scores(DataFrameTidyScores = test_HT_Scores_Tidy_df, HT_Topic = "hashtag", HT_Topic_Selection = "dog")
test_HT_selection <- test_HT_selection$TweetSentimentScore[1]

check_HT_selection <- -2

# Data for topic without "HT_Topic_Selection"
test_Topic_df <- dplyr::data_frame(
  text = c("I really love and hate my dog, he is the best most amazing friend anyone could ever ask for!  
           I really hate my love to hate on my stupid dog, he is the worst friend anyone could ever ask for!",
           "cats are the best most amazing friends anyone could ask for except when they are being miserable horrible terrible demon spawn"),
  Topic = c("dog", "cat"), 
  created = lubridate::as_datetime(c('2018-02-09 17:56:30', '2018-02-10 18:46:10')),
  key = c("coolguy123", "crazycatperson1234"))

test_Topic_Tidy_df <- saotd::tweet_tidy(DataFrame = test_Topic_df)
test_Topic_Scores_Tidy_df <- saotd::tweet_scores(DataFrameTidy = test_Topic_Tidy_df, HT_Topic = "topic")
test_Topic <- saotd::tweet_min_scores(DataFrameTidyScores = test_Topic_Scores_Tidy_df, HT_Topic = "topic")
test_Topic <- test_Topic$TweetSentimentScore[1]

check_Topic <- -3

# Data for topic without "HT_Topic_Selection"
test_Topic_selection <- saotd::tweet_min_scores(DataFrameTidyScores = test_Topic_Scores_Tidy_df, HT_Topic = "topic", HT_Topic_Selection = "dog")
test_Topic_selection <- test_Topic_selection$TweetSentimentScore[1]

check_Topic_selection <- -2

# Tests
test_that("The tweet_min_scores function properly ingests data frame", {
  
  expect_error(object = saotd::tweet_min_scores(DataFrameTidyScores = text), "The input for this function is a data frame.")
  expect_error(object = saotd::tweet_min_scores(DataFrameTidyScores = test_HT_Scores_Tidy_df, HT_Topic = "HT"), "HT_Topic requires an input of either hashtag for analysis using hashtags, or topic for analysis looking at topics.")
  
})

test_that("The tweet_min_scores function using hashtags properly computes scores", {
  
  expect_equal(test_HT, check_HT)
  
})

test_that("The tweet_min_scores function using topics properly computes scores", {
  
  expect_equal(test_Topic, check_Topic)
  
})

test_that("The tweet_min_scores function using hashtags and a hashtag selection properly computes scores", {
  
  expect_equal(test_HT_selection, check_HT_selection)
  
})

test_that("The tweet_min_scores function using topics and a topic selection properly computes scores", {
  
  expect_equal(test_Topic_selection, check_Topic_selection)
  
})

