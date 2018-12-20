context("test convert function and shortcuts")

mytexts <- c(text1 = "The new law included a capital gains tax, and an inheritance tax.",
             text2 = "New York City has raised a taxes: an income tax and a sales tax.")
d <- dfm(mytexts, remove_punct = TRUE)

test_that("test STM package converter", {
    skip_if_not_installed("stm")
    skip_if_not_installed("tm")
    
    dSTM <- convert(d, to = "stm")
    tP <- stm::textProcessor(mytexts, removestopwords = FALSE, verbose = FALSE, 
                             stem = FALSE, wordLengths = c(1, Inf))
    expect_equivalent(dSTM$documents[1], tP$documents[1])
    expect_equivalent(dSTM$documents[2], tP$documents[2])
    expect_equivalent(dSTM$vocab, tP$vocab)
})

test_that("docvars error traps work", {
    expect_error(
        convert(data_dfm_lbgexample, docvars = "ERROR"),
        "docvars must be a data.frame"
    )
    expect_error(
        convert(data_dfm_lbgexample, docvars = data.frame(error = c(1,2))),
        "docvars must have the same number of rows as ndoc\\(x\\)"
    )
})

test_that("test STM package converter with metadata", {
    skip_if_not_installed("stm")
    skip_if_not_installed("tm")
    dv <- data.frame(myvar = c("A", "B"), row.names = names(mytexts))
    mycorpus <- corpus(mytexts, docvars = dv)
    dm <- dfm(mycorpus, remove_punct = TRUE)
    dSTM <- convert(dm, to = "stm")
    tP <- stm::textProcessor(mytexts, removestopwords = FALSE, verbose = FALSE, 
                             stem = FALSE, wordLengths = c(1, Inf))
    expect_equivalent(dSTM$documents[1], tP$documents[1])
    expect_equivalent(dSTM$documents[2], tP$documents[2])
    expect_equivalent(dSTM$vocab, tP$vocab)
    expect_identical(dSTM$meta, dv)
})

test_that("test STM package converter with metadata w/zero-count document", {
    skip_if_not_installed("stm")
    skip_if_not_installed("tm")
    mytexts2 <- c(text1 = "The new law included a capital gains tax, and an inheritance tax.",
                  text2 = ";",  # this will become empty
                  text3 = "New York City has raised a taxes: an income tax and a sales tax.")
    dv <- data.frame(myvar = c("A", "B", "C"), row.names = names(mytexts2))
    mycorpus <- corpus(mytexts2, docvars = dv)
    dm <- dfm(mycorpus, remove_punct = TRUE)
    expect_true(ntoken(dm)[2] == 0)
    
    dSTM <- suppressWarnings(convert(dm, to = "stm"))
    tP <- stm::textProcessor(mytexts, removestopwords = FALSE, verbose = FALSE, 
                             stem = FALSE, wordLengths = c(1, Inf))
    expect_equivalent(dSTM$documents[1], tP$documents[1])
    expect_equivalent(dSTM$documents[2], tP$documents[2])
    expect_equivalent(dSTM$vocab, tP$vocab)
    expect_identical(dSTM$meta, dv[-2, , drop = FALSE])
})

test_that("test tm package converter", {
    skip_if_not_installed("tm")
    dtmq <- convert(d[, order(featnames(d))], to = "tm")
    dtmtm <- tm::DocumentTermMatrix(tm::VCorpus(tm::VectorSource(char_tolower(mytexts))),
                                    control = list(removePunctuation = TRUE,
                                                   wordLengths = c(1, Inf)))
    ## FAILS
    # expect_equivalent(dtmq, dfmtm)
    expect_equivalent(as.matrix(dtmq), as.matrix(dtmtm))
    
    expect_identical(convert(d, to = "tm"), quanteda::as.DocumentTermMatrix(d))
})

test_that("test lda package converter", {
    skip_if_not_installed("tm")
    expect_identical(convert(d, to = "topicmodels"), quanteda:::dfm2dtm(d))
})

test_that("test topicmodels package converter", {
    skip_if_not_installed("tm")
    expect_identical(convert(d, to = "lda"), quanteda:::dfm2lda(d))
})

test_that("test austin package converter", {
    expect_identical(convert(d, to = "austin"), quanteda::as.wfm(d))
})

