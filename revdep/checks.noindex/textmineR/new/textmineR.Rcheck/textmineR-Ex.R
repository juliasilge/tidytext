pkgname <- "textmineR"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('textmineR')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("CalcGamma")
### * CalcGamma

flush(stderr()); flush(stdout())

### Name: CalcGamma
### Title: Calculate a matrix whose rows represent P(topic_i|tokens)
### Aliases: CalcGamma

### ** Examples

# Load a pre-formatted dtm and topic model
data(nih_sample_topic_model) 

# Make a gamma matrix, P(topic|words)
gamma <- CalcGamma(phi = nih_sample_topic_model$phi, 
                   theta = nih_sample_topic_model$theta)




cleanEx()
nameEx("CalcHellingerDist")
### * CalcHellingerDist

flush(stderr()); flush(stdout())

### Name: CalcHellingerDist
### Title: Calculate Hellinger Distance
### Aliases: CalcHellingerDist

### ** Examples

x <- rchisq(n = 100, df = 8)
y <- x^2
CalcHellingerDist(x = x, y = y)

mymat <- rbind(x, y)
CalcHellingerDist(x = mymat)



cleanEx()
nameEx("CalcJSDivergence")
### * CalcJSDivergence

flush(stderr()); flush(stdout())

### Name: CalcJSDivergence
### Title: Calculate Jensen-Shannon Divergence
### Aliases: CalcJSDivergence
### Keywords: distance functions

### ** Examples

x <- rchisq(n = 100, df = 8)
y <- x^2
CalcJSDivergence(x = x, y = y)

mymat <- rbind(x, y)
CalcJSDivergence(x = mymat)



cleanEx()
nameEx("CalcLikelihood")
### * CalcLikelihood

flush(stderr()); flush(stdout())

### Name: CalcLikelihood
### Title: Calculate the log likelihood of a document term matrix given a
###   topic model
### Aliases: CalcLikelihood

### ** Examples

# Load a pre-formatted dtm and topic model
data(nih_sample_dtm) 
data(nih_sample_topic_model)

# Get the likelihood of the data given the fitted model parameters
ll <- CalcLikelihood(dtm = nih_sample_dtm, 
                     phi = nih_sample_topic_model$phi, 
                     theta = nih_sample_topic_model$theta)

ll



cleanEx()
nameEx("CalcProbCoherence")
### * CalcProbCoherence

flush(stderr()); flush(stdout())

### Name: CalcProbCoherence
### Title: Probabilistic coherence of topics
### Aliases: CalcProbCoherence

### ** Examples

# Load a pre-formatted dtm and topic model
data(nih_sample_topic_model)
data(nih_sample_dtm) 

CalcProbCoherence(phi = nih_sample_topic_model$phi, dtm = nih_sample_dtm, M = 5)



cleanEx()
nameEx("CalcTopicModelR2")
### * CalcTopicModelR2

flush(stderr()); flush(stdout())

### Name: CalcTopicModelR2
### Title: Calculate the R-squared of a topic model.
### Aliases: CalcTopicModelR2

### ** Examples

# Load a pre-formatted dtm and topic model
data(nih_sample_dtm) 
data(nih_sample_topic_model)

# Get the R-squared of the model
r2 <- CalcTopicModelR2(dtm = nih_sample_dtm, 
                     phi = nih_sample_topic_model$phi, 
                     theta = nih_sample_topic_model$theta)


r2



cleanEx()
nameEx("Cluster2TopicModel")
### * Cluster2TopicModel

flush(stderr()); flush(stdout())

### Name: Cluster2TopicModel
### Title: Represent a document clustering as a topic model
### Aliases: Cluster2TopicModel

### ** Examples

## Not run: 
##D # Load pre-formatted data for use
##D data(nih_sample_dtm)
##D data(nih_sample) 
##D 
##D result <- Cluster2TopicModel(dtm = nih_sample_dtm, 
##D                              clustering = nih_sample$IC_NAME)
## End(Not run)



cleanEx()
nameEx("CreateDtm")
### * CreateDtm

flush(stderr()); flush(stdout())

### Name: CreateDtm
### Title: Convert a character vector to a document term matrix.
### Aliases: CreateDtm

### ** Examples

