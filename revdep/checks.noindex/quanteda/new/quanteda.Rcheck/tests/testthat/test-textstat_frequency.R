context("test textstat_frequency")

test_that("test textstat_frequency without groups", {
    dfm1 <- dfm(c("a a b b c d", "a d d d", "a a a"))
    expect_equivalent(
        textstat_frequency(dfm1),
        data.frame(feature = c("a", "d", "b", "c"),
                   frequency = c(6,4,2,1),
                   rank = 1:4,
                   docfreq = c(3,2,1,1), 
                   group = rep('all', 4),
                   stringsAsFactors = FALSE)
    )
    expect_equivalent(
      textstat_frequency(dfm1, n = 2),
      data.frame(feature = c("a", "d", "b", "c"),
                 frequency = c(6,4,2,1),
                 rank = 1:4,
                 docfreq = c(3,2,1,1), 
                 group = rep('all', 4),
                 stringsAsFactors = FALSE)[1:2, ]
    )
    
})

test_that("test textstat_frequency without groups", {
    txt <- c("a a b b c d", "a d d d", "a a a")
    grp1 <- c("one", "two", "one")
    corp1 <- corpus(txt, docvars = data.frame(grp2 = grp1))
    
    expect_equivalent(
        textstat_frequency(dfm(corp1), groups = grp1),
        textstat_frequency(dfm(corp1), groups = "grp2")
    )

    expect_equivalent(
        textstat_frequency(dfm(corp1), groups = grp1),
        data.frame(feature = c("a", "b", "c", "d", "d", "a"),
                   frequency = c(5,2,1,1,3,1),
                   rank = c(1:4, 1:2),
                   docfreq = c(2,1,1,1,1,1),
                   group = c("one", "one", "one", "one", "two", "two"),
                   stringsAsFactors = FALSE)
    )
    
    expect_equivalent(
      textstat_frequency(dfm(corp1), groups = grp1, n = 2),
      data.frame(feature = c("a", "b", "d", "a"),
                 frequency = c(5,2,3,1),
                 rank = c(1:2, 1:2),
                 docfreq = c(2,1,1,1),
                 group = c("one", "one", "two", "two"),
                 stringsAsFactors = FALSE)
    )
    
})

test_that("test textstat_frequency works with weights", {
    txt <- c("a a b b c d", "a d d d", "a a a")
    grp1 <- c("one", "two", "one")
    corp1 <- corpus(txt, docvars = data.frame(grp2 = grp1))
    
    dfm1 <- dfm(corp1)
    dfm1weighted <- dfm_weight(dfm1, "prop")
    
    expect_equivalent(
        textstat_frequency(dfm1weighted),
        data.frame(feature = c("a", "d", "b", "c"),
                   frequency = c(1.58, .916, .333, .1666),
                   rank = 1:4,
                   docfreq = c(3,2,1,1), 
                   group = rep('all', 4),
                   stringsAsFactors = FALSE),
        tolerance = .01
    )
})

