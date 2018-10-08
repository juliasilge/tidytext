
test_that("textstat_lexdiv computation is correct", {
    mydfm <- dfm(c(d1 = "b a b a b a b a",
                   d2 = "a a b b"))
    
    expect_equivalent(
        textstat_lexdiv(mydfm, "TTR"),
        data.frame(document = c('d1', 'd2'), TTR = c(0.25, 0.5),
                   stringsAsFactors = FALSE)
    )
})

test_that("textstat_lexdiv drop works", {
    mydfm <- dfm(c(d1 = "b a b a b a b a",
                   d2 = "a a b b"))

    results <- textstat_lexdiv(mydfm, "TTR", drop = FALSE)
    expect_equivalent(
        c(0.25, 0.5),
        results$TTR
    )
    
    expect_equal(
        results$document[1], "d1"
    )
})

test_that("textstat_lexdiv CTTR works correct", {
    mydfm <- dfm(c(d1 = "b a b a b a b a",
                   d2 = "a a b b"))
    
    expect_equivalent(
        textstat_lexdiv(mydfm, "CTTR")$CTTR,
        c(2/sqrt(2*8), 2/sqrt(2*4)),
        tolerance = 0.01 
    )
})

test_that("textstat_lexdiv R works correct", {
    mydfm <- dfm(c(d1 = "b a b a b a b a",
                   d2 = "a a b b"))
    
    expect_equivalent(
        textstat_lexdiv(mydfm, "R")$R,
        c(2/sqrt(8), 2/sqrt(4)),
        tolerance = 0.01 
    )
})

test_that("textstat_lexdiv C works correct", {
    mydfm <- dfm(c(d1 = "b a b a b a b a",
                   d2 = "a a b b"))
    
    expect_equivalent(
        textstat_lexdiv(mydfm, "C")$C,
        c(log10(2)/log10(8), log10(2)/log10(4)),
        tolerance = 0.01 
    )
})

test_that("textstat_lexdiv Maas works correct", {
    mydfm <- dfm(c(d1 = "b a b a b a b a",
                   d2 = "a a b b"))
    
    expect_equivalent(
        textstat_lexdiv(mydfm, "Maas")$Maas[1],
        sqrt((log10(8) - log10(2))/log10(8)^2),
        tolerance = 0.01 
    )
})

test_that("textstat_lexdiv works with a single document dfm (#706)", {
    mytxt <- "one one two one one two one"
    mydfm <- dfm(mytxt)
    expect_equivalent(
        textstat_lexdiv(mydfm, c("TTR", "C")),
        data.frame(document = "text1", TTR = 0.286, C = 0.356, 
                   stringsAsFactors = FALSE),
        tolerance = 0.01
    )
})
