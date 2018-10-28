context("test textstat_simil.R")

# correlation
test_that("test textstat_simil method = \"correlation\" against proxy simil(): documents", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    corQuanteda <- sort(round(as.matrix(textstat_simil(presDfm, method = "correlation", margin = "documents"))[,"1981-Reagan"], 6), decreasing = TRUE)
    corProxy <- sort(round(as.matrix(proxy::simil(as.matrix(presDfm), by_rows = TRUE, diag = TRUE))[, "1981-Reagan"], 6), decreasing = TRUE)
    corCor <- sort(round(cor(as.matrix(t(presDfm)))[, "1981-Reagan"], 6), decreasing = TRUE)
    expect_equal(corQuanteda, corProxy)
    expect_equal(corProxy, corCor)
})

test_that("test textstat_simil method = \"correlation\" against base cor(): features (allow selection)", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    corQuanteda <- sort(round(as.matrix(textstat_simil(presDfm, "union", method = "correlation", margin = "features"))[,"union"], 6), decreasing = TRUE)
    corStats <- sort(round(cor(as.matrix(presDfm))[, "union"], 6), decreasing = TRUE)
    expect_equal(corQuanteda[1:10], corStats[1:10])
})

# cosine
test_that("test textstat_simil method = \"cosine\" against proxy simil(): features", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    cosQuanteda <- round(as.matrix(textstat_simil(presDfm, method = "cosine", margin = "features"))[,"soviet"], 2)
    cosQuanteda <- cosQuanteda[order(names(cosQuanteda))]
    cosQuanteda <- cosQuanteda[-which(names(cosQuanteda) == "soviet")]
    
    cosProxy <- round(drop(proxy::simil(as.matrix(presDfm), as.matrix(presDfm[, "soviet"]), "cosine", by_rows = FALSE)), 2)
    cosProxy <- cosProxy[order(names(cosProxy))]
    cosProxy <- cosProxy[-which(names(cosProxy) == "soviet")]
    
    expect_equal(cosQuanteda, cosProxy)
})


test_that("test textstat_simil method = \"cosine\" against proxy simil(): documents", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    cosQuanteda <- sort(round(as.matrix(textstat_simil(presDfm, method = "cosine", margin = "documents"))[,"1981-Reagan"], 6), decreasing = TRUE)
    cosProxy <- sort(round(as.matrix(proxy::simil(as.matrix(presDfm), "cosine", by_rows = TRUE, diag = TRUE))[, "1981-Reagan"], 6), decreasing = TRUE)
    expect_equal(cosQuanteda[-9], cosProxy[-9])
})

# jaccard - binary
test_that("test textstat_simil method = \"jaccard\" against proxy::simil(): documents", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    jacQuanteda <- sort(round(as.matrix(textstat_simil(presDfm, "1981-Reagan", method = "jaccard", margin = "documents", diag= FALSE, upper = TRUE))[,"1981-Reagan"], 6), decreasing = FALSE)
    jacQuanteda <- jacQuanteda[-which(names(jacQuanteda) == "1981-Reagan")]
    jacProxy <- sort(round(as.matrix(proxy::simil(as.matrix(presDfm), "jaccard", diag = FALSE, upper = FALSE, p = 2))[, "1981-Reagan"], 6), decreasing = FALSE)
    if("1981-Reagan" %in% names(jacProxy)) jacProxy <- jacProxy[-which(names(jacProxy) == "1981-Reagan")]
    expect_equal(jacQuanteda, jacProxy)
})

test_that("test textstat_simil method = \"jaccard\" against proxy::simil(): features", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    jacQuanteda <- round(as.matrix(textstat_simil(presDfm, "soviet", method = "jaccard", margin = "features"))[,"soviet"], 2)
    jacQuanteda <- jacQuanteda[order(names(jacQuanteda))]
    jacQuanteda <- jacQuanteda[-which(names(jacQuanteda) == "soviet")]
    
    jacProxy <- round(drop(proxy::simil(as.matrix(presDfm), as.matrix(presDfm[, "soviet"]), "jaccard", by_rows = FALSE)), 2)
    jacProxy <- jacProxy[order(names(jacProxy))]
    if("soviet" %in% names(jacProxy)) jacProxy <- jacProxy[-which(names(jacProxy) == "soviet")]
    
    expect_equal(jacQuanteda, jacProxy)
    
    # slow way -- y is null
    jacQuanteda <- round(as.matrix(textstat_simil(presDfm, method = "jaccard", margin = "features"))[,"soviet"], 2)
    jacQuanteda <- jacQuanteda[order(names(jacQuanteda))]
    jacQuanteda <- jacQuanteda[-which(names(jacQuanteda) == "soviet")]
    expect_equal(jacQuanteda, jacProxy)
})

