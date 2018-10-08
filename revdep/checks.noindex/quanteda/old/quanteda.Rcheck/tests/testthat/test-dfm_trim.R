context("test dfm_trim")

test_that("dfm_trim", {
    
    mydfm <- dfm(c(d1 = "a b c d e", d2 = "a a b b e f", d3 = "b c e e f f f"))
    s <- sum(mydfm)
    
    expect_equal(nfeat(dfm_trim(mydfm, min_termfreq = 0.5, termfreq_type = "quantile")), 4)
    expect_equal(nfeat(dfm_trim(mydfm, min_termfreq = 3 / s, termfreq_type = "prop")), 4)
    expect_equal(nfeat(dfm_trim(mydfm, min_termfreq = 3)), 4)
    
    expect_equal(nfeat(dfm_trim(mydfm, max_termfreq = 0.8, termfreq_type = "quantile")), 6)
    expect_equal(nfeat(dfm_trim(mydfm, max_termfreq = 4 / s, termfreq_type = "prop")), 6)
    expect_equal(nfeat(dfm_trim(mydfm, max_termfreq = 4)), 6)

    expect_equal(nfeat(dfm_trim(mydfm, min_docfreq = 0.5, docfreq_type = "quantile")), 5)
    expect_equal(nfeat(dfm_trim(mydfm, min_docfreq = 2 / 3, docfreq_type = "prop")), 5)
    expect_equal(nfeat(dfm_trim(mydfm, min_docfreq = 2)), 5)
    
    expect_equal(nfeat(dfm_trim(mydfm, max_docfreq = 0.5, docfreq_type = "quantile")), 4)
    expect_equal(nfeat(dfm_trim(mydfm, max_docfreq = 2 / 3, docfreq_type = "prop")), 4)
    expect_equal(nfeat(dfm_trim(mydfm, max_docfreq = 2)), 4)
    
    expect_equal(nfeat(dfm_trim(mydfm, min_termfreq = 2, termfreq_type = "rank")), 3)
    expect_equal(nfeat(dfm_trim(mydfm, min_termfreq = 4)), 3)
    
    expect_equal(nfeat(dfm_trim(mydfm, max_termfreq = 4, termfreq_type = "rank")), 3)
    expect_equal(nfeat(dfm_trim(mydfm, max_termfreq = 3)), 3)
    
    expect_equal(nfeat(dfm_trim(mydfm, min_docfreq = 1, docfreq_type = "rank")), 2)
    expect_equal(nfeat(dfm_trim(mydfm, min_docfreq = 3)), 2)
    
    expect_equal(nfeat(dfm_trim(mydfm, max_docfreq = 2, docfreq_type = "rank")), 4)
    expect_equal(nfeat(dfm_trim(mydfm, max_docfreq = 2)), 4)
    
})

test_that("dfm_trim works as expected", {
    mydfm <- dfm(c("This is a sentence.", "This is a second sentence.", "Third sentence.", "Fouth sentence.", "Fifth sentence."))
    expect_message(dfm_trim(mydfm, min_termfreq = 2, min_docfreq = 2, verbose = TRUE),
                   regexp = "Removing features occurring:")
    expect_message(dfm_trim(mydfm, min_termfreq = 2, min_docfreq = 2, verbose = TRUE),
                   regexp = "fewer than 2 times: 4")
    expect_message(dfm_trim(mydfm, min_termfreq = 2, min_docfreq = 2, verbose = TRUE),
                   regexp = "in fewer than 2 documents: 4")
    expect_message(dfm_trim(mydfm, min_termfreq = 2, min_docfreq = 2, verbose = TRUE),
                   regexp = "  Total features removed: 4 \\(44.4%\\).")
})

test_that("dfm_trim works as expected", {
    mydfm <- dfm(c("This is a sentence.", "This is a second sentence.", "Third sentence.", "Fouth sentence.", "Fifth sentence."))
    expect_message(dfm_trim(mydfm, max_termfreq = 2, max_docfreq = 2, verbose = TRUE),
                   regexp = "more than 2 times: 2")
    expect_message(dfm_trim(mydfm, max_termfreq = 2, max_docfreq = 2, verbose = TRUE),
                   regexp = "in more than 2 documents: 2")
    
    expect_message(dfm_trim(mydfm, max_termfreq = 5, max_docfreq = 5, verbose = TRUE),
                   regexp = "No features removed.")
})

