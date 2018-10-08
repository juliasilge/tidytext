context("test textstat_keyness()")

test_that("keyness_textstat chi2 computation is correct", {
    mydfm <- dfm(c(d1 = "b b b b b b b a a a",
                   d2 = "a a a a a a a b b"))
    suppressWarnings(
        result <- stats::chisq.test(as.matrix(mydfm), correct = TRUE)
    )
    expect_equivalent(
        result$statistic,
        textstat_keyness(mydfm, sort = FALSE, correction = "default")[[1, 2]]
    )
    
    # without Yates correction
    suppressWarnings(
        result <- stats::chisq.test(as.matrix(mydfm), correct = FALSE)
    )
    expect_equivalent(
        result$statistic,
        textstat_keyness(mydfm, sort = FALSE, correction = "none")[[1, 2]]
    )
})

test_that("keyness_textstat chi2 computation is correct for three rows", {
    txt <- c(d1 = "b b b b b b b a a a",
             d2 = "a a a a a a a b b",
             d3 = "a a a b b b")
    mydfm <- dfm(txt)
    mydfm_grouped <- dfm(txt, groups = c("target", "zref", "zref"))
    suppressWarnings(
        result <- stats::chisq.test(as.matrix(mydfm_grouped), correct = TRUE)
    )
    expect_equal(
        as.numeric(result$statistic),
        as.numeric(textstat_keyness(mydfm, sort = FALSE, correction = "default")[1, "chi2"])
    )
    expect_equal(
        as.numeric(textstat_keyness(mydfm, sort = FALSE, correction = "default")[1, "chi2"]),
        as.numeric(textstat_keyness(mydfm, sort = FALSE, correction = "yates")[1, "chi2"])
    )
    
    # uncorrected
    suppressWarnings(
        result <- stats::chisq.test(as.matrix(mydfm_grouped), correct = FALSE)
    )
    expect_equal(
        as.numeric(result$statistic),
        as.numeric(textstat_keyness(mydfm, sort = FALSE, correction = "none")[1, "chi2"])
    )
})

test_that("keyness_chi2 internal methods are equivalent", {
    skip("Skipped because stats::chisq.test is wrong for small-value 2x2 tables")
    mydfm <- dfm(c(d1 = "a a a b b c c c c c c d e f g h h",
                   d2 = "a a b c c d d d d e f h"))
    expect_equal(
        quanteda:::keyness_chi2_stats(mydfm),
        quanteda:::keyness_chi2_dt(mydfm)
    )
    
    ## stats::chisq.test is wrong for small tables
    mat <- matrix(c(3, 2, 14, 10), ncol = 2)
    chi <- stats::chisq.test(mat)
    ## Warning message:
    ## In stats::chisq.test(mat) : Chi-squared approximation may be incorrect
    
    # from the function
    chi$statistic
    ##    X-squared 
    ## 1.626059e-31 
    
    # as it should be (with Yates correction)
    sum((abs(chi$observed - chi$expected) - 0.5)^2 / chi$expected)
    ## [1] 0.1851001
})

test_that("basic textstat_keyness works on two rows", {
    mydfm <- dfm(c(d1 = "a a a b b c c c c c c d e f g h h",
                   d2 = "a a b c c d d d d e f h"))
    key1 <- textstat_keyness(mydfm)
    expect_equal(key1$feature,
                 c("g", "c", "b", "h", "a", "e", "f", "d"))
    expect_equal(attr(key1, 'groups'),
                 c("d1", "d2"))
    key2 <- textstat_keyness(mydfm, target = 2)
    expect_equal(key2$feature,
                 c("d", "e", "f", "a", "b", "h", "c", "g"))
    expect_equal(attr(key2, 'groups'),
                 c("d2", "d1"))

})

test_that("textstat_keyness works with different targets", {
    mydfm <- dfm(c(d1 = "a a a b b c c c c c c d e f g h h",
                   d2 = "a a b c c d d d d e f h"))
    expect_equal(textstat_keyness(mydfm),
                 textstat_keyness(mydfm, target = 1))
    expect_equal(textstat_keyness(mydfm, target = "d1"),
                 textstat_keyness(mydfm, target = 1))
    expect_equal(textstat_keyness(mydfm, target = "d2"),
                 textstat_keyness(mydfm, target = 2))
    expect_equal(textstat_keyness(mydfm, target = "d2"),
                 textstat_keyness(mydfm, target = c(FALSE, TRUE)))
})

test_that("textstat_keyness combines non-target rows correctly", {
    mydfm <- dfm(c(d1 = "a a a b b c c c c c c d e f g h h",
                   d2 = "a a b c c d d d d e f h", 
                   d3 = "a a a a b b c c d d d d d d"))
    expect_equivalent(textstat_keyness(mydfm, 1),
                 textstat_keyness(rbind(mydfm[1, ], new("dfm", mydfm[2, ] + mydfm[3, ])), target = "d1"))    
})