# ejaccard - real-valued data
test_that("test textstat_simil method = \"ejaccard\" against proxy::simil(): documents", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    ejacQuanteda <- sort(round(as.matrix(textstat_simil(presDfm, "1981-Reagan", method = "ejaccard", margin = "documents", upper = TRUE))[,"1981-Reagan"], 6), decreasing = FALSE)
    ejacQuanteda <- ejacQuanteda[-which(names(ejacQuanteda) == "1981-Reagan")]
    ejacProxy <- sort(round(as.matrix(proxy::simil(as.matrix(presDfm), "ejaccard", diag = FALSE, upper = FALSE, p = 2))[, "1981-Reagan"], 6), decreasing = FALSE)
    if("1981-Reagan" %in% names(ejacProxy)) ejacProxy <- ejacProxy[-which(names(ejacProxy) == "1981-Reagan")]
    expect_equal(ejacQuanteda, ejacProxy)
})

test_that("test textstat_simil method = \"ejaccard\" against proxy::simil(): features", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    ejacQuanteda <- round(as.matrix(textstat_simil(presDfm, "soviet", method = "ejaccard", margin = "features"))[,"soviet"], 2)
    ejacQuanteda <- ejacQuanteda[order(names(ejacQuanteda))]
    ejacQuanteda <- ejacQuanteda[-which(names(ejacQuanteda) == "soviet")]
    
    ejacProxy <- round(drop(proxy::simil(as.matrix(presDfm), as.matrix(presDfm[, "soviet"]), "ejaccard", by_rows = FALSE)), 2)
    ejacProxy <- ejacProxy[order(names(ejacProxy))]
    if("soviet" %in% names(ejacProxy)) ejacProxy <- ejacProxy[-which(names(ejacProxy) == "soviet")]
    
    expect_equal(ejacQuanteda, ejacProxy)
    
    # slow way -- y is null
    ejacQuanteda <- round(as.matrix(textstat_simil(presDfm, method = "ejaccard", margin = "features"))[,"soviet"], 2)
    ejacQuanteda <- ejacQuanteda[order(names(ejacQuanteda))]
    ejacQuanteda <- ejacQuanteda[-which(names(ejacQuanteda) == "soviet")]
    expect_equal(ejacQuanteda, ejacProxy)
})

# dice -binary
test_that("test textstat_simil method = \"dice\" against proxy::simil(): documents", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    diceQuanteda <- sort(round(as.matrix(textstat_simil(presDfm, "1981-Reagan", method = "dice", margin = "documents", upper = TRUE))[,"1981-Reagan"], 6), decreasing = FALSE)
    diceQuanteda <- diceQuanteda[-which(names(diceQuanteda) == "1981-Reagan")]
    diceProxy <- sort(round(as.matrix(proxy::simil(as.matrix(presDfm), "dice", diag = FALSE, upper = FALSE))[, "1981-Reagan"], 6), decreasing = FALSE)
    if("1981-Reagan" %in% names(diceProxy)) diceProxy <- diceProxy[-which(names(diceProxy) == "1981-Reagan")]
    expect_equal(diceQuanteda, diceProxy)
    
    # slow way -- y is null
    diceQuanteda <- sort(round(as.matrix(textstat_simil(presDfm, method = "dice", margin = "documents", upper = TRUE))[,"1981-Reagan"], 6), decreasing = FALSE)
    diceQuanteda <- diceQuanteda[-which(names(diceQuanteda) == "1981-Reagan")]
    expect_equal(diceQuanteda, diceProxy)
})

test_that("test textstat_simil method = \"dice\" against proxy::simil(): features", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    diceQuanteda <- round(as.matrix(textstat_simil(presDfm, "soviet", method = "dice", margin = "features"))[,"soviet"], 2)
    diceQuanteda <- diceQuanteda[order(names(diceQuanteda))]
    diceQuanteda <- diceQuanteda[-which(names(diceQuanteda) == "soviet")]
    
    diceProxy <- round(drop(proxy::simil(as.matrix(presDfm), as.matrix(presDfm[, "soviet"]), "dice", by_rows = FALSE)), 2)
    diceProxy <- diceProxy[order(names(diceProxy))]
    diceProxy <- diceProxy[-which(names(diceProxy) == "soviet")]
    
    expect_equal(diceQuanteda, diceProxy)
})