## Not run: 
##D data(nih_sample)
##D 
##D # DTM of unigrams and bigrams
##D dtm <- CreateDtm(doc_vec = nih_sample$ABSTRACT_TEXT,
##D                  doc_names = nih_sample$APPLICATION_ID, 
##D                  ngram_window = c(1, 2))
##D 
##D # DTM of unigrams with Porter's stemmer applied
##D dtm <- CreateDtm(doc_vec = nih_sample$ABSTRACT_TEXT,
##D                  doc_names = nih_sample$APPLICATION_ID,
##D                  stem_lemma_function = function(x) SnowballC::wordStem(x, "porter"))
## End(Not run)



cleanEx()
nameEx("CreateTcm")
### * CreateTcm

flush(stderr()); flush(stdout())

### Name: CreateTcm
### Title: Convert a character vector to a term co-occurrence matrix.
### Aliases: CreateTcm

### ** Examples

## Not run: 
##D data(nih_sample)
##D 
##D # TCM of unigrams and bigrams
##D tcm <- CreateTcm(doc_vec = nih_sample$ABSTRACT_TEXT,
##D                  skipgram_window = Inf, 
##D                  ngram_window = c(1, 2))
##D 
##D # TCM of unigrams and a skip=gram window of 3, applying Porter's word stemmer
##D tcm <- CreateTcm(doc_vec = nih_sample$ABSTRACT_TEXT,
##D                  skipgram_window = 3,
##D                  stem_lemma_function = function(x) SnowballC::wordStem(x, "porter"))
## End(Not run)



cleanEx()
nameEx("Dtm2Docs")
### * Dtm2Docs

flush(stderr()); flush(stdout())

### Name: Dtm2Docs
### Title: Convert a DTM to a Character Vector of documents
### Aliases: Dtm2Docs

### ** Examples

# Load a pre-formatted dtm and topic model
data(nih_sample)
data(nih_sample_dtm) 

# see the original documents
nih_sample$ABSTRACT_TEXT[ 1:3 ]

# see the new documents re-structured from the DTM
new_docs <- Dtm2Docs(dtm = nih_sample_dtm)

new_docs[ 1:3 ]




cleanEx()
nameEx("Dtm2Lexicon")
### * Dtm2Lexicon

flush(stderr()); flush(stdout())

### Name: Dtm2Lexicon
### Title: Turn a document term matrix into a list for LDA Gibbs sampling
### Aliases: Dtm2Lexicon

### ** Examples

## Not run: 
##D # Load pre-formatted data for use
##D data(nih_sample_dtm)
##D 
##D result <- Dtm2Lexicon(dtm = nih_sample_dtm, 
##D                       cpus = 2)
## End(Not run)



cleanEx()
nameEx("Dtm2Tcm")
### * Dtm2Tcm

flush(stderr()); flush(stdout())

### Name: Dtm2Tcm
### Title: Turn a document term matrix into a term co-occurrence matrix
### Aliases: Dtm2Tcm

### ** Examples

data(nih_sample_dtm)

tcm <- Dtm2Tcm(nih_sample_dtm)



cleanEx()
nameEx("FitCtmModel")
### * FitCtmModel

flush(stderr()); flush(stdout())

### Name: FitCtmModel
### Title: Fit a Correlated Topic Model
### Aliases: FitCtmModel

### ** Examples

# Load a pre-formatted dtm 
data(nih_sample_dtm) 

# Fit a CTM model on a sample of documents
model <- FitCtmModel(dtm = nih_sample_dtm[ sample(1:nrow(nih_sample_dtm) , 10) , ], 
                     k = 3, return_all = FALSE)



cleanEx()
nameEx("FitLdaModel")
### * FitLdaModel

flush(stderr()); flush(stdout())

### Name: FitLdaModel
### Title: Fit a Latent Dirichlet Allocation topic model
### Aliases: FitLdaModel

### ** Examples

# load some data
data(nih_sample_dtm)

# fit a model 
set.seed(12345)
m <- FitLdaModel(dtm = nih_sample_dtm[1:20,], k = 5,
                 iterations = 200, burnin = 175)

str(m)

# predict on held-out documents using gibbs sampling "fold in"
p1 <- predict(m, nih_sample_dtm[21:100,], method = "gibbs",
              iterations = 200, burnin = 175)

# predict on held-out documents using the dot product method
p2 <- predict(m, nih_sample_dtm[21:100,], method = "dot")

# compare the methods
barplot(rbind(p1[1,],p2[1,]), beside = TRUE, col = c("red", "blue")) 



cleanEx()
nameEx("FitLsaModel")
### * FitLsaModel

