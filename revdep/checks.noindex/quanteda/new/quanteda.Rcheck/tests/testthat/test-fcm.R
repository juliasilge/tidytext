context('Testing fcm*.R')

test_that("compare the output feature co-occurrence matrix to that of the text2vec package", {
    skip_if_not_installed("text2vec")
    library("text2vec")
    
    txt <- "A D A C E A D F E B A C E D"
    tokens <- txt %>% tolower %>% word_tokenizer
    it <- itoken(tokens)
    v <- create_vocabulary(it)
    vectorizer <- vocab_vectorizer(v)
    tcm <- create_tcm(itoken(tokens), vectorizer, skip_grams_window = 3L)
    
    # convert to a symmetric matrix to facilitate the sorting
    tcm <- as.matrix(tcm)
    ttcm <- tcm
    diag(ttcm) <- 0
    tcm <- tcm + t(ttcm)
    
    # sort the matrix according to rowname-colname and convert back to a upper triangle matrix
    tcm <- tcm[order(rownames(tcm)), order(colnames(tcm))]
    tcm[lower.tri(tcm, diag = FALSE)] <- 0
    
    toks <- tokens(char_tolower(txt), remove_punct = TRUE)
    fcm <- fcm(toks, context = "window", count = "weighted", window = 3)
    fcm <- fcm_sort(fcm)
    expect_true(all(round(fcm, 2) == round(tcm, 2)))
    
})

# Testing weighting function

test_that("not weighted",{
    txt <- "A D A C E A D F E B A C E D"
    fcm <- fcm(txt, context = "window", window = 3) 
    
    # serial implementation of cpp function
    toks <- tokens(txt)
    n <- sum(lengths(unlist(toks))) * 3 * 2
    fcm_s <- quanteda:::qatd_cpp_fcm(toks, length(unique(unlist(toks))), 'frequency', 3, 1, FALSE, TRUE, n)
    expect_equivalent(fcm,fcm_s)
    
    aMat <- matrix(c(2, 1, 4, 4, 5, 2,
                     0, 0, 1, 1, 2, 1,
                     0, 0, 0, 3, 3, 0,
                     0, 0, 0, 0, 4, 1,
                     0, 0, 0, 0, 0, 2,
                     0, 0, 0, 0, 0, 0),
                   nrow = 6, ncol = 6, byrow = TRUE)
    fcm <- fcm_sort(fcm)
    expect_equivalent(as.matrix(fcm), aMat)
})

test_that("weighted by default",{
    txt <- "A D A C E A D F E B A C E D"
    fcm <- fcm(txt, context = "window", count = "weighted", window = 3)           
    
    # serial implementation of cpp function
    toks <- tokens(txt)
    n <- sum(lengths(unlist(toks))) * 3 * 2
    fcm_s <- quanteda:::qatd_cpp_fcm(toks, length(unique(unlist(toks))), 'weighted', 3, 1, FALSE, TRUE, n)
    expect_equivalent(fcm,fcm_s)
    
    
    toks <- tokens(txt)
    fcmTexts <- fcm(toks, context = "window", count = "weighted", window = 3) 
    expect_equivalent(round(as.matrix(fcm), 2), round(as.matrix(fcmTexts), 2))
    
    aMat <- matrix(c(0.83, 1, 2.83, 3.33, 2.83, 0.83,
                     0, 0, 0.5, 0.33, 1.33, 0.50,
                     0, 0, 0, 1.33, 2.33, 0,
                     0, 0, 0, 0, 2.33, 1.00,
                     0, 0, 0, 0, 0, 1.33,
                     0, 0, 0, 0, 0, 0),
                   nrow = 6, ncol = 6, byrow = TRUE)
    fcm <- fcm_sort(fcm)
    expect_equivalent(aMat, round(as.matrix(fcm), 2))
})

test_that("customized weighting function",{
    txt <- "A D A C E A D F E B A C E D"
    fcm <- fcm(txt, context = "window", count = "weighted", weights = c(3,2,1), window = 3)           
    
    # serial implementation of cpp function
    toks <- tokens(txt)
    n <- sum(lengths(unlist(toks))) * 3 * 2
    fcm_s <- quanteda:::qatd_cpp_fcm(toks, length(unique(unlist(toks))), 'weighted', 3, c(3,2,1), FALSE, TRUE, n)
    expect_equivalent(fcm,fcm_s)
    
    
    toks <- tokens(txt)
    fcmTexts <- fcm(toks, context = "window", count = "weighted",  weights = c(3,2,1), window = 3) 
    expect_equivalent(round(as.matrix(fcm), 2), round(as.matrix(fcmTexts), 2))
    
    aMat <- matrix(c(3, 3, 9, 10, 10, 3,
                     0, 0, 2, 1, 4, 2,
                     0, 0, 0, 5, 7, 0,
                     0, 0, 0, 0, 8, 3,
                     0, 0, 0, 0, 0, 4,
                     0, 0, 0, 0, 0, 0),
                   nrow = 6, ncol = 6, byrow = TRUE)
    fcm <- fcm_sort(fcm)
    expect_equivalent(aMat, round(as.matrix(fcm), 2))
})

