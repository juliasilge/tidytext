context("test dfm_weight")

test_that("dfm_weight works", {
    str <- c("apple is better than banana", "banana banana apple much better")
    mydfm <- dfm(str, remove = stopwords("english"))
    
    expect_equivalent(round(as.matrix(dfm_weight(mydfm, scheme = "count")), 2),
                      matrix(c(1, 1, 1, 1, 1, 2, 0, 1), nrow = 2))
    
    expect_equivalent(round(as.matrix(dfm_weight(mydfm, scheme = "prop")), 2),
                      matrix(c(0.33, 0.2, 0.33, 0.2, 0.33, 0.4, 0, 0.2), nrow = 2))
    
    expect_equivalent(round(as.matrix(dfm_weight(mydfm, scheme = "propmax")), 2),
                      matrix(c(1, 0.5, 1, 0.5, 1, 1, 0, 0.5), nrow = 2))
    
    expect_equivalent(round(as.matrix(dfm_weight(mydfm, scheme = "logcount")), 2),
                      matrix(c(1, 1, 1, 1, 1, 1.30, 0, 1), nrow = 2))
    
    # replication of worked example from
    # https://en.wikipedia.org/wiki/Tf-idf#Example_of_tf.E2.80.93idf
    str <- c("this is a  a sample", "this is another example another example example")
    wikiDfm <- dfm(str)
    expect_equivalent(round(as.matrix(dfm_tfidf(wikiDfm, scheme_tf = "prop")), 2),
                      matrix(c(0, 0, 0, 0, 0.12, 0, 0.06, 0, 0, 0.09, 0, 0.13), nrow = 2))
})

test_that("dfm_weight works with weights", {
    str <- c("apple is better than banana", "banana banana apple much better")
    w <- c(apple = 5, banana = 3, much = 0.5)
    mydfm <- dfm(str, remove = stopwords("english"))
    
    expect_equivalent(as.matrix(dfm_weight(mydfm, weights = w)),
                      matrix(c(5, 5, 1, 1, 3, 6, 0, 0.5), nrow = 2))

    expect_warning(
        dfm_weight(mydfm, scheme = "relfreq", weights = w),
        "scheme is ignored when numeric weights are supplied"
    )
    
    w <- c(apple = 5, banana = 3, much = 0.5, notfound = 10)
    suppressWarnings(
        expect_equivalent(as.matrix(dfm_weight(mydfm, weights = w)),
                          matrix(c(5, 5, 1, 1, 3, 6, 0, 0.5), nrow = 2))
    )
    expect_warning(
        dfm_weight(mydfm, weights = w),
        "ignoring 1 unmatched weight feature"
    )

})

test_that("dfm_weight exceptions work", {
    mydfm <- dfm(c("He went out to buy a car", 
                   "He went out and bought pickles and onions"))
    mydfm_tfprop <- dfm_weight(mydfm, "prop")
    expect_error(
        dfm_tfidf(mydfm_tfprop),
        "this dfm has already been term weighted as: prop"
    )
})

test_that("docfreq works as expected", {
    mydfm <- dfm(c("He went out to buy a car", 
                   "He went out and bought pickles and onions",
                   "He ate pickles in the car."))
    expect_equivalent(
        docfreq(mydfm, scheme = "unary"),
        rep(1, ncol(mydfm))
    )
    expect_equivalent(
        docfreq(dfm_smooth(mydfm, 1)),
        rep(3, ncol(mydfm))
    )
    expect_equivalent(
        docfreq(dfm_smooth(mydfm, 1), threshold = 3),
        rep(0, ncol(mydfm))
    )
    expect_equivalent(
        docfreq(dfm_smooth(mydfm, 1), threshold = 2),
        c(rep(0, 7), 1, rep(0, 7))
    )
    expect_equivalent(
        docfreq(mydfm, scheme = "inversemax"),
        log10(max(docfreq(mydfm, "count")) / docfreq(mydfm, "count"))
    )
    expect_identical(
        as.vector(docfreq(mydfm, scheme = "inverseprob")),
        pmax(0, log10((nrow(mydfm) - docfreq(mydfm, "count")) / docfreq(mydfm, "count")))
    )
})

