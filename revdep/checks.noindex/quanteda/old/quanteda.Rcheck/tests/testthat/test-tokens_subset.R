context("test tokens_subset")
        
test_that("tokens_subset works in a basic way", {
    toks <- tokens(corpus_subset(data_corpus_inaugural, Year > 1980 & Year < 2018))
    expect_equal(
        ndoc(tokens_subset(toks, Year > 2000)),
        5
    )
    expect_equal(
        docnames(tokens_subset(toks, President == "Clinton")),
        c("1993-Clinton", "1997-Clinton")
    )
    expect_equal(
        docnames(tokens_subset(toks, c(TRUE, TRUE, rep(FALSE, 8)))),
        c("1981-Reagan", "1985-Reagan")
    )
})

test_that("tokens_subset works with docvars", {
    toks <- tokens(corpus_subset(data_corpus_inaugural, Year > 1900))
    expect_equal(
        docvars(tokens_subset(toks, Year > 2000))$President,
        c("Bush", "Bush", "Obama", "Obama", "Trump")
    )
})

test_that("tokens_subset select argument works", {
    toks <- tokens(corpus_subset(data_corpus_inaugural, Year > 1980 & Year < 2018))
    expect_equal(
        docvars(tokens_subset(toks, select = President)),
        subset(docvars(toks), select = President)
    )
    expect_equal(
        docvars(tokens_subset(toks, select = President)),
        docvars(tokens_subset(toks, select = "President"))
    )
})

test_that("tokens_subset NSE works", {
    toks <- tokens(corpus_subset(data_corpus_inaugural, Year > 1980 & Year < 2018))

    selvar <- "President"
    expect_equal(
        docvars(tokens_subset(toks, select = selvar)),
        docvars(tokens_subset(toks, select = President))
    )
    
    tempfun <- function() {
        selvar2 <- "President"
        docvars(tokens_subset(toks, select = selvar2))
    }
    expect_equal(
        tempfun(),
        docvars(tokens_subset(toks, select = President))
    )
})

test_that("tokens_subset works with subset as a tokens object", {
    toks1 <- tokens(c(d1 = "a b b c", d2 = "b b c d"))
    toks2 <- tokens(c(d1 = "x y z", d2 = "a b c c d", d3 = "a b c", d4 = "x x x"))
    expect_equal(
        as.list(tokens_subset(toks1, subset = toks2)),
        list(d1 = c("a", "b", "b", "c"), d2 = c("b", "b", "c", "d"), d3 = character(), d4 = character())
    )
    
    expect_equal(
        as.list(tokens_subset(toks1, subset = toks2[c(3,4,1,2), ])),
        list(d3 = character(), d4 = character(), d1 = c("a", "b", "b", "c"), d2 = c("b", "b", "c", "d"))
    )
})
