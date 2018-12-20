
test_that("test similarity method = \"correlation\" against base cor()", {
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    corQuanteda <- round(as.list(textstat_simil(presDfm, "union", method = "correlation", margin = "features"))[["union"]], 6)
    corStats <- sort(round(cor(as.matrix(presDfm))[, "union"], 6), decreasing = TRUE)
    expect_equal(corQuanteda[1:10], corStats[2:11])
})

test_that("test similarity method = \"cosine\" against proxy simil()", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    cosQuanteda <- round(as.list(textstat_simil(presDfm, "soviet", method = "cosine", margin = "features"))[["soviet"]], 2)
    cosQuanteda <- cosQuanteda[order(names(cosQuanteda))]
    
    cosProxy <- round(drop(proxy::simil(as.matrix(presDfm), as.matrix(presDfm[, "soviet"]), "cosine", by_rows = FALSE)), 2)
    cosProxy <- cosProxy[order(names(cosProxy))]
    cosProxy <- cosProxy[-which(names(cosProxy) == "soviet")]

    expect_equal(cosQuanteda, cosProxy)
})


test_that("test similarity method = \"cosine\" against proxy simil(): documents", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    cosQuanteda <- round(as.list(textstat_simil(presDfm, method = "cosine", margin = "documents"))[["1981-Reagan"]], 6)[-1]
    cosQuanteda <- round(as.matrix(textstat_simil(presDfm, method = "cosine", margin = "documents")), 6)
    (cosQuanteda <- cosQuanteda[order(rownames(cosQuanteda)), ])
    
    cosProxy <- sort(round(as.matrix(proxy::simil(as.matrix(presDfm), "cosine", by_rows = TRUE))[, "1981-Reagan"], 6), decreasing = TRUE)
    cosProxy <- round(proxy::as.matrix(proxy::simil(as.matrix(presDfm), "cosine", by_rows = TRUE), diag = 1.0), 6)
    (cosProxy <- cosProxy[order(rownames(cosProxy)), ])
    #(cosQlcMatrix <- round(as.matrix(qlcMatrix::cosSparse(t(presDfm))), 6))
    
    expect_equal(cosQuanteda, cosProxy)
})

test_that("test similarity method = \"correlation\" against proxy simil(): documents", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980 & Year < 2017), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    corQuanteda <- round(as.list(textstat_simil(presDfm, method = "correlation", margin = "documents"))[["1981-Reagan"]], 6)
    corProxy <- sort(round(as.matrix(proxy::simil(as.matrix(presDfm), "correlation", by_rows = TRUE))[, "1981-Reagan"], 6), decreasing = TRUE)
    corCor <- sort(cor(as.matrix(t(presDfm)))[, "1981-Reagan"], decreasing = TRUE)
    expect_equal(corQuanteda, corProxy[-1], corCor[-1])
})


test_that("simple similarity comparisons method = \"cosine\" against proxy simil()", {
    skip_if_not_installed("proxy")
    testText <- c("The quick brown fox named Seamus jumps over the lazy dog also named Seamus, with the newspaper from a boy named quick Seamus, in his mouth.", 
                  "the quick brown Seamus named dog jumped.", 
                  "My lazy dog who looks like a quick fox was in the newspaper.")
    d <- dfm(testText, verbose = FALSE)

    matQuanteda <- as.matrix(textstat_simil(d, "a", method = "cosine", margin = "features"))
    res1 <- matQuanteda[order(rownames(matQuanteda)), , drop = FALSE]
        
    matProxy <- proxy::simil(as.matrix(d), as.matrix(d[,"a"]), "cosine", by_rows = FALSE)
    res2 <- matProxy[order(rownames(matProxy)), , drop = FALSE]
    
    expect_equal(rownames(res1), rownames(res2))
    expect_equal(res1[,1], res2[,1])
})
    