# edice -real valued data
test_that("test textstat_simil method = \"edice\" against proxy::simil(): documents", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    ediceQuanteda <- sort(round(as.matrix(textstat_simil(presDfm, "1981-Reagan", method = "edice", margin = "documents", upper = TRUE))[,"1981-Reagan"], 6), decreasing = FALSE)
    ediceQuanteda <- ediceQuanteda[-which(names(ediceQuanteda) == "1981-Reagan")]
    ediceProxy <- sort(round(as.matrix(proxy::simil(as.matrix(presDfm), "edice", diag = FALSE, upper = FALSE))[, "1981-Reagan"], 6), decreasing = FALSE)
    if("1981-Reagan" %in% names(ediceProxy)) ediceProxy <- ediceProxy[-which(names(ediceProxy) == "1981-Reagan")]
    expect_equal(ediceQuanteda, ediceProxy)
    
    # y is null
    ediceQuanteda <- sort(round(as.matrix(textstat_simil(presDfm, method = "edice", margin = "documents", upper = TRUE))[,"1981-Reagan"], 6), decreasing = FALSE)
    ediceQuanteda <- ediceQuanteda[-which(names(ediceQuanteda) == "1981-Reagan")]
    expect_equal(ediceQuanteda, ediceProxy)
})

test_that("test textstat_simil method = \"edice\" against proxy::simil(): features", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    ediceQuanteda <- round(as.matrix(textstat_simil(presDfm, "soviet", method = "edice", margin = "features"))[,"soviet"], 2)
    ediceQuanteda <- ediceQuanteda[order(names(ediceQuanteda))]
    ediceQuanteda <- ediceQuanteda[-which(names(ediceQuanteda) == "soviet")]
    
    ediceProxy <- round(drop(proxy::simil(as.matrix(presDfm), as.matrix(presDfm[, "soviet"]), "edice", by_rows = FALSE)), 2)
    ediceProxy <- ediceProxy[order(names(ediceProxy))]
    ediceProxy <- ediceProxy[-which(names(ediceProxy) == "soviet")]
    
    expect_equal(ediceQuanteda, ediceProxy)
})

# simple matching coefficient
test_that("test textstat_simil method = \"simple matching\" against proxy::simil(): documents", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    smcQuanteda <- sort(round(as.matrix(textstat_simil(presDfm, "1981-Reagan", method = "simple matching", margin = "documents", upper = TRUE))[,"1981-Reagan"], 6), decreasing = FALSE)
    smcQuanteda <- smcQuanteda[-which(names(smcQuanteda) == "1981-Reagan")]
    smcProxy <- sort(round(as.matrix(proxy::simil(as.matrix(presDfm), "simple matching", diag = FALSE, upper = FALSE))[, "1981-Reagan"], 6), decreasing = FALSE)
    if("1981-Reagan" %in% names(smcProxy)) smcProxy <- smcProxy[-which(names(smcProxy) == "1981-Reagan")]
    expect_equal(smcQuanteda, smcProxy)
    
    #slow way: y is null
    smcQuanteda <- sort(round(as.matrix(textstat_simil(presDfm, method = "simple matching", margin = "documents", upper = TRUE))[,"1981-Reagan"], 6), decreasing = FALSE)
    smcQuanteda <- smcQuanteda[-which(names(smcQuanteda) == "1981-Reagan")]
    expect_equal(smcQuanteda, smcProxy)
})

test_that("test textstat_simil method = \"simple matching\" against proxy::simil(): features", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    smcQuanteda <- round(as.matrix(textstat_simil(presDfm, "soviet", method = "simple matching", margin = "features"))[,"soviet"], 2)
    smcQuanteda <- smcQuanteda[order(names(smcQuanteda))]
    smcQuanteda <- smcQuanteda[-which(names(smcQuanteda) == "soviet")]
    
    smcProxy <- round(drop(proxy::simil(as.matrix(presDfm), as.matrix(presDfm[, "soviet"]), "simple matching", by_rows = FALSE)), 2)
    smcProxy <- smcProxy[order(names(smcProxy))]
    smcProxy <- smcProxy[-which(names(smcProxy) == "soviet")]
    
    expect_equal(smcQuanteda, smcProxy)
})

