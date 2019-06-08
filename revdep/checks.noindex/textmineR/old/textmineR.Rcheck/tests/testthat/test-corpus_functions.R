context("Functions related to corpus management")

# declare some globals
docs <- c("This is my first document.",
          "My 2nd document!",
          "skills, son, skills. Skillz!")



### CreateDtm ----
test_that("CreateDtm performs as expected",{

  d <- CreateDtm(doc_vec = docs, doc_names = seq_along(docs),
                 ngram_window = c(1,2),
                 stopword_vec = "the", 
                 lower = TRUE,
                 remove_punctuation = TRUE,
                 remove_numbers = TRUE,
                 cpus = 2)
  
  # all documents accounted for?
  expect_equal(length(docs), nrow(d))
  
  # stopwords removed?
  expect_false("the" %in% colnames(d))
  
  # correct number of unigrams and bigrams?
  expect_true(sum(! grepl("_", colnames(d))) == 9)
  
  # lowercase?
  expect_true(sum(grepl("[A-Z]", colnames(d))) == 0)
  
  # punctuation removed?
  expect_true(sum(grepl("[^[:alnum:]_]", colnames(d))) == 0)
  
  # numbers removed?
  expect_true(sum(grepl("[0-9]", colnames(d))) == 0)
  
})



### CreateTcm ----
test_that("CreateTcm performs as expected",{
  
  d <- CreateTcm(doc_vec = docs, 
                 skipgram_window = 3,
                 stopword_vec = "the", 
                 lower = TRUE,
                 remove_punctuation = TRUE,
                 remove_numbers = TRUE,
                 cpus = 2)

  # stopwords removed?
  expect_false("the" %in% colnames(d))
  
  # lowercase?
  expect_true(sum(grepl("[A-Z]", colnames(d))) == 0)
  
  # punctuation removed?
  expect_true(sum(grepl("[^[:alnum:]_]", colnames(d))) == 0)
  
  # numbers removed?
  expect_true(sum(grepl("[0-9]", colnames(d))) == 0)
})


### Dtm2Docs ----
test_that("Dtm2Docs",{
  
  # create a dtm with unigrams only for testing purposes
  d <- CreateDtm(doc_vec = docs, doc_names = seq_along(docs),
                 ngram_window = c(1,1),
                 stopword_vec = "the", 
                 lower = TRUE,
                 remove_punctuation = TRUE,
                 remove_numbers = TRUE,
                 cpus = 2)
  
  
  dd <- Dtm2Docs(d, cpus = 2)
  
  expect_true(length(dd) == nrow(d))
  
  # create a second dtm with the same call as the first
  d2 <- CreateDtm(doc_vec = dd, doc_names = seq_along(dd),
                  ngram_window = c(1,1),
                  stopword_vec = "the", 
                  lower = TRUE,
                  remove_punctuation = TRUE,
                  remove_numbers = TRUE,
                  cpus = 2)
  
  # make sure we get the same thing back
  expect_true(sum(d2[,colnames(d2)] != d[,colnames(d2)]) == 0)
  
})


### Dtm2Tcm ----
test_that("Dtm2Tcm",{
  
  d <- CreateDtm(doc_vec = docs, doc_names = seq_along(docs),
                 ngram_window = c(1,2),
                 stopword_vec = "the", 
                 lower = TRUE,
                 remove_punctuation = TRUE,
                 remove_numbers = TRUE,
                 cpus = 2)
  
  tcm <- Dtm2Tcm(d)
  
  expect_true(nrow(tcm) == ncol(d))
  
  expect_true(ncol(tcm) == ncol(d))
  
  expect_true(sum(diag(tcm) - colSums(d)) == 0)
  
})


### TermDocFreq ----
test_that("TermDocFreq",{

  d <- CreateDtm(doc_vec = docs, doc_names = seq_along(docs),
                 ngram_window = c(1,2),
                 stopword_vec = "the", 
                 lower = TRUE,
                 remove_punctuation = TRUE,
                 remove_numbers = TRUE,
                 cpus = 2)
  
  tf <- TermDocFreq(d)
  
  expect_true(nrow(tf) == ncol(d))
  
  expect_true(ncol(tf) == 4)
  
  expect_true(sum(colnames(tf) == c("term", "term_freq", "doc_freq", "idf")) == 4)
  
  expect_true(sum(colnames(d) %in% tf$term) == ncol(d))
  
})