test_that("textstat_keyness errors", {
    mydfm <- dfm(c(d1 = "a a a b b c c c c c c d e f g h h",
                   d2 = "a a b c c d d d d e f h"))
    expect_error(textstat_keyness(mydfm, target = 3),
                 "target index outside range of documents")
    expect_error(textstat_keyness(mydfm, target = "d3"),
                 "target not found in docnames\\(x\\)")
    expect_error(textstat_keyness(mydfm[1, ]),
                 "x must have at least two documents")
})



test_that("keyness_textstat exact computation is correct", {
    mydfm <- dfm(c(d1 = "b b b b b b b a a a",
                   d2 = "a a a a a a a b b"))
    result <- stats::fisher.test(as.matrix(mydfm))
    expect_equivalent(
        result$estimate,
        textstat_keyness(mydfm, measure = "exact", sort = FALSE)[[1, 2]]
    )
    expect_equivalent(
        result$p.value,
        textstat_keyness(mydfm, measure = "exact", sort = FALSE)[[1, 3]]
    )
})

test_that("basic textstat_keyness exact works on two rows", {
    mydfm <- dfm(c(d1 = "a a a b b c c c c c c d e f g h h",
                   d2 = "a a b c c d d d d e f h"))
    expect_equal(textstat_keyness(mydfm, measure = "exact")$feature,
                 c("g", "c", "b", "h", "a", "e", "f", "d"))
    expect_equal(textstat_keyness(mydfm, target = 2, measure = "exact")$feature,
                 c("d", "e", "f", "a", "b", "h", "c", "g"))
})



## from Deducer
likelihood.test <- function(x, y = NULL, conservative=FALSE)
{
    DNAME <- deparse(substitute(x))
    if (is.data.frame(x)) x <- as.matrix(x)
    if (is.matrix(x)) {
        if (min(dim(x)) == 1) 
            x <- as.vector(x)
    }
    if (!is.matrix(x) && !is.null(y)) {
        if (length(x) != length(y)) 
            stop("x and y must have the same length")
        DNAME <- paste(DNAME, "and", deparse(substitute(y)))
        OK <- complete.cases(x, y)
        x <- as.factor(x[OK])
        y <- as.factor(y[OK])
        if ((nlevels(x) < 2) || (nlevels(y) < 2)) 
            stop("x and y must have at least 2 levels")
        x <- table(x, y)
    }
    if (any(x < 0) || any(is.na(x))) 
        stop("all entries of x must be nonnegative and finite")
    if ((n <- sum(x)) == 0) 
        stop("at least one entry of x must be positive")
    
    if (!is.matrix(x))
        stop("Could not make a 2-dimensional matrix")
    
    
    #Test of Independence
    nrows<-nrow(x)
    ncols<-ncol(x)
    
    sr <- apply(x,1,sum)
    sc <- apply(x,2,sum)
    E <- outer(sr,sc, "*")/n
    
    # no monte-carlo
    # calculate G
    g <- 0
    for (i in 1:nrows){
        for (j in 1:ncols){
            if (x[i,j] != 0) g <- g + x[i,j] * log(x[i,j]/E[i,j])
        }
    }
    q <- 1
    if (conservative){ # Do Williams correction
        row.tot <- col.tot <- 0    
        for (i in 1:nrows){ row.tot <- row.tot + 1/(sum(x[i,])) }
        for (j in 1:ncols){ col.tot <- col.tot + 1/(sum(x[,j])) }
        q <- 1+ ((n*row.tot-1)*(n*col.tot-1))/(6*n*(ncols-1)*(nrows-1))
    }
    STATISTIC <- G <- 2 * g / q
    PARAMETER <- (nrow(x)-1)*(ncol(x)-1)
    PVAL <- 1-pchisq(STATISTIC,df=PARAMETER)
    if(!conservative)
        METHOD <- "Log likelihood ratio (G-test) test of independence without correction"
    else
        METHOD <- "Log likelihood ratio (G-test) test of independence with Williams' correction"
    
    names(STATISTIC) <- "Log likelihood ratio statistic (G)"
    names(PARAMETER) <- "X-squared df"
    names(PVAL) <- "p.value"
    structure(list(statistic=STATISTIC,parameter=PARAMETER,p.value=PVAL,
                   method=METHOD,data.name=DNAME, observed=x, expected=E),
              class="htest")
}

