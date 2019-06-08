
testthat::context("Plot Tweets across the World")

# Test Data
# Data for hashtag
test_HT_df <- dplyr::data_frame(
  text = c("I really love and hate my dog, he is the best most amazing friend anyone could ever ask for!
           I really hate my love to hate on my stupid dog, he is the worst friend anyone could ever ask for!",
           "cats are the best most amazing friends anyone could ask for "),
  hashtag = c("dog", "cat"),
  created = lubridate::as_datetime(c('2018-02-09 17:56:30', '2018-02-10 18:46:10')),
  key = c("coolguy123", "crazycatperson1234"),
  longitude = c(-117.5769895, -73.2928943),
  latitude = c(34.0778901, 40.8428759))

p <- saotd::tweet_worldmap(DataFrame = test_HT_df, HT_Topic = "hashtag")

# Data for topic 
test_Topic_df <- dplyr::data_frame(
  text = c("I really love and hate my dog, he is the best most amazing friend anyone could ever ask for!  
           I really hate my love to hate on my stupid dog, he is the worst friend anyone could ever ask for!",
           "cats are the best most amazing friends anyone could ask for except when they are being miserable horrible terrible demon spawn"),
  Topic = c("dog", "cat"), 
  created = lubridate::as_datetime(c('2018-02-09 17:56:30', '2018-02-10 18:46:10')),
  key = c("coolguy123", "crazycatperson1234"),
  longitude = c(-117.5769895, -73.2928943),
  latitude = c(34.0778901, 40.8428759))

t <- saotd::tweet_worldmap(DataFrame = test_Topic_df, HT_Topic = "topic")

# Tests
test_that("The tweet_worldmap function properly ingests data frame", {
  
  expect_error(object = saotd::tweet_worldmap(DataFrame = text), "The input for this function is a data frame.")
  expect_error(object = saotd::tweet_worldmap(DataFrame = test_HT_df, HT_Topic = "HT"), "HT_Topic requires an input of either hashtag for analysis using hashtags, or topic for analysis looking at topics.")
  
})

test_that("The tweet_worldmap plot retunrs ggplot object when using hashtags", {
  
  expect_is(p, "ggplot")
  
})

test_that("The tweet_worldmap plot retunrs ggplot object when using topics", {
  
  expect_is(t, "ggplot")
  
})