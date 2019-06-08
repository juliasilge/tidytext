
testthat::context("Compute the numer of Tweet Topics")

# Test Data
test_df <- dplyr::data_frame(
  text = c("I really love and hate my dog, he is the best most amazing friend anyone could ever ask for!",
           "cats are the best most amazing friends anyone could ask for",
           "if you are looking for a job, come on down to the local Tire Exchange"),
  hashtag = c("dog", "cat", "job"),
  key = c("coolguy123", "crazycatperson1234", "tireworld876"))

test_NumberTopics <- saotd::number_topics(DataFrame = test_df, 
                                          num_cores = 1L, 
                                          min_clusters = 2, 
                                          max_clusters = 4, 
                                          skip = 1, 
                                          set_seed = 1234)

# Tests
test_that("The number_topics function properly ingests data frame", {
  
  expect_error(object = saotd::number_topics(DataFrame = text), "The input for this function is a data frame.")
 
})

test_that("The number_topics plot retunrs ggplot object", {
  
  expect_is(test_NumberTopics, "ggplot")
  
})