# Hamann similarity (Hamman similarity in proxy::dist)
test_that("test textstat_simil method = \"hamann\" against proxy::simil(): documents", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    hamnQuanteda <- sort(round(as.matrix(textstat_simil(presDfm, "1981-Reagan", method = "hamann", margin = "documents", upper = TRUE))[,"1981-Reagan"], 6), decreasing = FALSE)
    hamnQuanteda <- hamnQuanteda[-which(names(hamnQuanteda) == "1981-Reagan")]
    hamnProxy <- sort(round(as.matrix(proxy::simil(as.matrix(presDfm), "hamman", diag = FALSE, upper = FALSE))[, "1981-Reagan"], 6), decreasing = FALSE)
    if("1981-Reagan" %in% names(hamnProxy)) hamnProxy <- hamnProxy[-which(names(hamnProxy) == "1981-Reagan")]
    expect_equal(hamnQuanteda, hamnProxy)
    
    # y is null
    hamnQuanteda <- sort(round(as.matrix(textstat_simil(presDfm, method = "hamann", margin = "documents", upper = TRUE))[,"1981-Reagan"], 6), decreasing = FALSE)
    hamnQuanteda <- hamnQuanteda[-which(names(hamnQuanteda) == "1981-Reagan")]
    expect_equal(hamnQuanteda, hamnProxy)
})

test_that("test textstat_simil method = \"hamann\" against proxy::simil(): features", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    hamnQuanteda <- round(as.matrix(textstat_simil(presDfm, "soviet", method = "hamann", margin = "features"))[,"soviet"], 2)
    hamnQuanteda <- hamnQuanteda[order(names(hamnQuanteda))]
    hamnQuanteda <- hamnQuanteda[-which(names(hamnQuanteda) == "soviet")]
    
    hamnProxy <- round(drop(proxy::simil(as.matrix(presDfm), as.matrix(presDfm[, "soviet"]), "hamman", by_rows = FALSE)), 2)
    hamnProxy <- hamnProxy[order(names(hamnProxy))]
    hamnProxy <- hamnProxy[-which(names(hamnProxy) == "soviet")]
    
    expect_equal(hamnQuanteda, hamnProxy)
})

# Faith similarity 
test_that("test textstat_simil method = \"faith\" against proxy::simil(): documents", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    faithQuanteda <- sort(round(as.matrix(textstat_simil(presDfm, "1981-Reagan", method = "faith", margin = "documents", upper = TRUE))[,"1981-Reagan"], 6), decreasing = FALSE)
    faithQuanteda <- faithQuanteda[-which(names(faithQuanteda) == "1981-Reagan")]
    faithProxy <- sort(round(as.matrix(proxy::simil(as.matrix(presDfm), "faith", diag = FALSE, upper = FALSE))[, "1981-Reagan"], 6), decreasing = FALSE)
    if("1981-Reagan" %in% names(faithProxy)) faithProxy <- faithProxy[-which(names(faithProxy) == "1981-Reagan")]
    expect_equal(faithQuanteda, faithProxy)
})

test_that("test textstat_simil method = \"faith\" against proxy::simil(): features", {
    skip_if_not_installed("proxy")
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    faithQuanteda <- round(as.matrix(textstat_simil(presDfm, "soviet", method = "faith", margin = "features"))[,"soviet"], 2)
    faithQuanteda <- faithQuanteda[order(names(faithQuanteda))]
    faithQuanteda <- faithQuanteda[-which(names(faithQuanteda) == "soviet")]
    
    faithProxy <- round(drop(proxy::simil(as.matrix(presDfm), as.matrix(presDfm[, "soviet"]), "faith", by_rows = FALSE)), 2)
    faithProxy <- faithProxy[order(names(faithProxy))]
    faithProxy <- faithProxy[-which(names(faithProxy) == "soviet")]
    
    expect_equal(faithQuanteda, faithProxy)
    
    # y is null
    faithQuanteda <- round(as.matrix(textstat_simil(presDfm, method = "faith", margin = "features"))[,"soviet"], 2)
    faithQuanteda <- faithQuanteda[order(names(faithQuanteda))]
    faithQuanteda <- faithQuanteda[-which(names(faithQuanteda) == "soviet")]
    expect_equal(faithQuanteda, faithProxy)
    
})

test_that("as.matrix.simil works as expected",{
    documents <- c('Bacon ipsum dolor amet tenderloin hamburger bacon t-bone, ', 
                  'Tenderloin turducken corned beef bacon. ', 
                  ' Burgdoggen venison tail, hamburger filet mignon capicola meatloaf pig pork belly. ')
    dtm <- dfm(tokens(documents))
    
    sim <- as.matrix(textstat_simil(dtm))
    aMat <- c(1,1,1)
    expect_equivalent(diag(sim), aMat)
})

