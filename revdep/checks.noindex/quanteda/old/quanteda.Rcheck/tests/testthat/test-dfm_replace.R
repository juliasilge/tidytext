context("test dfm_replace")

test_that("test dfm_replace", {
    
    txt <- c(doc1 = "aa bb BB cc DD ee",
             doc2 = "aa bb cc DD ee")
    dfmt <- dfm(txt, tolower = FALSE)
    
    # case-insensitive
    expect_equal(featnames(dfm_replace(dfmt, c('aa', 'bb'), c('a', 'b'), case_insensitive = TRUE)),
                 c("a", "b", "cc", "DD", "ee"))
    
    # case-sensitive
    expect_equal(featnames(dfm_replace(dfmt, c('aa', 'bb'), c('a', 'b'), case_insensitive = FALSE)),
                 c("a", "b", "BB", "cc", "DD", "ee"))
    
    # duplicated types in from
    expect_equal(featnames(dfm_replace(dfmt, c('aa', 'aa'), c('a', 'aaa'), case_insensitive = FALSE)),
                 c("a", "bb", "BB", "cc", "DD", "ee"))
    
    # equivalent to dfm conversion method
    feat <- featnames(dfmt)
    expect_equal(dfm_replace(dfmt, feat, char_toupper(feat), case_insensitive = FALSE),
                 dfm_toupper(dfmt))
    
    # error when lenfths of from and to are different
    expect_error(dfm_replace(dfmt, c('aa', 'bb'), c('a')),
                 "Lengths of 'pattern' and 'replacement' must be the same")
    
    expect_error(dfm_replace(dfmt, c(1, 2), c(10, 20)),
                 "'pattern' and 'replacement' must be characters")

    # does nothing when input vector is zero length
    expect_equal(dfm_replace(dfmt, character(), character()),
                 dfmt)
    
})

test_that("test dfm_replace works with dictionary", {
    
    txt <- c(doc1 = "aa bb a BB cc DD ee",
             doc2 = "AA bb cc b DD ee")
    dfmt <- dfm(txt, tolower = FALSE)
    dict <- dictionary(list(A = c('a', 'aa'), B = c('b', 'bb')))
    
    expect_equal(featnames(dfm_replace(dfmt, dict, case_insensitive = TRUE)),
                 c("A", "B", "cc", "DD", "ee"))
    
    expect_equal(featnames(dfm_replace(dfmt, dict, case_insensitive = FALSE)),
                 c("A", "B", "BB", "cc", "DD", "ee", "AA"))
    
    expect_error(dfm_replace(dfmt, dict, c('a')),
                 "'replacement' must be NULL when 'pattern' is a dictionary")
    
})