test_that("test lsa converter", {
    skip_if_not_installed("lsa")
    require(lsa)
    # create some files
    td <- tempfile()
    dir.create(td)
    write( c("cat", "dog", "mouse"), file = paste(td, "D1", sep="/") )
    write( c("hamster", "mouse", "sushi"), file = paste(td, "D2", sep="/") )
    write( c("dog", "monster", "monster"), file = paste(td, "D3", sep="/") )
    # read them, create a document-term matrix
    lsamat <- lsa::textmatrix(td)
    
    lsamat2 <- convert(dfm(tokens(c(D1 = c("cat dog mouse"),
                                    D2 = c("hamster mouse sushi"), 
                                    D3 = c("dog monster monster")))),
                       to = "lsa")
    expect_equivalent(lsamat, lsamat2)    
    
})

test_that("test stm converter: under extreme situations ", {
    #zero-count document
    mydfm <- as.dfm(matrix(c(1, 0, 2, 0, 
                             0, 0, 1, 2, 
                             0, 0, 0, 0, 
                             1, 2, 3, 4), byrow = TRUE, nrow = 4))
    expect_warning(convert(mydfm, to = "stm"), "Dropped empty document\\(s\\): text3")

    #zero-count feature
    mydfm <- as.dfm(matrix(c(1, 0, 2, 0, 
                             0, 0, 1, 2, 
                             1, 0, 0, 0, 
                             1, 0, 3, 4), byrow = TRUE, nrow = 4))
    expect_warning(stmdfm <- convert(mydfm, to = "stm"), "zero-count features: feat2")
    
    # FAILING
    # skip_if_not_installed("stm")
    # require(stm)
    # stm_model <- stm(documents = stmdfm$documents, vocab = stmdfm$vocab, K=3)
    # expect_output(print(stm_model), "A topic model with 3 topics")
    
    #when dfm is 0% sparse
    stmdfm <- convert(as.dfm(matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), ncol = 3)), to = "stm")
    expect_equal(length(stmdfm$documents), 3)
})

test_that("lsa converter works under extreme situations", {
    skip_if_not_installed("lsa")
    require(lsa)
    #zero-count document
    mydfm <- as.dfm(matrix(c(1, 0, 2, 0, 
                             0, 0, 1, 2, 
                             0, 0, 0, 0, 
                             1, 2, 3, 4), byrow = TRUE, nrow = 4))
    # lsa handles empty docs with a warning message 
    expect_warning(lsalsa <- lsa::lsa(convert(mydfm, to = "lsa")), "there are singular values which are zero")
    expect_equal(class(lsalsa), "LSAspace")  
    
    #zero-count feature:
    mydfm <- as.dfm(matrix(c(1, 0, 2, 0, 
                             0, 0, 1, 2, 
                             1, 0, 0, 0, 
                             1, 0, 3, 4), byrow = TRUE, nrow = 4))
    expect_warning(lsalsa <- lsa::lsa(convert(mydfm, to = "lsa")), "there are singular values which are zero")
    expect_equal(class(lsalsa), "LSAspace") 
    
    #when dfm is 0% sparse
    lsadfm <- convert(as.dfm(matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), ncol = 3)), to = "lsa")
    expect_equal(suppressWarnings(class(lsa(lsadfm))), "LSAspace") 
})

test_that("topicmodels converter works under extreme situations", {
    skip_if_not_installed("topicmodels")
    require(topicmodels)
    #zero-count document
    mydfm <- as.dfm(matrix(c(1, 0, 2, 0, 
                             0, 0, 1, 2, 
                             0, 0, 0, 0, 
                             1, 2, 3, 4), byrow = TRUE, nrow = 4))
    motifresult <- LDA(convert(mydfm, to = "topicmodels"), k = 3)
    expect_equivalent(class(motifresult), "LDA_VEM")  
    
    #zero-count feature:topicmodels takes the input matrix correctly, just it shouldn't return feat2 as topic words
    mydfm <- as.dfm(matrix(c(1, 0, 2, 0, 
                             0, 0, 1, 2, 
                             1, 0, 0, 0, 
                             1, 0, 3, 4), byrow = TRUE, nrow = 4))
    motifresult <- LDA(convert(mydfm, to = "topicmodels"), k = 3)
    expect_equivalent(class(motifresult), "LDA_VEM") 
    
    #when dfm is 0% sparse
    motifdfm <- convert(as.dfm(matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), ncol = 3)), to = "topicmodels")
    motifresult <- LDA(motifdfm, 3)
    expect_equivalent(class(motifresult), "LDA_VEM")
})

