context('test textstat_dist.R')

# euclidean 
test_that("test textstat_dist method = \"euclidean\" against proxy dist() and stats dist(): features", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    eucQuanteda <- round(as.matrix(textstat_dist(presDfm, "soviet", method = "euclidean", margin = "features"))[,"soviet"], 2)
    eucQuanteda <- eucQuanteda[order(names(eucQuanteda))]
    eucQuanteda <- eucQuanteda[-which(names(eucQuanteda) == "soviet")]
    
    eucProxy <- round(drop(proxy::dist(as.matrix(presDfm), as.matrix(presDfm[, "soviet"]), "euclidean", by_rows = FALSE)), 2)
    eucProxy <- eucProxy[order(names(eucProxy))]
    eucProxy <- eucProxy[-which(names(eucProxy) == "soviet")]
    
    expect_equal(eucQuanteda, eucProxy)
})

test_that("test textstat_dist method = \"Euclidean\" against proxy dist() and stats dist(): documents", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    eucQuanteda <- sort(round(as.matrix(textstat_dist(presDfm, method = "euclidean", margin = "documents"))[,"1981-Reagan"], 6), decreasing = FALSE)
    eucProxy <- sort(round(as.matrix(proxy::dist(as.matrix(presDfm), "euclidean", diag = FALSE, upper = FALSE, p = 2))[, "1981-Reagan"], 6), decreasing = FALSE)
    eucStats <- sort(round(as.matrix(stats::dist(as.matrix(presDfm), method = "euclidean", diag = FALSE, upper = FALSE, p = 2))[,"1981-Reagan"], 6),  decreasing = FALSE)
    expect_equal(eucQuanteda, eucProxy)
    expect_equal(eucQuanteda, eucStats)
    
    # Only calculate distance on the selections
    eucQuanteda <- sort(round(as.matrix(textstat_dist(presDfm, "1981-Reagan", method = "euclidean", margin = "documents"))[,"1981-Reagan"], 6), decreasing = FALSE)
    expect_equal(eucQuanteda, eucProxy)
})

# Chi-squared distance 
# Instead of comparing to Proxy package, ExPosition is compared to. Because Proxy::simil uses different formula
# eucProxy <- sort(round(as.matrix(proxy::simil(as.matrix(presDfm), "Chi-squared", diag = FALSE, upper = FALSE))[, "1981-Reagan"], 6), decreasing = FALSE)
test_that("test textstat_dist method = \"Chi-squred\" against ExPosition::chi2Dist(): features", {
    skip_if_not_installed("ExPosition")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    chiQuanteda <- round(as.matrix(textstat_dist(presDfm, "soviet", method = "Chisquared", margin = "features"))[,"soviet"], 2)
    chiQuanteda <- chiQuanteda[order(names(chiQuanteda))]
    chiQuanteda <- chiQuanteda[-which(names(chiQuanteda) == "soviet")]
    
    chiExp <- ExPosition::chi2Dist(t(as.matrix(presDfm)))
    chiExp <- sort(round(as.matrix(chiExp$D)[, "soviet"], 2), decreasing = FALSE)
    chiExp <- chiExp[order(names(chiExp))]
    chiExp <- chiExp[-which(names(chiExp) == "soviet")]
    
    expect_equal(chiQuanteda, chiExp)
})

test_that("test textstat_dist method = \"Chi-squred\" against ExPosition::chi2Dist(): documents", {
    skip_if_not_installed("ExPosition")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    chiQuanteda <- sort(round(as.matrix(textstat_dist(presDfm, method = "Chisquared", margin = "documents"))[,"1981-Reagan"], 6), decreasing = FALSE)
    chiExp <- ExPosition::chi2Dist(as.matrix(presDfm))
    chiExp <- sort(round(as.matrix(chiExp$D)[, "1981-Reagan"], 6), decreasing = FALSE)
    expect_equal(chiQuanteda, chiExp)
    
    # use selection
    chiQuanteda <- sort(round(as.matrix(textstat_dist(presDfm, "1981-Reagan", method = "Chisquared", margin = "documents"))[,"1981-Reagan"], 6), decreasing = FALSE)
    expect_equal(chiQuanteda, chiExp)
})

