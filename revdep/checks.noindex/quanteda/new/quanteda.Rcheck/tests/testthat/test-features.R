context('test features.R')

test_that("character vector works consistently on tokens", {
    
    toks <- tokens(c("a b c d e a_b_c d e"))
    feat <- c('a', 'b', 'c')
    expect_equivalent(
        as.list(tokens_compound(toks, pattern = feat))[[1]],
        c("a", "b", "c", "d", "e", "a_b_c", "d", "e"))
    
    expect_equivalent(
        as.list(tokens_select(toks, pattern = feat))[[1]],
        c("a", "b", "c"))
    
    expect_equivalent(
        as.list(tokens_remove(toks, pattern = feat))[[1]],
        c("d", "e", "a_b_c", "d", "e"))
    
    expect_equivalent(
        kwic(toks, pattern = feat)[,5],
        c("a", "b", "c"))
})

test_that("character vector works consistently on dfm", {
    
    mx <- dfm(c("a b c d e a_b_c d e"))
    feat <- c('a', 'b', 'c')

    expect_equivalent(
        featnames(dfm_select(mx, pattern = feat)),
        c("a", "b", "c"))
    
    expect_equivalent(
        featnames(dfm_remove(mx, pattern = feat)),
        c("d", "e", "a_b_c"))
})

test_that("character vector with whitespace works consistently on tokens", {
      
    txt <- c("a b c d e a_b_c d e")
    toks <- tokens(txt)
    toksch <- as.character(toks)
    feat <- 'a b c'
    expect_equivalent(
        as.list(tokens_compound(toks, pattern = feat))[[1]],
        toksch
    )
    expect_equivalent(
        as.list(tokens_compound(toks, pattern = phrase(feat)))[[1]],
        c("a_b_c", "d", "e", "a_b_c", "d", "e")
    )

    expect_equivalent(
        as.list(tokens_select(toks, pattern = feat))[[1]],
        character(0)
    )
    expect_equivalent(
        as.list(tokens_select(toks, pattern = phrase(feat)))[[1]],
        c("a", "b", "c")
    )
    
    expect_equivalent(
        as.list(tokens_remove(toks, pattern = feat))[[1]],
        toksch
    )
    
    expect_equal(
        nrow(kwic(toks, pattern = feat)),
        0
    )
    expect_equal(
        nrow(kwic(toks, pattern = phrase(feat))),
        1
    )
})

test_that("character vector with whitespace works consistently on dfm", {
    
    mx <- dfm(c("a b c d e a_b_c d e"))
    feat <- 'a b c'
    expect_equivalent(
        featnames(dfm_select(mx, pattern = feat)),
        character())
    
    expect_equivalent(
        featnames(dfm_remove(mx, pattern = feat)),
        c("a", "b", "c", "d", "e", "a_b_c"))
})

test_that("character vector with whitespace and wildcard works consistent on tokens", {
    
    toks <- tokens(c("a b c d e a_b_c d e"))
    toksch <- as.character(toks)
    feat <- '* d e'
    expect_equivalent(
        as.list(tokens_compound(toks, pattern = feat))[[1]],
        toksch
    )
    expect_equivalent(
        as.list(tokens_compound(toks, pattern = phrase(feat)))[[1]],
        c("a", "b", "c_d_e", "a_b_c_d_e")
    )

    expect_equivalent(
        as.list(tokens_select(toks, pattern = feat))[[1]],
        character(0)
    )
    expect_equivalent(
        as.list(tokens_select(toks, pattern = phrase(feat)))[[1]],
        c("c", "d", "e", "a_b_c", "d", "e")
    )
    
    expect_equivalent(
        as.list(tokens_remove(toks, pattern = feat))[[1]],
        toksch
    )
    expect_equivalent(
        as.list(tokens_remove(toks, pattern = phrase(feat)))[[1]],
        c("a", "b")
    )
    
    expect_equal(
        nrow(kwic(toks, pattern = feat)), 
        0
    )

})

test_that("list works consistently on tokens", {
    
    toks <- tokens(c("a b c d e a_b_c d e"))
    feat <- list(c('a', 'b', 'c'))
    expect_equivalent(
        as.list(tokens_compound(toks, pattern = feat))[[1]],
        c("a_b_c", "d", "e", "a_b_c", "d", "e"))
    
    expect_equivalent(
        as.list(tokens_select(toks, pattern = feat))[[1]],
        c("a", "b", "c"))
    
    expect_equivalent(
        as.list(tokens_remove(toks, pattern = feat))[[1]],
        c("d", "e", "a_b_c", "d", "e"))
    
    expect_equivalent(
        kwic(toks, pattern = feat)[,5],
        c("a b c"))
})

test_that("dictionary works consistently on tokens", {
    
    toks <- tokens(c("a b c d e a_b_c d e"))
    toksch <- as.character(toks)
    dict <- dictionary(list(ABC = 'a b c', D = 'd', E = 'e'))

    expect_equal(
        as.character(tokens_compound(toks, pattern = dict)),
        c("a_b_c", "d", "e", "a_b_c", "d", "e")
    )
    expect_equal(
        as.character(tokens_compound(toks, pattern = phrase(dict))),
        c("a_b_c", "d", "e", "a_b_c", "d", "e")
    )

    expect_equal(
        as.character(tokens_select(toks, pattern = dict)),
        c("a", "b", "c", "d", "e", "a_b_c", "d", "e")
    )
    expect_equal(
        as.character(tokens_select(toks, pattern = phrase(dict))),
        c("a", "b", "c", "d", "e", "d", "e")
    )
    
    expect_equal(
        as.character(tokens_remove(toks, pattern = dict)),
        character(0)
    )
    expect_equal(
        as.character(tokens_remove(toks, pattern = phrase(dict))),
        c("a_b_c")
    )
    
    expect_equal(
        kwic(toks, pattern = dict)$keyword,
        c("a b c", "d", "e", "a_b_c", "d", "e")
    )
    expect_equal(
        kwic(toks, pattern = phrase(dict))$keyword,
        c("a b c", "d", "e", "d", "e")
    )
})

test_that("dictionary works consistently on dfm", {
    
    mx <- dfm(c("a b c d e a_b_c d e"))
    dict <- dictionary(list(ABC = 'a_b_c', D = 'd', E = 'e'))
    expect_equivalent(
        featnames(dfm_select(mx, pattern = dict)),
        c('d', 'e', 'a_b_c'))
    
    expect_equivalent(
        featnames(dfm_remove(mx, pattern = dict)),
        c("a", "b", "c"))
})