test_that("lda converter works under extreme situations", {
    skip_if_not_installed("lda")
    require(lda)
    #zero-count document
    mydfm <- as.dfm(matrix(c(1, 0, 2, 0, 
                             0, 0, 1, 2, 
                             0, 0, 0, 0, 
                             1, 2, 3, 4), byrow = TRUE, nrow = 4))
    ldadfm <- convert(mydfm, to = "lda")
    ldaresult <- lda.collapsed.gibbs.sampler(ldadfm$documents, 5, ldadfm$vocab, 25, 0.1, 0.1, compute.log.likelihood=TRUE)
    top_words <- top.topic.words(ldaresult$topics, 4, by.score=TRUE)
    expect_equal(dim(top_words), c(4,5))
    
    #zero-count feature: lda takes the input matrix correctly, just it shouldn't return feat2 as topic words
    mydfm <- as.dfm(matrix(c(1, 0, 2, 0, 
                             0, 0, 1, 2, 
                             1, 0, 0, 0, 
                             1, 0, 3, 4), byrow = TRUE, nrow = 4))
    ldadfm <- convert(mydfm, to = "lda")
    ldaresult <- lda.collapsed.gibbs.sampler(ldadfm$documents, 5, ldadfm$vocab, 25, 0.1, 0.1, compute.log.likelihood=TRUE)
    top_words <- top.topic.words(ldaresult$topics, 5, by.score=TRUE)
    expect_equal(dim(top_words), c(5,5))
    
    #when dfm is 0% sparse
    motifdfm <- convert(as.dfm(matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), ncol = 3)), to = "lda")
    ldadfm <- convert(mydfm, to = "lda")
    ldaresult <- lda.collapsed.gibbs.sampler(ldadfm$documents, 5, ldadfm$vocab, 25, 0.1, 0.1, compute.log.likelihood=TRUE)
    top_words <- top.topic.words(ldaresult$topics, 5, by.score=TRUE)
    expect_equal(dim(top_words), c(5,5))
})

test_that("tm converter works under extreme situations", {
    skip_if_not_installed("tm")
    #zero-count document
    amatrix <- matrix(c(1, 0, 2, 0, 
                        0, 0, 1, 2, 
                        0, 0, 0, 0, 
                        1, 2, 3, 4), byrow = TRUE, nrow = 4)
    tmdfm <- convert(as.dfm(amatrix), to = "tm")
    expect_equivalent(as.matrix(tmdfm), amatrix)
    
    #zero-count feature:
    bmatrix <- matrix(c(1, 0, 2, 0, 
                        0, 0, 1, 2, 
                        1, 0, 0, 0, 
                        1, 0, 3, 4), byrow = TRUE, nrow = 4)
    tmdfm <- convert(as.dfm(bmatrix), to = "tm")
    expect_equivalent(as.matrix(tmdfm), bmatrix)
    
    #when dfm is 0% sparse
    cmatrix <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), ncol = 3)
    tmdfm <- convert(as.dfm(cmatrix), to = "tm")
    expect_equivalent(as.matrix(tmdfm), cmatrix)
})

test_that("weighted dfm is not convertible to a topic model format (#1091)", {
    err_msg <- "cannot convert a non-count dfm to a topic model format"

    expect_error(convert(dfm_weight(d, "prop"), to = "stm"), err_msg)
    expect_error(convert(dfm_weight(d, "prop"), to = "topicmodels"), err_msg)
    expect_error(convert(dfm_weight(d, "prop"), to = "lda"), err_msg)
    expect_error(convert(dfm_weight(d, "prop"), to = "stm"), err_msg)
    expect_error(convert(dfm_weight(d, "prop"), to = "stm"), err_msg)
    
    expect_error(convert(dfm_tfidf(d), to = "stm"), err_msg)
})

test_that("triplet converter works", {
    
    mt <- dfm(c("a b c", "c c d")) 
    expect_identical(convert(mt, to = "tripletlist"),
                     list(document = c(rep("text1", 3), rep("text2", 2)),
                          feature = c("a", "b", "c", "c", "d"),
                          frequency = c(1, 1, 1, 2, 1)
                     ))

})