flush(stderr()); flush(stdout())

### Name: FitLsaModel
### Title: Fit a topic model using Latent Semantic Analysis
### Aliases: FitLsaModel

### ** Examples

# Load a pre-formatted dtm 
data(nih_sample_dtm) 

# Convert raw word counts to TF-IDF frequency weights
idf <- log(nrow(nih_sample_dtm) / Matrix::colSums(nih_sample_dtm > 0))

dtm_tfidf <- Matrix::t(nih_sample_dtm) * idf

dtm_tfidf <- Matrix::t(dtm_tfidf)

# Fit an LSA model
model <- FitLsaModel(dtm = dtm_tfidf, k = 5)

str(model)




cleanEx()
nameEx("GetProbableTerms")
### * GetProbableTerms

flush(stderr()); flush(stdout())

### Name: GetProbableTerms
### Title: Get cluster labels using a "more probable" method of terms
### Aliases: GetProbableTerms

### ** Examples

# Load a pre-formatted dtm and topic model
data(nih_sample_topic_model)
data(nih_sample_dtm) 

# documents with a topic proportion of .25 or higher for topic 2
mydocs <- rownames(nih_sample_topic_model$theta)[ nih_sample_topic_model$theta[ , 2 ] >= 0.25 ] 

term_probs <- Matrix::colSums(nih_sample_dtm) / sum(Matrix::colSums(nih_sample_dtm))

GetProbableTerms(docnames = mydocs, dtm = nih_sample_dtm, p_terms = term_probs)




cleanEx()
nameEx("GetTopTerms")
### * GetTopTerms

flush(stderr()); flush(stdout())

### Name: GetTopTerms
### Title: Get Top Terms for each topic from a topic model
### Aliases: GetTopTerms

### ** Examples

# Load a pre-formatted dtm and topic model
data(nih_sample_topic_model) 

top_terms <- GetTopTerms(phi = nih_sample_topic_model$phi, M = 5)

str(top_terms)



cleanEx()
nameEx("LabelTopics")
### * LabelTopics

flush(stderr()); flush(stdout())

### Name: LabelTopics
### Title: Get some topic labels using a "more probable" method of terms
### Aliases: LabelTopics

### ** Examples

# make a dtm with unigrams and bigrams
data(nih_sample_topic_model)

m <- nih_sample_topic_model

assignments <- t(apply(m$theta, 1, function(x){
  x[ x < 0.05 ] <- 0
  x / sum(x)
}))

assignments[is.na(assignments)] <- 0

labels <- LabelTopics(assignments = assignments, dtm = m$data, M = 2)




cleanEx()
nameEx("SummarizeTopics")
### * SummarizeTopics

flush(stderr()); flush(stdout())

### Name: SummarizeTopics
### Title: Summarize topics in a topic model
### Aliases: SummarizeTopics

### ** Examples

## Not run: 
##D SummarizeTopics(nih_sample_topic_model)
## End(Not run)



cleanEx()
nameEx("TermDocFreq")
### * TermDocFreq

flush(stderr()); flush(stdout())

### Name: TermDocFreq
### Title: Get term frequencies and document frequencies from a document
###   term matrix.
### Aliases: TermDocFreq

### ** Examples

# Load a pre-formatted dtm and topic model
data(nih_sample_dtm)
data(nih_sample_topic_model) 

# Get the term frequencies 
term_freq_mat <- TermDocFreq(nih_sample_dtm)

str(term_freq_mat)



cleanEx()
nameEx("TmParallelApply")
### * TmParallelApply

flush(stderr()); flush(stdout())

### Name: TmParallelApply
### Title: An OS-independent parallel version of 'lapply'
### Aliases: TmParallelApply

### ** Examples

## Not run: 
##D x <- 1:10000
##D f <- function(y) y * y + 12
##D result <- TmParallelApply(x, f)
## End(Not run)



cleanEx()
nameEx("posterior.lda_topic_model")
### * posterior.lda_topic_model

flush(stderr()); flush(stdout())

### Name: posterior.lda_topic_model
### Title: Draw from the posterior of an LDA topic model
### Aliases: posterior.lda_topic_model

### ** Examples

## Not run: 
##D a <- posterior(object = nih_sample_topic_model, which = "theta", num_samples = 20)
##D 
##D plot(density(a$t1[a$var == "8693991"]))
##D 
##D b <- posterior(object = nih_sample_topic_model, which = "phi", num_samples = 20)
##D 
##D plot(denisty(b$research[b$var == "t_5"]))
## End(Not run)