# Kullback-Leibler divergence
# proxy::dist() will generate NA for matrix with zeros, hence a matrix only with non-zero entries is used here.
test_that("test textstat_dist method = \"Kullback-Leibler\" against proxy dist(): documents", {
    skip_if_not_installed("proxy")
    m <- matrix(rexp(550, rate=.1), nrow = 5)
    kullQuanteda <- round(as.matrix(textstat_dist(as.dfm(m), method = "kullback", margin = "documents")), 2)
    kullProxy <- round(as.matrix(proxy::dist(m, "kullback", diag = FALSE, upper = FALSE)), 2)
    expect_equivalent(kullQuanteda, kullProxy)
    
    rownames(m) <- c("a", "b", "c", "d", "e")
    mydfm <- new("dfm", Matrix::Matrix(as.matrix(m), sparse=TRUE, dimnames = list(docs = rownames(m), features=colnames(m))))
    kullQuanteda <- round(textstat_dist(mydfm, "a", method = "kullback", margin = "documents")[, "a"], 2)
    kullProxy <- round(drop(proxy::dist(as.matrix(mydfm), as.matrix(mydfm[1, ]), "kullback", diag = FALSE, upper = FALSE)), 2)
    kullProxy <- kullProxy[order(names(kullProxy))]
    expect_equivalent(kullQuanteda, kullProxy)
})

# Manhattan distance
test_that("test textstat_dist method = \"manhattan\" against proxy dist() : documents", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    manQuanteda <- round(as.matrix(textstat_dist(presDfm, method = "manhattan", margin = "documents")), 2)
    manProxy <- round(as.matrix(proxy::dist(as.matrix(presDfm), "manhattan", diag = FALSE, upper = FALSE)), 2)
    expect_equal(manQuanteda, manProxy)
})

test_that("test textstat_dist method = \"manhattan\" against proxy dist() : features", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    manQuanteda <- round(as.matrix(textstat_dist(presDfm, "soviet",  method = "manhattan", margin = "features"))[,"soviet"], 2)
    manQuanteda <- manQuanteda[order(names(manQuanteda))]
    manQuanteda <- manQuanteda[-which(names(manQuanteda) == "soviet")]
    
    manProxy <- round(drop(proxy::dist(as.matrix(presDfm), as.matrix(presDfm[, "soviet"]), "manhattan", by_rows = FALSE)), 2)
    manProxy <- manProxy[order(names(manProxy))]
    manProxy <- manProxy[-which(names(manProxy) == "soviet")]
    expect_equal(manQuanteda, manProxy)
})

# Maximum/Supremum distance
test_that("test textstat_dist method = \"Maximum\" against proxy dist() : documents", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    maxQuanteda <- round(as.matrix(textstat_dist(presDfm, method = "maximum", margin = "documents")), 2)
    maxProxy <- round(as.matrix(proxy::dist(as.matrix(presDfm), "maximum", diag = FALSE, upper = FALSE)), 2)
    expect_equal(maxQuanteda, maxProxy)
})

test_that("test textstat_dist method = \"Maximum\" against proxy dist() : features", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    maxQuanteda <- round(as.matrix(textstat_dist(presDfm, "soviet",  method = "maximum", margin = "features"))[,"soviet"], 2)
    maxQuanteda <- maxQuanteda[order(names(maxQuanteda))]
    maxQuanteda <- maxQuanteda[-which(names(maxQuanteda) == "soviet")]
    
    maxProxy <- round(drop(proxy::dist(as.matrix(presDfm), as.matrix(presDfm[, "soviet"]), "maximum", by_rows = FALSE)), 2)
    maxProxy <- maxProxy[order(names(maxProxy))]
    maxProxy <- maxProxy[-which(names(maxProxy) == "soviet")]
    expect_equal(maxQuanteda, maxProxy)
})