# Testing 'ordered' 
test_that("ordered setting: window",{
    txt <- "A D A C E A D F E B A C E D"
    fcm <- fcm(txt, context = "window", window = 3, ordered = TRUE, tri = FALSE)           
    
    # serial implementation of cpp function
    toks <- tokens(txt)
    n <- sum(lengths(unlist(toks))) * 3 * 2
    fcm_s <- quanteda:::qatd_cpp_fcm(toks, length(unique(unlist(toks))), 'weighted', 3, 1, TRUE, FALSE, n)
    expect_equivalent(fcm,fcm_s)
    
    fcm <- fcm_sort(fcm)
    aMat <- matrix(c( 2, 0, 3, 3, 3, 1,
                      1, 0, 1, 0, 1, 0,
                      1, 0, 0, 2, 2, 0,
                      1, 1, 1, 0, 2, 1,
                      2, 1, 1, 2, 0, 1,
                      1, 1, 0, 0, 1, 0),
                   nrow = 6, ncol = 6, byrow = TRUE)
    expect_true(all(round(fcm, 2) == round(aMat, 2)))
    
    # Not ordered
    fcm_nOrd <- fcm(txt, context = "window", window = 3, ordered = FALSE, tri = FALSE) 
    fcm_nOrd <- fcm_sort(fcm_nOrd)
    aMat <- matrix(c(2, 1, 4, 4, 5, 2,
                     1, 0, 1, 1, 2, 1,
                     4, 1, 0, 3, 3, 0,
                     4, 1, 3, 0, 4, 1,
                     5, 2, 3, 4, 0, 2,
                     2, 1, 0, 1, 2, 0),
                   nrow = 6, ncol = 6, byrow = TRUE)
    expect_true(all(round(fcm_nOrd, 2) == round(aMat, 2)))
})

test_that("ordered setting: boolean",{
    txts <- c("b a b c", "a a c b e", "a c e f g")
    fcm <- fcm(txts, context = "window", count = "boolean", window = 2, ordered = TRUE, tri = TRUE)           
    
    # serial implementation of cpp function
    toks <- tokens(txts)
    n <- sum(lengths(unlist(toks))) * 3 * 2
    fcm_s <- quanteda:::qatd_cpp_fcm(toks, length(unique(unlist(toks))), 'boolean', 2, 1, TRUE, TRUE, n)
    expect_equivalent(fcm,fcm_s)
    
    # parallel version
    fcm <- fcm_sort(fcm)
    aMat <- matrix(c(1, 1, 3, 1, 0, 0,
                     0, 1, 1, 1, 0, 0,
                     0, 0, 0, 2, 1, 0,
                     0, 0, 0, 0, 1, 1,
                     0, 0, 0, 0, 0, 1,
                     0, 0, 0, 0, 0, 0),
                   nrow = 6, ncol = 6, byrow = TRUE)
    expect_equivalent(aMat, as.matrix(fcm))
    
    #**** not ordered********************
    fcm <- fcm(txts, context = "window", count = "boolean", window = 2, ordered = FALSE, tri = TRUE)           
    
    # serial version
    fcm_s <- quanteda:::qatd_cpp_fcm(toks, length(unique(unlist(toks))), 'boolean', 2, 1, FALSE, TRUE, n)
    expect_equivalent(fcm,fcm_s)
    
    # parallal version
    fcm <- fcm_sort(fcm)
    aMat <- matrix(c(1, 2, 3, 1, 0, 0,
                     0, 1, 2, 1, 0, 0,
                     0, 0, 0, 2, 1, 0,
                     0, 0, 0, 0, 1, 1,
                     0, 0, 0, 0, 0, 1,
                     0, 0, 0, 0, 0, 0),
                   nrow = 6, ncol = 6, byrow = TRUE)
    expect_equivalent(aMat, as.matrix(fcm))
})

# Testing "count" with multiple documents
test_that("counting the frequency of the co-occurrences",{
    txt <- c("a a a b b c", "a a c e", "a c e f g")
    fcm <- fcm(txt, context = "document", count = "frequency", tri = TRUE)           
    fcm <- fcm_sort(fcm)
    aMat <- matrix(c(4, 6, 6, 3, 1, 1,
                     0, 1, 2, 0, 0, 0,
                     0, 0, 0, 2, 1, 1,
                     0, 0, 0, 0, 1, 1,
                     0, 0, 0, 0, 0, 1,
                     0, 0, 0, 0, 0, 0),
                   nrow = 6, ncol = 6, byrow = TRUE)
    expect_true(all(round(fcm, 2) == round(aMat, 2)))
    expect_equal(fcm@margin, colSums(dfm(txt)))
})