test_that("tf with logave now working as expected", {
    mydfm <- dfm(c("He went out to buy a car", 
                   "He went out and bought pickles and onions"))
    manually_calculated <- 
        as.matrix((1 + log10(mydfm)) / (1 + log10(apply(mydfm, 1, function(x) sum(x) / sum(x>0)))))
    manually_calculated[is.infinite(manually_calculated)] <- 0
    expect_equivalent(
        as.matrix(dfm_weight(mydfm, scheme = "logave")),
        manually_calculated
    )
})

test_that("tfidf works with different log base", {
    mydfm <- dfm(c("He went out to buy a car", 
                   "He went out and bought pickles and onions"))
    expect_true(
        !identical(
            as.matrix(dfm_tfidf(mydfm)), 
            as.matrix(dfm_tfidf(mydfm, base = 2))
        )
    )
})

test_that("docfreq works when features have duplicated names (#829)", {
    mydfm <- dfm(c(d1 = "a b c d e", d2 = "a a b b e f", d3 = "b e e f f f"))
    colnames(mydfm)[3] <- "b"
    expect_equal(
        docfreq(mydfm, use.names = TRUE),
        c(a=2, b=3, b=1, d=1, e=3, f=2)
    )
    expect_equal(
        docfreq(mydfm, use.names = FALSE),
        c(2, 3, 1, 1, 3, 2)
    )
})

test_that("dfm_weight works with zero-frequency features (#929)", {
    d1 <- dfm(c("a b c", "a b c d"))
    d2 <- dfm(letters[1:6])
    
    dtest <- dfm_select(d1, d2)
    
    expect_equal(
        as.matrix(dfm_weight(dtest, "prop")),
        matrix(c(0.33, 0.25, 0.33, 0.25, 0.33, 0.25, 0, 0.25, 0, 0, 0, 0), nrow = 2,
               dimnames = list(docs = c("text1", "text2"), features = letters[1:6])),
        tolerance = .01
    )
    expect_equal(
        docfreq(dtest),
        c(a = 2, b = 2, c = 2, d = 1, e = 0, f = 0)
    )
    expect_equal(
        as.matrix(dfm_tfidf(dtest, "prop")),
        matrix(c(rep(0, 6), 0.000, 0.07525, rep(0, 4)), nrow = 2,
               dimnames = list(docs = c("text1", "text2"), features = letters[1:6])),
        tolerance = .001
    )
})

test_that("settings are recorded for tf-idf weightings", {
    mytexts <- c(text1 = "The new law included a capital gains tax, and an inheritance tax.",
                 text2 = "New York City has raised a taxes: an income tax and a sales tax.")
    d <- dfm(mytexts, remove_punct = TRUE)
    
    expect_equal(dfm_tfidf(d)@weightTf[["scheme"]], "count")
    expect_equal(dfm_tfidf(d)@weightDf[["scheme"]], "inverse")
    expect_equal(dfm_tfidf(d)@weightDf[["base"]], 10)
    
    expect_equal(dfm_tfidf(d)@weightTf[["scheme"]], "count")
    expect_equal(dfm_tfidf(d)@weightDf[["scheme"]], "inverse")
    expect_equal(dfm_tfidf(d, base = 10)@weightDf[["base"]], 10)
    expect_equal(dfm_tfidf(d, base = 2)@weightDf[["base"]], 2)
    expect_equal(dfm_tfidf(d, scheme_tf = "prop", base = 2)@weightTf[["scheme"]], "prop")
    expect_equal(dfm_tfidf(d, scheme_tf = "prop", base = 2)@weightDf[["base"]], 2)
    
    expect_equal(dfm_tfidf(d, scheme_df = "inversemax")@weightDf[["scheme"]], "inversemax")
    expect_equal(dfm_tfidf(d, scheme_df = "inversemax", k = 1)@weightDf[["k"]], 1)
})


