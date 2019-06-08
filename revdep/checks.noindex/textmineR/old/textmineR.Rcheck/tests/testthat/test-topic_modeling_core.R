context("Topic Modeling Core")

# common objects
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

d2 <- CreateDtm(doc_vec = "all my documents have skills", 
                doc_names = 1,
                ngram_window = c(1,2),
                stopword_vec = "the", 
                lower = TRUE,
                remove_punctuation = TRUE,
                remove_numbers = TRUE,
                cpus = 2)

### CalcGamma ----
test_that("CalcGamma works as expected",{
  
  g <- CalcGamma(phi = nih_sample_topic_model$phi,
                 theta = nih_sample_topic_model$theta)
  
  
  # check dimensions
  expect_true(nrow(g) == nrow(nih_sample_topic_model$phi))
  
  expect_true(ncol(g) == ncol(nih_sample_topic_model$phi))
  
  # check_sums
  expect_true(mean(round(colSums(g),10)) == 1) # round b/c numeric precision
  
  
})

### Cluster2TopicModel ----
test_that("Cluster2TopicModel works as expected",{
  cl <- Cluster2TopicModel(nih_sample_dtm, nih_sample$ADMINISTERING_IC, cpus = 2)
  
  # check dimensions
  expect_true(nrow(cl$theta) == nrow(nih_sample_dtm))
  
  expect_true(ncol(cl$theta) == length(unique(nih_sample$ADMINISTERING_IC)))
  
  expect_true(nrow(cl$phi) == ncol(cl$theta))
  
  expect_true(ncol(cl$phi) == ncol(nih_sample_dtm))
  
  expect_true(nrow(cl$gamma) == nrow(cl$phi))
  
  expect_true(ncol(cl$gamma) == ncol(cl$phi))
  
  # check sums (all key statistics from summary of sums are 1)
  expect_true(sum(summary(round(rowSums(cl$theta)),10)) == 6)
  
  expect_true(sum(summary(round(rowSums(cl$phi)),10)) == 6)
  
  expect_true(sum(summary(round(colSums(cl$gamma)),10)) == 6)
  
})

### FitCtmModel ----
test_that("FitCtmModel performs as expected",{
  
  m <- FitCtmModel(dtm = d, k = 2, calc_coherence = FALSE, calc_r2 = FALSE)
  
  # check dimensions
  expect_true(nrow(m$theta) == nrow(d))
  
  expect_true(ncol(m$theta) == 2)
  
  expect_true(nrow(m$phi) == ncol(m$theta))
  
  expect_true(ncol(m$phi) == ncol(d))
  
  expect_true(nrow(m$gamma) == nrow(m$phi))
  
  expect_true(ncol(m$gamma) == ncol(m$phi))
  
  # check sums (all key statistics from summary of sums are 1)
  expect_true(sum(summary(round(rowSums(m$theta)),10)) == 6)
  
  expect_true(sum(summary(round(rowSums(m$phi)),10)) == 6)
  
  expect_true(sum(summary(round(colSums(m$gamma)),10)) == 6)
  
  
})

### predict.ctm_topic_model ----
test_that("predict.ctm_topic_model performs as expected", {

  m <- FitCtmModel(dtm = d, k = 2, calc_coherence = FALSE, calc_r2 = FALSE)
  
  # predict with a bunch of documents
  p <- predict(m, d)
  
  expect_true(nrow(p) == nrow(d))
  
  expect_true(ncol(p) == ncol(m$theta))
  
  expect_true(round(mean(rowSums(p)),10) == 1)
  
  # predict with one document as a numeric vector
  p <- predict(m, d2[1,])
  
  expect_true(nrow(p) == 1)
  
  expect_true(ncol(p) == ncol(m$theta))
  
  expect_true(round(sum(p),10) == 1)
  
  # predict with one document as a dgCMatrix
  p <- predict(m, d2)
  
  expect_true(nrow(p) == 1)
  
  expect_true(ncol(p) == ncol(m$theta))
  
  expect_true(round(sum(p),10) == 1)
  
  
})

