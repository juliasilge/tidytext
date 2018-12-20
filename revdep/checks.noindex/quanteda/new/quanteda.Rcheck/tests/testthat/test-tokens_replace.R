context("test tokens_replace")

test_that("test tokens_replace", {
    
    txt <- c(doc1 = "aa bb BB cc DD ee",
             doc2 = "aa bb cc DD ee")
    toks <- tokens(txt)
    
    # case-insensitive
    expect_equal(as.list(tokens_replace(toks, c('aa', 'bb'), c('a', 'b'), case_insensitive = TRUE)),
                 list(doc1 = c("a", "b", "b", "cc", "DD", "ee"), 
                      doc2 = c("a", "b", "cc", "DD", "ee")))
    
    # case-sensitive
    expect_equal(as.list(tokens_replace(toks, c('aa', 'bb'), c('a', 'b'), case_insensitive = FALSE)),
                 list(doc1 = c("a", "b", "BB", "cc", "DD", "ee"), 
                      doc2 = c("a", "b", "cc", "DD", "ee")))
    
    # duplicated types in from
    expect_equal(as.list(tokens_replace(toks, c('aa', 'aa'), c('a', 'aaa'), case_insensitive = FALSE)),
                 list(doc1 = c("a", "bb", "BB", "cc", "DD", "ee"), 
                      doc2 = c("a", "bb", "cc", "DD", "ee")))
    
    # equivalent to tokens conversion method
    type <- types(toks)
    expect_equal(tokens_replace(toks, type, char_toupper(type), case_insensitive = FALSE),
                 tokens_toupper(toks))
    
    # error when lenfths of from and to are different
    expect_error(tokens_replace(toks, c('aa', 'bb'), c('a')),
                 "Lengths of 'pattern' and 'replacement' must be the same")
    
    expect_error(tokens_replace(toks, c(1, 2), c(10, 20)),
                 "'pattern' and 'replacement' must be characters")

    # does nothing when input vector is zero length
    expect_equal(tokens_replace(toks, character(), character()),
                 toks)
    
})

test_that("test tokens_replace works with dictionary", {
    
    txt <- c(doc1 = "aa bb a BB cc DD ee",
             doc2 = "AA bb cc b DD ee")
    toks <- tokens(txt)
    dict <- dictionary(list(A = c('a', 'aa'), B = c('b', 'bb')))
    
    expect_equal(as.list(tokens_replace(toks, dict, case_insensitive = TRUE)),
                 list(doc1 = c("A", "B", "A", "B", "cc", "DD", "ee"), 
                      doc2 = c("A", "B", "cc", "B", "DD", "ee")))
    
    expect_equal(as.list(tokens_replace(toks, dict, case_insensitive = FALSE)),
                 list(doc1 = c("A", "B", "A", "BB", "cc", "DD", "ee"), 
                      doc2 = c("AA", "B", "cc", "B", "DD", "ee")))
    
    expect_error(tokens_replace(toks, dict, c('a')),
                 "'replacement' must be NULL when 'pattern' is a dictionary")
    
})