test_that("weights argument works, issue 1150", {
    
    txt <- c("brown brown yellow green", "yellow green blue")
    mt <- dfm(txt)
    w <- c(brown = 0.1, yellow = 0.3, green = 0.4, blue = 2)
    
    expect_equal(
        as.matrix(dfm_weight(mt, weights = w)),
        matrix(c(0.2, 0, 0.3, 0.3, 0.4, 0.4, 0, 2), nrow = 2,
               dimnames = list(docs = c("text1", "text2"), 
                               features = c("brown", "yellow", "green", "blue")))
    )
    
    expect_equal(
        as.matrix(dfm_weight(mt, weights = w[c(2,3,4)])),
        matrix(c(2, 0, 0.3, 0.3, 0.4, 0.4, 0, 2), nrow = 2,
               dimnames = list(docs = c("text1", "text2"), 
                               features = c("brown", "yellow", "green", "blue")))
    )
    
    expect_equal(
        as.matrix(dfm_weight(mt, weights = w[c(1,3,2)])),
        matrix(c(0.2, 0, 0.3, 0.3, 0.4, 0.4, 0, 1), nrow = 2,
               dimnames = list(docs = c("text1", "text2"), 
                               features = c("brown", "yellow", "green", "blue")))
    )
    
    # test when a feature is not assigned a weight
    txt2 <- c(d1 = "brown brown yellow green black", d2 = "yellow green blue")
    mt2 <- dfm(txt2)
    w2 <- c(green = .1, blue = .2, brown = .3, yellow = .4)
    expect_equal(
        as.matrix(dfm_weight(mt2, weights = w2)),
        matrix(c(.6, 0, .4, .4, .1, .1, 1, 0, 0, .2), nrow = 2, 
               dimnames = list(docs = c("d1", "d2"), features = c("brown", "yellow", "green", "black", "blue")))
    )
})


test_that("deprecated tfidf still works", {
    mydfm <- dfm(c("He went out to buy a car", 
                   "He went out and bought pickles and onions"))
    expect_equal(suppressWarnings(tfidf(mydfm)), dfm_tfidf(mydfm))
    expect_warning(tfidf(mydfm))
})

test_that("deprecated tf still works", {
    mydfm <- dfm(c("He went out to buy a car", 
                   "He went out and bought pickles and onions"))
    expect_equal(suppressWarnings(tf(mydfm, "propmax")), dfm_weight(mydfm, "propmax"))
    expect_warning(tf(mydfm))
})


test_that("deprecated dfm_weight argument values still work", {
    mydfm <- dfm(c("He went out to buy a car", 
                   "He went out and bought pickles and onions"))
    
    # frequency
    expect_identical(
        suppressWarnings(dfm_weight(mydfm, "frequency")),
        dfm_weight(mydfm, "count")
    )
    expect_warning(
        dfm_weight(mydfm, "frequency"),
        'scheme = \"frequency\" is deprecated; use dfm_weight\\(x, scheme = "count"\\) instead'
    )
    
    # relfreq
    expect_identical(
        suppressWarnings(dfm_weight(mydfm, "relfreq")),
        dfm_weight(mydfm, "prop")
    )
    expect_warning(
        dfm_weight(mydfm, "relfreq"),
        'scheme = \"relfreq\" is deprecated; use dfm_weight\\(x, scheme = "prop"\\) instead'
    )

    # relmaxfreq
    expect_identical(
        suppressWarnings(dfm_weight(mydfm, "relmaxfreq")),
        dfm_weight(mydfm, "propmax")
    )
    expect_warning(
        dfm_weight(mydfm, "relmaxfreq"),
        'scheme = \"relmaxfreq\" is deprecated; use dfm_weight\\(x, scheme = "propmax"\\) instead'
    )

    # relfreq
    expect_identical(
        suppressWarnings(dfm_weight(mydfm, "logfreq")),
        dfm_weight(mydfm, "logcount")
    )
    expect_warning(
        dfm_weight(mydfm, "logfreq"),
        'scheme = \"logfreq\" is deprecated; use dfm_weight\\(x, scheme = "logcount"\\) instead'
    )
    
    # log
    
    
})

test_that("docfreq works previously a weighted dfm (#1237)", {
    df1 <- dfm(data_dfm_lbgexample) %>% dfm_tfidf(scheme_tf = "prop")
    computed <- c(rep(1, 5), 2, 2, 3, 3, 3, 4)
    names(computed) <- letters[1:11]
    expect_equal(
        docfreq(df1)[1:11],
        computed
    )
})

test_that("smooth slot is correctly set (#1274)", {
    expect_equal(data_dfm_lbgexample@smooth, 0)
    
    # smoothed by 1
    dfms1 <- dfm_smooth(data_dfm_lbgexample, smoothing = 1)
    expect_equal(dfms1@smooth, 1)
    
    # smoothed by 0.5
    dfms0.5 <- dfm_smooth(data_dfm_lbgexample, smoothing = 0.5)
    expect_equal(dfms0.5@smooth, 0.5)
    
    # smoothed by 1 and then by another 2
    dfms1_2 <- dfm_smooth(dfms1, smoothing = 2)
    expect_equal(dfms1_2@smooth, 3)
})