### FitLsaModel ----
test_that("FitLsaModel", {
  
  m <- FitLsaModel(d, k = 2, calc_coherence = FALSE)
  
  # check dimensions
  expect_true(length(m$sv) == 2)
  
  expect_true(nrow(m$theta) == nrow(d))
  
  expect_true(ncol(m$theta) == length(m$sv))
  
  expect_true(nrow(m$phi) == length(m$sv))
  
  expect_true(ncol(m$phi) == ncol(d))
  
  expect_true(sum(dim(m$phi) == dim(m$gamma)) == 2)
  
  # check sums not necessary b/c LSA does not fit probabilities
  
})

### predict.lsa_topic_model ----
test_that("predict.lsa_topic_model", {
  
  m <- FitLsaModel(d, k = 2, calc_coherence = FALSE)
  
  # predictions for many documents
  p <- predict(m, d)
  
  expect_true(nrow(p) == nrow(d))
  
  expect_true(ncol(p) == 2)
  
  # predict with one document as a numeric vector
  p <- predict(m, d2[1,])
  
  expect_true(nrow(p) == 1)
  
  expect_true(ncol(p) == ncol(m$theta))
  
  
  # predict with one document as a dgCMatrix
  p <- predict(m, d2)
  
  expect_true(nrow(p) == 1)
  
  expect_true(ncol(p) == ncol(m$theta))
  
 
})

### Dtm2Lexicon ----
test_that("Dtm2Lexicon", {
  
  l <- Dtm2Lexicon(d, cpus = 2)
  
  # check dimensions and sums
  expect_true(length(l) == nrow(d))
  
  expect_false(FALSE %in% (rowSums(d) == sapply(l, length)))
  
  # check a single document
  l <- Dtm2Lexicon(d[1,], cpus = 2)
  
})

### FitLdaModel ----
test_that("FitLdaModel", {
  
  # check dimensions of standard fitting with burnin
  m <- FitLdaModel(dtm = d, k = 2, 
                   iterations = 200, 
                   burnin = 175)
  
  expect_true(nrow(m$theta) == nrow(d))
  
  expect_true(ncol(m$theta) == 2)
  
  expect_true(nrow(m$phi) == ncol(m$theta))
  
  expect_true(ncol(m$phi) == ncol(d))
  
  expect_true(sum(dim(m$phi) == dim(m$gamma)) == 2)
  
  expect_true(round(mean(rowSums(m$theta)),10) == 1)
  
  expect_true(round(mean(rowSums(m$phi)), 10) == 1)
  
  expect_true(round(mean(colSums(m$gamma)),10) == 1)
  
  # check dimensions of standard fitting without burnin
  m <- FitLdaModel(dtm = d, k = 2, 
                   iterations = 200)
  
  expect_true(nrow(m$theta) == nrow(d))
  
  expect_true(ncol(m$theta) == 2)
  
  expect_true(nrow(m$phi) == ncol(m$theta))
  
  expect_true(ncol(m$phi) == ncol(d))
  
  expect_true(sum(dim(m$phi) == dim(m$gamma)) == 2)
  
  expect_true(round(mean(rowSums(m$theta)),10) == 1)
  
  expect_true(round(mean(rowSums(m$phi)), 10) == 1)
  
  expect_true(round(mean(colSums(m$gamma)),10) == 1)
  
  
  # set burnin equal to iterations
  expect_error(
    m <- FitLdaModel(dtm = d, k = 2, 
                   iterations = 200, 
                   burnin = 200)
  )

  # set an illegal value for burnin
  expect_error(
    m <- FitLdaModel(dtm = d, k = 2, 
                     iterations = 200, 
                     burnin = 300)
  )
  
  
  # optimize alpha doesn't throw an error
  m <- FitLdaModel(dtm = d, k = 2, 
                   iterations = 200, 
                   burnin = 175,
                   optimize_alpha = TRUE)
  
  # liklihood is in good shape
  m <- FitLdaModel(dtm = d, k = 2, 
                   iterations = 200, 
                   burnin = 175,
                   optimize_alpha = TRUE,
                   calc_likelihood = TRUE)
   
  expect_true(sum(is.na(m$log_likelihood)) == 0)
  
  expect_true(ncol(m$log_likelihood) == 2)
  
})



