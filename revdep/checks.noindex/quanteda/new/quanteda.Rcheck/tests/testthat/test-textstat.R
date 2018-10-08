context("test textstat_*")

txt <- c("A a b b c d", "B d d d", "C a a")
toks <- tokens(txt)
mt <- dfm(toks)

col <- textstat_collocations(toks, min_count = 1)
key <- textstat_keyness(mt)
frq <- textstat_frequency(mt)
lex <- textstat_lexdiv(mt)
red <- textstat_readability(txt)


test_that("test textstat_* have numbers in rownames", {
    
    expect_equal(rownames(col), as.character(seq_len(nrow(col))))
    expect_equal(rownames(key), as.character(seq_len(nrow(key))))
    expect_equal(rownames(frq), as.character(seq_len(nrow(frq))))
    expect_equal(rownames(frq), as.character(seq_len(nrow(frq))))
    expect_equal(rownames(lex), as.character(seq_len(nrow(lex))))
    expect_equal(rownames(red), as.character(seq_len(nrow(red))))

})

test_that("test textstat_* are data.frame with class", {

    expect_true("collocations" %in% class(col))
    expect_true("keyness" %in% class(key))
    expect_true("frequency" %in% class(frq))
    expect_true("lexdiv" %in% class(lex))
    expect_true("readability" %in% class(red))
    
    expect_true("textstat" %in% class(col))
    expect_true("textstat" %in% class(key))
    expect_true("textstat" %in% class(frq))
    expect_true("textstat" %in% class(lex))
    expect_true("textstat" %in% class(red))
})

test_that("test textstat_* keeps the class after extraction", {
    
    expect_equal(class(col[1,]), class(col))
    expect_equal(class(key[1,]), class(key))
    expect_equal(class(frq[1,]), class(frq))
    expect_equal(class(lex[1,]), class(lex))
    expect_equal(class(red[1,]), class(red))

})


test_that("test textstat_* keeps the class after extraction", {
    
    toks <- tokens(data_char_ukimmig2010[1:2])
    mt <- dfm(toks)
    col <- textstat_collocations(toks)
    key <- textstat_keyness(mt)
    frq <- textstat_frequency(mt)
    
    expect_equivalent(subset(col, col$count > 3),
                      subset(as.data.frame(col), col$count > 3))
    
    expect_equivalent(subset(key, select = 1:3),
                      subset(as.data.frame(key), select = 1:3))

    expect_equivalent(subset(frq, frq$docfreq > 10, 2:3),
                      subset(as.data.frame(frq), frq$docfreq > 10, 2:3))
    
    col_test <- textstat_select(col, "*political*")
    expect_equal(col_test$collocation,
                 col$collocation[stringi::stri_detect_regex(col$collocation, "political")])
    
    key_test <- textstat_select(key, "poli*")
    expect_equal(key_test$feature,
                 key$feature[stringi::stri_detect_regex(key$feature, "^poli")])
    
    frq_test <- textstat_select(frq, "poli*")
    expect_equal(frq_test$feature,
                 frq$feature[stringi::stri_detect_regex(frq$feature, "^poli")])
    
})