# Canberra distance
test_that("test textstat_dist method = \"Canberra\" against proxy dist() : documents", {
    
    skip_if_not_installed("proxy")
    skip_on_os("solaris")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    canQuanteda <- round(as.matrix(textstat_dist(presDfm, method = "canberra", margin = "documents")), 2)
    canProxy <- round(as.matrix(proxy::dist(as.matrix(presDfm), "canberra", diag = FALSE, upper = FALSE)), 2)
    expect_equal(canQuanteda, canProxy)
})

test_that("test textstat_dist method = \"Canberra\" against proxy dist() : features", {
    skip_if_not_installed("proxy")
    skip_on_os("solaris")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980 & Year < 2017), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    canQuanteda <- round(as.matrix(textstat_dist(presDfm, "soviet",  method = "canberra", margin = "features"))[,"soviet"], 2)
    canQuanteda <- canQuanteda[order(names(canQuanteda))]
    canQuanteda <- canQuanteda[-which(names(canQuanteda) == "soviet")]
    
    canProxy <- round(drop(proxy::dist(as.matrix(presDfm), as.matrix(presDfm[, "soviet"]), "canberra", by_rows = FALSE)), 2)
    canProxy <- canProxy[order(names(canProxy))]
    canProxy <- canProxy[-which(names(canProxy) == "soviet")]
    expect_equal(canQuanteda, canProxy)
})

# Minkowski distance
test_that("test textstat_dist method = \"Minkowski\" against proxy dist() : documents", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    minkQuanteda <- round(as.matrix(textstat_dist(presDfm, method = "minkowski", margin = "documents", p = 3)), 2)
    minkProxy <- round(as.matrix(proxy::dist(as.matrix(presDfm), "minkowski", diag = FALSE, upper = FALSE, p=3)), 2)
    expect_equal(minkQuanteda, minkProxy)
})

test_that("test textstat_dist method = \"Canberra\" against proxy dist() : features", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    minkQuanteda <- round(as.matrix(textstat_dist(presDfm, "soviet",  method = "minkowski", margin = "features", p = 4))[,"soviet"], 2)
    minkQuanteda <- minkQuanteda[order(names(minkQuanteda))]
    minkQuanteda <- minkQuanteda[-which(names(minkQuanteda) == "soviet")]
    
    minkProxy <- round(drop(proxy::dist(as.matrix(presDfm), as.matrix(presDfm[, "soviet"]), "minkowski", by_rows = FALSE, p = 4)), 2)
    minkProxy <- minkProxy[order(names(minkProxy))]
    minkProxy <- minkProxy[-which(names(minkProxy) == "soviet")]
    expect_equal(minkQuanteda, minkProxy)
})

# Hamming distance
test_that("test textstat_dist method = \"hamming\" against e1071::hamming.distance: documents", {
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980 & Year < 2018), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    hammingQuanteda <- sort(as.matrix(textstat_dist(presDfm, "1981-Reagan", method = "hamming", margin = "documents", upper = TRUE))[,"1981-Reagan"], decreasing = FALSE)
    hammingQuanteda <- hammingQuanteda[-which(names(hammingQuanteda) == "1981-Reagan")]
    
    if (requireNamespace("e1071", quietly = TRUE)) {
        hammingE1071 <- sort(e1071::hamming.distance(as.matrix(dfm_weight(presDfm, "boolean")))[, "1981-Reagan"], decreasing = FALSE)
        if("1981-Reagan" %in% names(hammingE1071)) hammingE1071 <- hammingE1071[-which(names(hammingE1071) == "1981-Reagan")]
    } else {
        hammingE1071 <- c(712, 723, 746, 769, 774, 781, 784, 812, 857)
    }
    expect_equivalent(hammingQuanteda, hammingE1071)
})

test_that("test textstat_dist method = \"hamming\" against e1071::hamming.distance: features", {
    skip_if_not_installed("e1071")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    hammingQuanteda <- textstat_dist(presDfm, "soviet", method = "hamming", margin = "features")[,"soviet"]
    hammingQuanteda <- hammingQuanteda[order(names(hammingQuanteda))]
    hammingQuanteda <- hammingQuanteda[-which(names(hammingQuanteda) == "soviet")]
    
    presM <- t(as.matrix(dfm_weight(presDfm, "boolean")))
    hammingE1071 <- e1071::hamming.distance(presM)[, "soviet"]
    hammingE1071 <- hammingE1071[order(names(hammingE1071))]
    if("soviet" %in% names(hammingE1071)) hammingE1071 <- hammingE1071[-which(names(hammingE1071) == "soviet")]
    expect_equal(hammingQuanteda, hammingE1071)
})