test_that("dfm_trim works without trimming arguments #509", {
    mydfm <- dfm(c("This is a sentence.", "This is a second sentence.", "Third sentence."))
    expect_equal(dim(mydfm[-2, ]), c(2, 7))
    expect_equal(dim(dfm_trim(mydfm[-2, ], verbose = FALSE)), c(2, 6))
})

test_that("dfm_trim doesn't break because of duplicated feature names (#829)", {
    mydfm <- dfm(c(d1 = "a b c d e", d2 = "a a b b e f", d3 = "b c e e f f f"))
    colnames(mydfm)[3] <- "b"
    expect_equal(
        as.matrix(dfm_trim(mydfm, min_termfreq = 1)),
        matrix(c(1,1,1,1,1,0, 2,2,0,0,1,1, 0,1,1,0,2,3), byrow = TRUE, nrow = 3,
               dimnames = list(docs = c("d1", "d2", "d3"), features = c(letters[c(1,2,2,4:6)])))
    )
    expect_equal(
        as.matrix(dfm_trim(mydfm, min_termfreq = 2)),
        matrix(c(1,1,1,1,0, 2,2,0,1,1, 0,1,1,2,3), byrow = TRUE, nrow = 3,
               dimnames = list(docs = c("d1", "d2", "d3"), features = c(letters[c(1,2,2,5:6)])))
    )
    expect_equal(
        as.matrix(dfm_trim(mydfm, min_termfreq = 3)),
        matrix(c(1,1,1,0, 2,2,1,1, 0,1,2,3), byrow = TRUE, nrow = 3,
               dimnames = list(docs = c("d1", "d2", "d3"), features = c(letters[c(1,2,5:6)])))
    )
})

test_that("dfm_trim works with min_termfreq larger than total number (#1181)", {
    
    testdfm <- dfm(c(d1 = "a a a a b b", d2 = "a b b c"))
    expect_equal(dimnames(dfm_trim(testdfm, min_termfreq = 6)), 
                list(docs = c("d1", "d2"), features = NULL)
    )
    expect_equal(dimnames(dfm_trim(testdfm, min_docfreq = 3)), 
                 list(docs = c("d1", "d2"), features = NULL)
    )

})

test_that("dfm_trim works on previously weighted dfms (#1237)", {
    dfm1 <- dfm(c("the quick brown fox jumps over the lazy dog", 
                  "the quick brown foxy ox jumps over the lazy god"))
    dfm2 <- dfm_tfidf(dfm1)
    expect_equal(
        dfm_trim(dfm2, min_termfreq = 0, min_docfreq = .5) %>% as.matrix(),
        matrix(c(.30103, 0, .30103, 0, 0, .30103, 0, .30103, 0, .30103), nrow = 2,
               dimnames = list(docs = c("text1", "text2"), 
                               features = c("fox", "dog", "foxy", "ox", "god"))),
        tol = .0001
    )
    expect_warning(
        dfm_trim(dfm2, min_docfreq = .5, docfreq_type = "prop"),
        "dfm has been previously weighted"
    )
    expect_warning(
        dfm_trim(dfm2, min_termfreq = 1, min_docfreq = .5, docfreq_type = "prop"),
        "dfm has been previously weighted"
    )
    
    expect_equal(
        dim(dfm_trim(dfm2, min_termfreq = 1, min_docfreq = .5, docfreq_type = "prop")),
        c(2, 0)
    )
})

test_that("dfm_trim warn when termfreq is termfreq_type = 'count' (#1254)", {
    dfm1 <- dfm(c("the quick brown fox jumps over the lazy dog", 
                  "the quick brown foxy ox jumps over the lazy god"))
    #dfm2 <- dfm_tfidf(dfm1)
    expect_warning(
        dfm_trim(dfm1, min_termfreq = 0.001, termfreq_type = "count"),
        "use termfreq_type = 'prop' for fractional term frequency"
    )
    #expect_silent(
    #    dfm_trim(dfm2, min_termfreq = 0.001, termfreq_type = "count")
    #)
    expect_warning(
        dfm_trim(dfm1, max_termfreq = 0.001, termfreq_type = "count"),
        "use termfreq_type = 'prop' for fractional term frequency"
    )
    #expect_silent(
    #    dfm_trim(dfm2, max_termfreq = 0.001, termfreq_type = "count")
    #)
})
