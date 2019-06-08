context("topic_modeling_utilities")

docs <- c("This is my first document.",
          "My 2nd document!",
          "skills, son, skills. Skillz!")

d <- CreateDtm(doc_vec = docs, doc_names = seq_along(docs),
               ngram_window = c(1,2),
               stopword_vec = "the",
               lower = TRUE,
               remove_punctuation = TRUE,
               remove_numbers = TRUE,
               cpus = 2)

m <- FitLsaModel(d, 2, calc_coherence =FALSE)


### GetTopTerms ----
test_that("GetTopTerms performs as expected",{
  
  t <- GetTopTerms(m$phi, M = 2)
  
  expect_true(nrow(t) == 2)
  
  expect_true(ncol(t) == nrow(m$phi))
  
})


### GetProbableTerms ----



### LabelTopics ----
# check some errors here
# what happens with topics that get no assignment?


### SummarizeTopics ----
test_that("SummarizeTopics performs as expected",{
  
  s <- SummarizeTopics(model = m)
  
  # number of rows is same as number of topics
  expect_true(nrow(s) == nrow(m$phi))
  
  # no missing values
  expect_true(sum(colSums(is.na(s))) == 0)
  
  # checks both that the number of columns is as expected and that
  # the column classes are as expected
  expect_true(sum(sapply(s, class) == 
                    c("character", "character","numeric", "numeric", "character", "character")) == 6)
  
  # prevalence sums to 100
  expect_true(sum(s$prevalence) == 100)
  
})