test_that("test textstat_dist method = \"binary\" against proxy::simil(): features", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    jacQuanteda <- round(as.matrix(textstat_dist(presDfm, "soviet", method = "binary", margin = "features"))[,"soviet"], 2)
    jacQuanteda <- jacQuanteda[order(names(jacQuanteda))]
    jacQuanteda <- jacQuanteda[-which(names(jacQuanteda) == "soviet")]
    
    jacProxy <- round(drop(proxy::simil(as.matrix(presDfm), as.matrix(presDfm[, "soviet"]), "binary", by_rows = FALSE)), 2)
    jacProxy <- jacProxy[order(names(jacProxy))]
    if("soviet" %in% names(jacProxy)) jacProxy <- jacProxy[-which(names(jacProxy) == "soviet")]
    
    expect_equal(jacQuanteda, jacProxy)
})

test_that("as.list.dist works as expected",{
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    ddist <- textstat_dist(presDfm, method = "hamming")
    expect_equal(
        as.list(ddist)$`1981-Reagan`[1:3], 
        c("2009-Obama" = 857, "2013-Obama" = 812, "1997-Clinton" = 784)
    )
})

test_that("as.list.dist_selection works as expected", {
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    ddist <- textstat_dist(presDfm, c("2017-Trump", "2013-Obama"), margin = "documents")
    ddist_list <- as.list(ddist)
    expect_equal(names(ddist_list), c("2017-Trump", "2013-Obama"))
    expect_null(ddist_list$"1985-Reagan")
    expect_equal(names(ddist_list$`2017-Trump`)[1:3], c("1985-Reagan", "1981-Reagan", "1989-Bush"))
})

test_that("textstat_dist stops as expected for methods not supported",{
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    expect_error(textstat_dist(presDfm, method = "Yule"), 
                 "yule is not implemented; consider trying proxy::dist\\(\\)")
})

# test_that("textstat_dist stops as expected for wrong selections",{
#     presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
#                    stem = TRUE, verbose = FALSE)
#     expect_error(textstat_dist(presDfm, 5), 
#                  "The vector/matrix specified by 'selection' must be conform to the object x in columns")
#     expect_error(textstat_dist(presDfm, 5, margin = "features"), 
#                  "The vector/matrix specified by 'selection' must be conform to the object x in rows")
#     
#     
#     
#     expect_error(textstat_dist(presDfm, margin = "documents", "2009-Obamaa"), 
#                  "The documents specified by 'selection' do not exist.")
#     expect_error(textstat_dist(presDfm, margin = "features", "Obamaa"), 
#                  "The features specified by 'selection' do not exist.")
#     
# })

test_that("as.dist on a dist returns a dist", {
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1990), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    distmat <- textstat_dist(presDfm)
    expect_equivalent(as.dist(distmat), distmat) 
    expect_equivalent(textstat_dist(presDfm, upper = TRUE), 
                      as.dist(distmat, upper = TRUE)) 
    expect_equivalent(textstat_dist(presDfm, upper = TRUE, diag = TRUE), 
                      as.dist(distmat, upper = TRUE, diag = TRUE)) 
})

test_that("selection offers option to enable an alien vector/matrix", {
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1990), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    expect_error(textstat_dist(presDfm, c(1,2,3,4,5,6,7), margin = "features"), NA)
    
})


test_that("selection works with dfm with padding", {
    
    toks <- tokens(c(doc1 = "a b c d e", doc2 = "b c f e"), remove_punct = TRUE)
    toks <- tokens_remove(toks, "b", padding = TRUE)
    mt <- dfm(toks)
    expect_silent(textstat_dist(mt, selection = c("c"), margin = "features"))
    expect_silent(textstat_dist(mt, selection = c(""), margin = "features"))
    expect_silent(textstat_dist(mt, selection = c("doc2"), margin = "documents"))
    
})
