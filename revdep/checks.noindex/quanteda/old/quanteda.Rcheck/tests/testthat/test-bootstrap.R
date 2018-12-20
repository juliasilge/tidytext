context("test bootstrapping functions")

test_that("bootstrap_dfm works with character and corpus objects", {
    txt <- c(textone = "This is a sentence.  Another sentence.  Yet another.",
             texttwo = "Premiere phrase.  Deuxieme phrase.",
             textthree = "Sentence three is really short.")
    mycorpus <- corpus(txt,
                       docvars = data.frame(country=c("UK", "USA", "UK"), year=c(1990, 2000, 2005)),
                       metacorpus = list(notes = "Example showing how corpus_reshape() works."))
    set.seed(10)
    dfmresamp1 <- bootstrap_dfm(mycorpus, n = 10, verbose = TRUE)
    expect_equal(dfmresamp1[[1]], dfm(mycorpus))
    
    dfmresamp2 <- bootstrap_dfm(txt, n = 10, verbose = TRUE)
    expect_identical(dfmresamp2[[1]],
                     dfm(mycorpus, include_docvars = FALSE))
    
    # are feature names of resamples identical?
    expect_identical(
        featnames(dfmresamp2[[1]]),
        featnames(dfmresamp2[[2]])
    )

    # check that all documents have at least one sentence
    L <- lapply(dfmresamp1, as.matrix)
    arrayL <- array(unlist(L), dim = c(nrow(L[[1]]), ncol(L[[1]]), length(L)))
    docsums <- apply(arrayL, c(1, 3), sum)
    expect_true(all(docsums[c(2, 3), ] == 6))
})

test_that("bootstrap_dfm works as planned with dfm", {
    txt <- c(textone = "This is a sentence.  Another sentence.  Yet another.", 
             texttwo = "Premiere phrase.  Deuxieme phrase.")
    mycorpus <- corpus(txt, 
                       docvars = data.frame(country=c("UK", "USA"), year=c(1990, 2000)),
                       metacorpus = list(notes = "Example showing how corpus_reshape() works."))
    mydfm <- dfm(corpus_reshape(mycorpus, to = "sentences"))
    
    set.seed(10)
    dfmresamp1 <- bootstrap_dfm(mydfm, n = 3, verbose = FALSE)
    expect_equivalent(dfmresamp1[[1]], 
                      dfm(mycorpus))
    
    dfmresamp2 <- bootstrap_dfm(txt, n = 3, verbose = FALSE)
    expect_identical(dfmresamp2[[1]], 
                     dfm(mycorpus, include_docvars = FALSE))

    # are feature names of resamples identical?
    expect_identical(
        featnames(dfmresamp2[[1]]),
        featnames(dfmresamp2[[2]])
    )
    # are document names of resamples identical?
    expect_identical(
        docnames(dfmresamp2[[1]]),
        docnames(dfmresamp2[[2]])
    )
})