test_that("textstat_simil stops as expected for methods not supported",{
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    expect_error(textstat_simil(presDfm, method = "Yule"), 
    "Yule is not implemented; consider trying proxy::simil\\(\\)")
})

# test_that("textstat_simil stops as expected for wrong selections",{
#     presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
#                    stem = TRUE, verbose = FALSE)
#     expect_error(textstat_simil(presDfm, selection = 5), 
#                  "The vector/matrix specified by 'selection' must be conform to the object x in columns")
#     expect_error(textstat_simil(presDfm, selection = 5, margin = "features"), 
#                  "The vector/matrix specified by 'selection' must be conform to the object x in rows")
#     
#     expect_error(textstat_simil(presDfm, margin = "documents", selection = "2009-Obamaa"), 
#                  "The documents specified by 'selection' do not exist.")
#     expect_error(textstat_simil(presDfm, margin = "features", selection = "Obamaa"), 
#                  "The features specified by 'selection' do not exist.")
#     
# })

# test_that("test textstat_simil works as expected for 'n' is not NULL", {
#     skip_if_not_installed("proxy")
#     presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove = stopwords("english"),
#                    stem = TRUE, verbose = FALSE)
#     
#     cosQuanteda <- round(as.matrix(suppressWarnings(textstat_simil(presDfm, method = "cosine", margin = "documents")))[,"1981-Reagan"], 6)
#     cosProxy <- round(as.matrix(proxy::simil(as.matrix(presDfm), "cosine", by_rows = TRUE, diag = TRUE))[, "1981-Reagan"], 6)
#     expect_equal(cosQuanteda, cosProxy[1:5])
# })

# test_that("as.dist on a dist returns a dist", {
#     presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1990), remove = stopwords("english"),
#                    stem = TRUE, verbose = FALSE)
#     similmat <- textstat_simil(presDfm)
#     expect_equivalent(as.simil(similmat), similmat) 
#     expect_equivalent(textstat_simil(presDfm, upper = TRUE), 
#                       as.dist(distmat, upper = TRUE)) 
#     expect_equivalent(textstat_dist(presDfm, upper = TRUE, diag = TRUE), 
#                       as.dist(distmat, upper = TRUE, diag = TRUE)) 
# })

test_that("textstat_simil works on zero-frequency features", {
    d1 <- dfm(c("a b c", "a b c d"))
    d2 <- dfm(letters[1:6])
    dtest <- dfm_select(d1, d2)
    
    expect_equal(
        as.numeric(textstat_simil(dtest, method = "cosine")),
        0.866,
        tolerance = 0.001
    )    
    expect_equal(
        as.numeric(textstat_simil(dtest, method = "correlation")),
        0.707,
        tolerance = 0.001
    )    
})

test_that("textstat_simil works on zero-feature documents (#952)", {
    corp <- corpus(c('a b c c', 'b c d', 'a'),
                   docvars = data.frame(grp = factor(c("A", "A", "B"), levels = LETTERS[1:3])))
    testdfm <- dfm(corp)
    dtest <- dfm_group(testdfm, groups = "grp", fill = TRUE)

    expect_equal(
        as.numeric(textstat_simil(dtest, method = "cosine")),
        c(.2581, 0, 0),
        tolerance = .001
    )    
    expect_equal(
        as.numeric(textstat_simil(dtest, method = "correlation")),
        c(-.52222, NaN, NaN),
        tolerance = .001
    )    
})

test_that("selection offers option to enable an alien vector/matrix", {
    presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1990), remove = stopwords("english"),
                   stem = TRUE, verbose = FALSE)
    
    expect_error(textstat_simil(presDfm, c(1,2,3,4,5,6,7), margin = "features"), NA)
    
})

test_that("selection works with dfm with padding", {
    
    toks <- tokens(c(doc1 = 'a b c d e', doc2 = 'b c f e'), remove_punct = TRUE)
    toks <- tokens_remove(toks, 'b', padding = TRUE)
    mt <- dfm(toks)
    expect_silent(textstat_simil(mt, selection = c('c'), margin = 'features'))
    expect_silent(textstat_simil(mt, selection = c(''), margin = 'features'))
    expect_silent(textstat_simil(mt, selection = c('doc2'), margin = 'documents'))
    
})
