context('test tokens_group.R')


test_that("test that tokens_group is working", {
    
    txts <- c('a b c d', 'e f g h', 'A B C', 'X Y Z')
    toks <- tokens(txts)
    expect_equal(
        as.list(quanteda:::tokens_group(toks, c(1, 1, 2, 2))),
        list('1' = c('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'),
             '2' = c('A', 'B', 'C', 'X', 'Y', 'Z'))
    )
    
    expect_equal(
        as.list(quanteda:::tokens_group(toks, c(2, 1, 2, 1))),
        list('1' = c('e', 'f', 'g', 'h', 'X', 'Y', 'Z'),
             '2' = c('a', 'b', 'c', 'd', 'A', 'B', 'C'))
    )
    
    expect_equal(
        as.list(quanteda:::tokens_group(toks, c('Z', 'A', 'Z', 'A'))),
        list('A' = c('e', 'f', 'g', 'h', 'X', 'Y', 'Z'),
             'Z' = c('a', 'b', 'c', 'd', 'A', 'B', 'C'))
    )
    
})

test_that("tokens_group works with empty documents", {
    
    toks <- tokens(c(doc1 = 'a b c c', doc2 = 'b c d', doc3 = ''))
    expect_equivalent(
        as.list(quanteda:::tokens_group(toks, c('doc1', 'doc1', 'doc2'))),
        list(doc1 = c("a", "b", "c", "c", "b", "c", "d"), doc2 = character())
    )
    
    expect_equivalent(
        as.list(quanteda:::tokens_group(toks, c(1, 1, 2))),
        list(doc1 = c("a", "b", "c", "c", "b", "c", "d"), doc2 = character())
    )
})

test_that("dfm_group and tokens_group are equivalent", {
    
    txts <- c('a b c c', 'b c d', 'a')
    toks <- tokens(txts)

    expect_identical(
        dfm_group(dfm(toks), c('doc1', 'doc1', 'doc2')),
        dfm(quanteda:::tokens_group(toks, c('doc1', 'doc1', 'doc2'))))
    
    expect_identical(
        dfm_group(dfm(toks), c(1, 1, 2)),
        dfm(quanteda:::tokens_group(toks, c(1, 1, 2))))
    
    expect_identical(
        dfm_group(dfm(toks), c(1, 1, 1)),
        dfm(quanteda:::tokens_group(toks, c(1, 1, 1))))
})

test_that("generate_groups works for tokens objects", {
    toks <- tokens(data_corpus_irishbudget2010)
    expect_equal(
        quanteda:::generate_groups(toks, rep(c("A", "B"), each = 7)),
        factor(rep(c("A", "B"), each = 7))
    )
    expect_equal(
        quanteda:::generate_groups(toks, factor(rep(c("A", "B"), each = 7))),
        factor(rep(c("A", "B"), each = 7))
    )
    expect_equal(
        quanteda:::generate_groups(toks, factor(rep(c(1, 2), each = 7))),
        factor(rep(c(1, 2), each = 7))
    )
    expect_equal(
        quanteda:::generate_groups(toks, "party"),
        factor(docvars(data_corpus_irishbudget2010, "party"))
    )
    expect_error(
        quanteda:::generate_groups(toks, rep(c("A", "B"), each = 6)),
        "groups must name docvars or provide data matching the documents in x"
    )
})

test_that("generate_groups works for corpus objects", {
    toks <- data_corpus_irishbudget2010
    expect_equal(
        quanteda:::generate_groups(toks, rep(c("A", "B"), each = 7)),
        factor(rep(c("A", "B"), each = 7))
    )
    expect_equal(
        quanteda:::generate_groups(toks, factor(rep(c("A", "B"), each = 7))),
        factor(rep(c("A", "B"), each = 7))
    )
    expect_equal(
        quanteda:::generate_groups(toks, factor(rep(c(1, 2), each = 7))),
        factor(rep(c(1, 2), each = 7))
    )
    expect_equal(
        quanteda:::generate_groups(toks, "party"),
        factor(docvars(data_corpus_irishbudget2010, "party"))
    )
    expect_error(
        quanteda:::generate_groups(toks, rep(c("A", "B"), each = 6)),
        "groups must name docvars or provide data matching the documents in x"
    )
    
    sents <- corpus_reshape(data_corpus_irishbudget2010, to = "sentences")
    expect_equal(
        quanteda:::generate_groups(sents, "_document"),
        factor(metadoc(sents, "document"),
               levels = unique(metadoc(sents, "document")))
    )
    
})