cleanEx()
nameEx("predict.ctm_topic_model")
### * predict.ctm_topic_model

flush(stderr()); flush(stdout())

### Name: predict.ctm_topic_model
### Title: Predict method for Correlated topic models (CTM)
### Aliases: predict.ctm_topic_model

### ** Examples

# Load a pre-formatted dtm 
## Not run: 
##D data(nih_sample_dtm) 
##D 
##D model <- FitCtmModel(dtm = nih_sample_dtm[1:20,], k = 3,
##D                      calc_coherence = FALSE, calc_r2 = FALSE)
##D 
##D # Get predictions on the next 50 documents
##D pred <- predict(model, nih_sample_dtm[21:100,])
## End(Not run)



cleanEx()
nameEx("predict.lda_topic_model")
### * predict.lda_topic_model

flush(stderr()); flush(stdout())

### Name: predict.lda_topic_model
### Title: Get predictions from a Latent Dirichlet Allocation model
### Aliases: predict.lda_topic_model

### ** Examples

## Not run: 
##D # load some data
##D data(nih_sample_dtm)
##D 
##D # fit a model 
##D set.seed(12345)
##D 
##D m <- FitLdaModel(dtm = nih_sample_dtm[1:20,], k = 5,
##D                  iterations = 200, burnin = 175)
##D 
##D str(m)
##D 
##D # predict on held-out documents using gibbs sampling "fold in"
##D p1 <- predict(m, nih_sample_dtm[21:100,], method = "gibbs",
##D               iterations = 200, burnin = 175)
##D 
##D # predict on held-out documents using the dot product method
##D p2 <- predict(m, nih_sample_dtm[21:100,], method = "dot")
##D 
##D # compare the methods
##D barplot(rbind(p1[1,],p2[1,]), beside = TRUE, col = c("red", "blue")) 
## End(Not run)



cleanEx()
nameEx("predict.lsa_topic_model")
### * predict.lsa_topic_model

flush(stderr()); flush(stdout())

### Name: predict.lsa_topic_model
### Title: Predict method for LSA topic models
### Aliases: predict.lsa_topic_model

### ** Examples

# Load a pre-formatted dtm 
data(nih_sample_dtm) 

# Convert raw word counts to TF-IDF frequency weights
idf <- log(nrow(nih_sample_dtm) / Matrix::colSums(nih_sample_dtm > 0))

dtm_tfidf <- Matrix::t(nih_sample_dtm) * idf

dtm_tfidf <- Matrix::t(dtm_tfidf)

# Fit an LSA model on the first 50 documents
model <- FitLsaModel(dtm = dtm_tfidf[1:50,], k = 5)

# Get predictions on the next 50 documents
pred <- predict(model, dtm_tfidf[51:100,])



cleanEx()
nameEx("update.lda_topic_model")
### * update.lda_topic_model

flush(stderr()); flush(stdout())

### Name: update.lda_topic_model
### Title: Update a Latent Dirichlet Allocation topic model with new data
### Aliases: update.lda_topic_model

### ** Examples

## Not run: 
##D # load a document term matrix
##D d1 <- nih_sample_dtm[1:50,]
##D 
##D d2 <- nih_sample_dtm[51:100,]
##D 
##D # fit a model
##D m <- FitLdaModel(d1, k = 10, 
##D                  iterations = 200, burnin = 175,
##D                  optimize_alpha = TRUE, 
##D                  calc_likelihood = FALSE,
##D                  calc_coherence = TRUE,
##D                  calc_r2 = FALSE)
##D 
##D # update an existing model by adding documents
##D m2 <- update(object = m,
##D              dtm = rbind(d1, d2),
##D              iterations = 200,
##D              burnin = 175)
##D              
##D # use an old model as a prior for a new model
##D m3 <- update(object = m,
##D              dtm = d2, # new documents only
##D              iterations = 200,
##D              burnin = 175)
##D              
##D # add topics while updating a model by adding documents
##D m4 <- update(object = m,
##D              dtm = rbind(d1, d2),
##D              additional_k = 3,
##D              iterations = 200,
##D              burnin = 175)
##D              
##D # add topics to an existing model
##D m5 <- update(object = m,
##D              dtm = d1, # this is the old data
##D              additional_k = 3,
##D              iterations = 200,
##D              burnin = 175)
##D 
## End(Not run)



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