test_that("counting the co-occurrences in 'boolean' way",{
    txt <- c("a a a b b c", "a a c e", "a c e f g")
    fcm <- fcm(txt, context = "document", count = "boolean")           
    fcm <- fcm_sort(fcm)
    
    mt <- matrix(c(2, 1, 3, 2, 1, 1,
                     0, 1, 1, 0, 0, 0,
                     0, 0, 0, 2, 1, 1,
                     0, 0, 0, 0, 1, 1,
                     0, 0, 0, 0, 0, 1,
                     0, 0, 0, 0, 0, 0),
                   nrow = 6, ncol = 6, byrow = TRUE)
    expect_true(all(round(fcm, 2) == round(mt, 2)))
    expect_equal(fcm@margin, colSums(dfm(txt)))
})

# Testing the setting of window size
test_that("window = 2",{
    txts <- c("a a a b b c", "a a c e", "a c e f g")
    fcm <- fcm(txts, context = "window", count = "boolean", window = 2)           

    
    toks <- tokens(txts)
    fcmTexts <- fcm(toks, context = "window", count = "boolean", window = 2) 
    expect_equivalent(as.matrix(fcm), as.matrix(fcmTexts))
    
    mt <- matrix(c(2, 1, 2, 2, 0, 0,
                     0, 1, 1, 0, 0, 0,
                     0, 0, 0, 2, 1, 0,
                     0, 0, 0, 0, 1, 1,
                     0, 0, 0, 0, 0, 1,
                     0, 0, 0, 0, 0, 0),
                   nrow = 6, ncol = 6, byrow = TRUE)
    fcm <- fcm_sort(fcm)
    expect_equivalent(mt, as.matrix(fcm))
    expect_equal(fcm@margin, colSums(dfm(toks)))
})

test_that("window = 3",{
    txts <- c("a a a b b c", "a a c e", "a c e f g")
    fcm <- fcm(txts, context = "window", count = "boolean", window = 3)           
    fcm <- fcm_sort(fcm)
    aMat <- matrix(c(2, 1, 3, 2, 1, 0,
                     0, 1, 1, 0, 0, 0,
                     0, 0, 0, 2, 1, 1,
                     0, 0, 0, 0, 1, 1,
                     0, 0, 0, 0, 0, 1,
                     0, 0, 0, 0, 0, 0),
                   nrow = 6, ncol = 6, byrow = TRUE)
    expect_true(all(round(fcm, 2) == round(aMat, 2)))
})

test_that("fcm.dfm works same as fcm.tokens", {
    txt <- c("The quick brown fox jumped over the lazy dog.",
             "The dog jumped and ate the fox.")
    toks <- tokens(char_tolower(txt), remove_punct = TRUE)
    expect_equal(fcm(toks, context = "document"),
                 fcm(dfm(toks), context = "document"))
})

test_that("fcm.dfm only works for context = \"document\"", {
    txt <- c("The quick brown fox jumped over the lazy dog.",
             "The dog jumped and ate the fox.")
    toks <- tokens(char_tolower(txt), remove_punct = TRUE)
    expect_error(fcm(dfm(toks), context = "window"),
                 "fcm.dfm only works on context = \"document\"")
})

test_that("fcm.dfm does works for context = \"document\" with weighed counts", {
    txt <- c("The quick brown fox jumped over the lazy dog.",
             "The dog jumped and ate the fox.")
    toks <- tokens(char_tolower(txt), remove_punct = TRUE)
    expect_error(fcm(dfm(toks), context = "document", count = "weighted"),
                 "Cannot have weighted counts with context = \"document\"")
})

test_that("fcm works as expected for tokens_hashed", {
    txt <- c("The quick brown fox jumped over the lazy dog.",
             "The dog jumped and ate the fox.")
    toks <- tokens(char_tolower(txt), remove_punct = TRUE)
    toksh <- tokens(char_tolower(txt), remove_punct = TRUE)
    classic <- fcm(toks, context = "window", window = 3)
    hashed <- fcm(toksh, context = "window", window = 3)
    expect_equivalent(classic, hashed)
})

test_that("fcm print works as expected", {
    txts <- c("a a a b b c", "a a c e", "a c e f g")
    testfcm <- fcm(txts, context = "document", count = "frequency", tri = TRUE) 
    expect_output(print(testfcm),
                  "^Feature co-occurrence matrix of: 6 by 6 features.")
    expect_output(print(testfcm[1:5, 1:5]),
                  "^Feature co-occurrence matrix of: 5 by 5 features.")
    expect_output(print(testfcm, show.settings = TRUE),
                  "Settings: TO BE IMPLEMENTED")
    expect_output(show(testfcm),
                  "^Feature co-occurrence matrix of: 6 by 6 features.")
})