### predict.lda_topic_model ----
test_that("predict.lda_topic_model",{
  m <- FitLdaModel(dtm = d, k = 2, 
                   iterations = 200, 
                   burnin = 175,
                   optimize_alpha = TRUE)
  
  # gibbs sampling many documents
  p <- predict(m, d, iterations = 200, burnin = 175)
  
  expect_true(nrow(p) == nrow(d))
  
  expect_true(ncol(p) == 2)
  
  expect_true(round(mean(rowSums(p)),10) == 1)
  
  
  # gibbs sampling a single document as a numeric vector
  p <- predict(m, d2[1,], iterations = 200, burnin = 175)
  
  expect_true(nrow(p) == 1)
  
  expect_true(ncol(p) == 2)
  
  expect_true(round(mean(rowSums(p)),10) == 1)
  
  # gibbs sampling a single document as a dgCMatrix
  p <- predict(m, d2, iterations = 200, burnin = 175)
  
  expect_true(nrow(p) == 1)
  
  expect_true(ncol(p) == 2)
  
  expect_true(round(mean(rowSums(p)),10) == 1)
  
  
  # dot many documents
  p <- predict(m, d, method = "dot")
  
  expect_true(nrow(p) == nrow(d))
  
  expect_true(ncol(p) == 2)
  
  expect_true(round(mean(rowSums(p)),10) == 1)
  
  # dot single document as a numeric vector
  p <- predict(m, d2[1,], method = "dot")
  
  expect_true(nrow(p) == 1)
  
  expect_true(ncol(p) == 2)
  
  expect_true(round(mean(rowSums(p)),10) == 1)
  
  # dot single document as a dgCMatrix
  p <- predict(m, d2, method = "dot")
  
  expect_true(nrow(p) == 1)
  
  expect_true(ncol(p) == 2)
  
  expect_true(round(mean(rowSums(p)),10) == 1)
  
  
})

### update.lda_topic_model ----
test_that("update.lda_topic_model",{
  
  # TODO: (1) add expect_true statements (2) account for different vocab in d1 and d2
  
  # load a document term matrix
  d1 <- nih_sample_dtm[1:50,]
  
  d2 <- nih_sample_dtm[51:100,]
  
  # fit a model
  m <- FitLdaModel(d1, k = 10, 
                   iterations = 200, burnin = 175,
                   optimize_alpha = TRUE, 
                   calc_likelihood = FALSE,
                   calc_coherence = TRUE,
                   calc_r2 = FALSE)
  
  # update an existing model by adding documents
  m2 <- update(object = m,
               dtm = rbind(d1, d2),
               iterations = 200,
               burnin = 175)
  
  expect_true(sum(dim(m$phi) == dim(m2$phi)) == 2)
  
  # use an old model as a prior for a new model
  m3 <- update(object = m,
               dtm = d2, # new documents only
               iterations = 200,
               burnin = 175)
  
  expect_true(sum(dim(m$phi) == dim(m3$phi)) == 2)
  
  
  # add topics while updating a model by adding documents
  m4 <- update(object = m,
               dtm = rbind(d1, d2),
               additional_k = 3,
               iterations = 200,
               burnin = 175)
  
  
  # add topics to an existing model
  m5 <- update(object = m,
               dtm = d1, # this is the old data
               additional_k = 3,
               iterations = 200,
               burnin = 175)
  
})






