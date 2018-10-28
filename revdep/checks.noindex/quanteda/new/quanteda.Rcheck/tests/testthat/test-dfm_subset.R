context("test dfm_subset")
        
test_that("dfm_subset works in a basic way", {
    dfmtest <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980 & Year < 2018))
    expect_equal(
        ndoc(dfm_subset(dfmtest, Year > 2000)),
        5
    )
    expect_equal(
        docnames(dfm_subset(dfmtest, President == "Clinton")),
        c("1993-Clinton", "1997-Clinton")
    )
    expect_equal(
        docnames(dfm_subset(dfmtest, c(TRUE, TRUE, rep(FALSE, 8)))),
        c("1981-Reagan", "1985-Reagan")
    )
})

test_that("dfm_subset works with docvars", {
    dfmtest <- dfm(corpus_subset(data_corpus_inaugural, Year > 1900))
    expect_equal(
        docvars(dfm_subset(dfmtest, Year > 2000))$President,
        c("Bush", "Bush", "Obama", "Obama", "Trump")
    )
})

test_that("dfm_subset select argument works", {
    dfmtest <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980 & Year < 2018))
    expect_equal(
        docvars(dfm_subset(dfmtest, select = President)),
        subset(docvars(dfmtest), select = President)
    )
    expect_equal(
        docvars(dfm_subset(dfmtest, select = President)),
        docvars(dfm_subset(dfmtest, select = "President"))
    )
})

test_that("dfm_subset NSE works", {
    x <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980 & Year < 2018))

    selvar <- "President"
    expect_equal(
        docvars(dfm_subset(x, select = selvar)),
        docvars(dfm_subset(x, select = President))
    )
    
    tempfun <- function() {
        selvar2 <- "President"
        docvars(dfm_subset(x, select = selvar2))
    }
    expect_equal(
        tempfun(),
        docvars(dfm_subset(x, select = President))
    )
})

test_that("dfm_subset works with subset as a dfm", {
    dfm1 <- dfm(c(d1 = "a b b c", d2 = "b b c d"))
    dfm2 <- dfm(c(d1 = "x y z", d2 = "a b c c d", d3 = "a b c", d4 = "x x x"))
    expect_equal(
        as.matrix(dfm_subset(dfm1, subset = dfm2)),
        matrix(c(1,2,1,0, 0,2,1,1, rep(0,8)), byrow = TRUE, nrow = 4, 
               dimnames = list(docs = paste0("d", 1:4), features = letters[1:4]))
    )
    
    expect_equal(
        as.matrix(dfm_subset(dfm1, subset = dfm2[c(3,4,1,2), ])),
        matrix(c(rep(0,8), 1,2,1,0, 0,2,1,1), byrow = TRUE, nrow = 4, 
               dimnames = list(docs = paste0("d", c(3,4,1,2)), features = letters[1:4]))
    )
})