test_that("fcm works the same for different object types", {
    txt <- c("a a a b b c", "a a c e", "a c e f g")
    expect_identical(fcm(txt), fcm(corpus(txt)))
    expect_identical(fcm(tokens(txt)), fcm(corpus(txt)))
    expect_identical(fcm(txt), fcm(tokens(txt)))
})

test_that("fcm expects warning for a wrong weights length", {
    txt <- c("a a a b b c", "a a c e", "a c e f g")
    expect_warning(fcm(tokens(txt), context = "window", window = 2, count = "weighted", weights = c(1,2,3)),
                 "weights length is not equal to the window size, weights are assigned by default!")
})


test_that("fcm works tokens with paddings, #788", {
    txt <- c("The quick brown fox jumped over the lazy dog.",
             "The dog jumped and ate the fox.")
    toks <- tokens(txt, remove_punct = TRUE)
    toks <- tokens_remove(toks, pattern = stopwords(), padding = TRUE)
    testfcm <- fcm(toks, context = "window", window = 3)
    expect_equal(sort(colnames(testfcm)), sort(attr(toks, 'types')))
})

test_that("as.network.fcm works", {
    txt <- c("a a a b b c", "a a c e", "a c e f g")
    mat <- fcm(txt)
    net <- as.network(mat, min_freq = 1, omit_isolated = FALSE)
    expect_true(network::is.network(net))
    expect_identical(network::network.vertex.names(net), featnames(mat))
    expect_identical(network::get.vertex.attribute(net, "frequency"), unname(mat@margin))
    expect_silent(as.network(mat, min_freq = 3, omit_isolated = TRUE))
})

test_that("as.network.fcm works with window", {
    txt <- c("a a a b b c", "a a c e", "a c e f g")
    mat <- fcm(txt, contex = "window", window = 2)
    net <- as.network(mat, min_freq = 1, omit_isolated = FALSE)
    expect_true(network::is.network(net))
    expect_identical(network::network.vertex.names(net), featnames(mat))
    expect_identical(network::get.vertex.attribute(net, "frequency"), unname(mat@margin))
    expect_silent(as.network(mat, min_freq = 3, omit_isolated = TRUE))
})

test_that("as.igraph.fcm works", {
    skip_if_not_installed("igraph")
    txt <- c("a a a b b c", "a a c e", "a c e f g")
    mat <- fcm(txt)
    net <- as.igraph(mat, min_freq = 1, omit_isolated = FALSE)
    expect_true(igraph::is.igraph(net))
    expect_identical(igraph::vertex_attr(net, "name"), featnames(mat))
    expect_identical(igraph::vertex_attr(net, "frequency"), unname(mat@margin))
    expect_silent(as.igraph(mat, min_freq = 3, omit_isolated = TRUE))
})

test_that("as.igraph.fcm works with window", {
    skip_if_not_installed("igraph")
    txt <- c("a a a b b c", "a a c e", "a c e f g")
    mat <- fcm(txt, contex = "window", window = 2)
    net <- as.igraph(mat, min_freq = 1, omit_isolated = FALSE)
    expect_true(igraph::is.igraph(net))
    expect_identical(igraph::vertex_attr(net, "name"), featnames(mat))
    expect_identical(igraph::vertex_attr(net, "frequency"), unname(mat@margin))
    expect_silent(as.igraph(mat, min_freq = 3, omit_isolated = TRUE))
})

test_that("test empty object is handled properly", {
    
    mat <- quanteda:::make_null_dfm()
    expect_equal(dim(fcm(mat)), c(0, 0))
    expect_true(is.fcm(fcm(mat)))
    
    toks <- tokens(c('', ''))
    expect_equal(dim(fcm(toks)), c(0, 0))
    expect_true(is.fcm(fcm(toks)))
})

test_that("arithmetic/linear operation works with dfm", {
    
    mt <- fcm(dfm(c(d1 = "a a b", d2 = "a b b c", d3 = "c c d")))
    expect_true(is.fcm(mt + 2))
    expect_true(is.fcm(mt - 2))
    expect_true(is.fcm(mt * 2))
    expect_true(is.fcm(mt / 2))
    expect_true(is.fcm(mt ^ 2))
    expect_true(is.fcm(2 + mt))
    expect_true(is.fcm(2 - mt))
    expect_true(is.fcm(2 * mt))
    expect_true(is.fcm(2 / mt))
    expect_true(is.fcm(2 ^ mt))
    expect_true(is.fcm(t(mt)))
    expect_equal(rowSums(mt), colSums(t(mt)))
    
})