test_that("keyness_textstat lr computation is correct", {
    mydfm <- dfm(c(d1 = "b b b b b b b a a a",
                   d2 = "a a a a a a a b b"))
    result <- likelihood.test(as.matrix(mydfm))
    expect_equivalent(
        result$statistic,
        textstat_keyness(mydfm, measure = "lr", sort = FALSE, correction = "none")[[1, 2]]
    )
    expect_equal(
        as.vector(result$p.value),
        textstat_keyness(mydfm, measure = "lr", sort = FALSE, correction = "none")[[1, 3]]
    )
    
    # with william's correction
    result <- likelihood.test(as.matrix(mydfm), conservative = TRUE)
    expect_equivalent(
        result$statistic,
        textstat_keyness(mydfm, measure = "lr", sort = FALSE, correction = "williams")[[1, 2]]
    )
    expect_equal(
        as.vector(result$p.value),
        textstat_keyness(mydfm, measure = "lr", sort = FALSE, correction = "williams")[[1, 3]]
    )
})

test_that("basic textstat_keyness lr works on two rows", {
    mydfm <- dfm(c(d1 = "a a a b b c c c c c c d e f g h h",
                   d2 = "a a b c c d d d d e f h"))
    expect_equal(textstat_keyness(mydfm, measure = "lr", correction = "none")$feature,
                 c("c", "g", "b", "h", "a", "e", "f", "d"))
    expect_equal(textstat_keyness(mydfm, target = 2, measure = "lr", correction = "none")$feature,
                 c("d", "e", "f", "a", "b", "h", "g", "c"))
    expect_equal(textstat_keyness(mydfm, measure = "lr", sort = FALSE)$feature,
                 letters[1:8])
})

test_that("textstat_keyness returns raw frequency counts", {
    mydfm <- dfm(c(d1 = "a a a b b c c c c c c d e f g h h",
                   d2 = "a a b c c d d d d e f h"))
    
    expect_equivalent(textstat_keyness(mydfm, measure = "chi2", sort = FALSE)[,c(4,5)], 
                      as.data.frame(t(mydfm), document = NULL))
    
    expect_equivalent(textstat_keyness(mydfm, measure = "exact", sort = FALSE)[,c(4,5)], 
                      as.data.frame(t(mydfm), document = NULL))
    
    expect_equivalent(textstat_keyness(mydfm, measure = "lr", sort = FALSE)[,c(4,5)], 
                      as.data.frame(t(mydfm), document = NULL))
    
})

test_that("textstat_keyness returns correct pmi", {
    mydfm <- dfm(c(d1 = "a a a b b c c c c c c d e f g h h",
                   d2 = "a a b c c d d d d e f h"))
    ## manual checking
    mykeyness <- textstat_keyness(mydfm, measure = "pmi")
    my_cal <- log(mydfm[1,1] * sum(mydfm)/( (mydfm[1, 1] + mydfm[2, 1]) * sum(mydfm[1,])) )
    expect_equal(colnames(mydfm)[1], "a")
    expect_equal(mykeyness$pmi[which(mykeyness$feature == "a")],
                 as.numeric(my_cal),
                 tolerance = 0.0001)
    
    skip_if_not_installed("svs")
    svs_pmi <- svs::pmi(as.table(as.matrix(mydfm)), base = 2.7182818459)
    mykeyness <- textstat_keyness(mydfm, measure = "pmi")
    
    expect_equal(mykeyness$pmi[which(mykeyness$feature == "g")],
                 svs_pmi[1, which(attr(svs_pmi, "dimnames")$features == "g")],
                 tolerance = 0.0001)
    
    expect_equal(max(mykeyness$pmi), max(svs_pmi[1,]), tolerance = 0.0001)
})

test_that("textstat_keyness correction warnings for pmi and exact", {
    mydfm <- dfm(c(d1 = "a a a b b c c c c c c d e f g h h",
                   d2 = "a a b c c d d d d e f h"))
    expect_warning(
        textstat_keyness(mydfm, measure = "pmi", correction = "yates"),
        "correction is always none for measure pmi"
    )
    expect_warning(
        textstat_keyness(mydfm, measure = "exact", correction = "williams"),
        "correction is always none for measure exact"
    )
    expect_silent(
        textstat_keyness(mydfm, measure = "exact", correction = "none")
    )
    expect_silent(
        textstat_keyness(mydfm, measure = "pmi", correction = "none")
    )
})


test_that("group labels are correct, #1257", {
  
    mt <- dfm(c(d1 = 'a b c', d2 = 'a b f g', d3 = 'c h i j', d4 = 'i j'))

    key1 <- textstat_keyness(mt, target = 'd1')
    expect_identical(attr(key1, 'groups'), c("d1", "reference"))
    
    key2 <- textstat_keyness(mt, target = 'd4')
    expect_identical(attr(key2, 'groups'), c("d4", "reference"))
    
    key3 <- textstat_keyness(mt, target = c('d1', 'd2'))
    expect_identical(attr(key3, 'groups'), c("target", "reference"))
    
    key4 <- textstat_keyness(mt[1:2,], target = 'd1')
    expect_identical(attr(key4, 'groups'), c("d1", "d2"))
    
})

