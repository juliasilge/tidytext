context('test kwic.R')

test_that("test attr(kwic, 'ntoken') with un-named texts", {
    testkwic <- kwic(c(
        "The quick brown fox jumped over the lazy dog",
        "The quick brown fox",
        "The quick brown dog jumped over the lazy dog",
        NA
    ), "fox")
    
    expect_equal(
        attr(testkwic, "ntoken"),
        c("text1" = 9, "text2" = 4, "text3" = 9, "text4" = 0)
    )
})

test_that("test attr(kwic, 'ntoken') text names", {
    testkwic <- kwic(data_corpus_inaugural, "american")
    expect_equal(
        names(attr(testkwic, "ntoken")),
        names(texts(data_corpus_inaugural))
    )
})
    
test_that("test kwic general", {
    testkwic <- kwic(paste(LETTERS, collapse = " "), "D")
    
    dtf <- data.frame(
        docname = c("text1"),
        from = 4L,
        to = 4L,
        pre = "A B C",
        keyword = "D",
        post = "E F G H I",
        stringsAsFactors = FALSE)
    
    expect_equal(
        data.frame(testkwic),
        dtf)
})


test_that("test kwic on first token", {
    testkwic <- kwic(paste(LETTERS, collapse = " "), "A")
    expect_that(
        data.frame(testkwic),
        equals(data.frame(
            docname = c("text1"),
            from = 1L,
            to = 1L,
            pre = "",
            keyword = "A",
            post = "B C D E F",
            stringsAsFactors = FALSE
        ))
    )
})


test_that("test kwic on last token", {
    testkwic <- kwic(paste(LETTERS, collapse = " "), "Z")
    expect_that(
        data.frame(testkwic),
        equals(data.frame(
            docname = c("text1"),
            from = 26L,
            to = 26L,
            pre = "U V W X Y",
            keyword = "Z",
            post = "",
            stringsAsFactors = FALSE
        ))
    )
})

test_that("test kwic on two tokens", {

    txt <- "A B C D E F G D H"
    testkwic <- kwic(txt, c("D", "E"), 3)
    expect_equivalent(
        testkwic,
        data.frame(
            docname = "text1",
            from = c(4L, 5L, 8L),
            to = c(4L, 5L, 8L),
            pre = c("A B C", "B C D", "E F G"),
            keyword = c("D", "E", "D"),
            post = c("E F G", "F G D", "H"),
            stringsAsFactors = FALSE)
    )
})

test_that("test kwic on non-existent token", {
    testkwic <- kwic(paste(LETTERS, collapse=' '), 'É')
    expect_true(is.data.frame(testkwic))
})

test_that("test kwic on multiple texts", {
    testcorpus <- corpus(c(
        paste(LETTERS[2:26], collapse = ' '),
        paste(LETTERS, collapse = ' ')
    ))
    testkwic <- kwic(testcorpus, 'A')
    expect_that(
        data.frame(testkwic),
        equals(data.frame(
            docname = c('text2'),
            from = 1L,
            to = 1L,
            pre = '',
            keyword = 'A',
            post = 'B C D E F',
            stringsAsFactors = FALSE
        ))
    )
})

test_that("test kwic with multiple matches", {
    testcorpus <- corpus(c(
        paste(c(LETTERS, LETTERS), collapse = ' ')
    ))
    testkwic <- kwic(testcorpus, 'A')
    expect_that(
        data.frame(testkwic),
        equals(data.frame(
            docname = c(c('text1', 'text1')),
            from = c(1L, 27L),
            to = c(1L, 27L),
            pre = c('', 'V W X Y Z'),
            keyword = c('A', 'A'),
            post = c('B C D E F', 'B C D E F'),
            stringsAsFactors = F
        ))
    )
})

test_that("test kwic with multiple matches, where one is the last (fixed bug)", {
    testkwic <- kwic('what does the fox say fox', 'fox')
    expect_that(
        data.frame(testkwic),
        equals(data.frame(
            docname = c(c('text1', 'text1')),
            from = c(4L, 6L),
            to = c(4L, 6L),
            pre = c('what does the', 'what does the fox say'),
            keyword = c('fox', 'fox'),
            post = c('say fox', ''),
            stringsAsFactors = F
        ))
    )
})


txt <- data_corpus_inaugural["2005-Bush"]

test_that("test that kwic works for glob types", {
    kwicGlob <- kwic(txt, "secur*", window = 3, valuetype = "glob", case_insensitive = TRUE)
    expect_true(
        setequal(c("security", "secured", "securing", "Security"),
                 unique(kwicGlob$keyword))
    )
    
    kwicGlob <- kwic(txt, "secur*", window = 3, valuetype = "glob", case_insensitive = FALSE)
    expect_true(
        setequal(c("security", "secured", "securing"),
                 unique(kwicGlob$keyword))
    )
    
})

test_that("test that kwic works for regex types", {
    kwicRegex <- kwic(txt, "^secur", window = 3, valuetype = "regex", case_insensitive = TRUE)
    expect_true(
        setequal(c("security", "secured", "securing", "Security"),
                 unique(kwicRegex$keyword))
    )
    
    kwicRegex <- kwic(txt, "^secur", window = 3, valuetype = "regex", case_insensitive = FALSE)
    expect_true(
        setequal(c("security", "secured", "securing"),
                 unique(kwicRegex$keyword))
    )
    
})

test_that("test that kwic works for fixed types", {
    kwicFixed <- kwic(data_corpus_inaugural, "security", window = 3, valuetype = "fixed", case_insensitive = TRUE)
    expect_true(
        setequal(c("security", "Security"),
                 unique(kwicFixed$keyword))
    )
    
    kwicFixed <- kwic(data_corpus_inaugural, "security", window = 3, valuetype = "fixed", case_insensitive = FALSE)
    expect_true(
        setequal(c("security"),
                 unique(kwicFixed$keyword))
    )
})

test_that("is.kwic works as expected", {
    mykwic <- kwic(data_corpus_inaugural[1:3], "provident*")
    expect_true(is.kwic(mykwic))
    expect_false(is.kwic("Not a kwic"))
})

test_that("textplot_xray works with new kwic, one token phrase", {
    data_corpus_inauguralPost70 <- corpus_subset(data_corpus_inaugural, Year > 1970)
    knew <- kwic(data_corpus_inauguralPost70, "american")
    expect_silent(textplot_xray(knew))
})

test_that("textplot_xray works with new kwic, two token phrase", {
    data_corpus_inauguralPost70 <- corpus_subset(data_corpus_inaugural, Year > 1970)
    knew <- kwic(data_corpus_inauguralPost70, phrase("american people"))
    expect_silent(textplot_xray(knew))
})

test_that("print method works as expected", {
    testkwic <- kwic('what does the fox say fox', 'fox')
    expect_output(print(testkwic), "*\\| fox \\|*")
    expect_output(print(testkwic), "\\[text1, 4\\]*")
    
    testkwic <- kwic('what does the fox say fox', 'foox')
    expect_output(print(testkwic), "kwic object with 0 rows")
})


test_that("kwic works with padding", {
    testtoks <- tokens('what does the fox say cat')
    expect_output(print(kwic(tokens_remove(testtoks, c('what', 'the'), padding = TRUE), 'fox')),
                  '\\[text1, 4\\]  does \\| fox \\| say cat')
    expect_output(
        print(kwic(tokens_remove(testtoks, '*', padding = TRUE), 'fox')),
        "kwic object with 0 rows"
    )
})

test_that("kwic works as expected with and without phrases", {
   
    txt <- c(d1 = "a b c d e g h",  d2 = "a b e g h i j")
    toks_uni <- tokens(txt)
    dfm_uni <- dfm(toks_uni)
    toks_bi <- tokens(txt, n = 2, concatenator = " ")
    dfm_bi <- dfm(toks_bi)
    char_uni <- c("a", "b", "g", "j")
    char_bi <- c("a b", "g j")
    list_uni <- list("a", "b", "g", "j")
    list_bi <- list("a b", "g j")
    dict_uni <- dictionary(list(one = c("a", "b"), two = c("g", "j")))
    dict_bi <- dictionary(list(one = "a b", two = "g j"))
    coll_bi <- textstat_collocations(toks_uni, size = 2, min_count = 2)
    coll_tri <- textstat_collocations(toks_uni, size = 3, min_count = 2)[1, ]
    
    expect_equal(
        kwic(txt, char_uni)$keyword,
        c("a", "b", "g", 
          "a", "b", "g", "j")
    )
    expect_equal(
        kwic(txt, list_uni)$keyword,
        c("a", "b", "g", 
          "a", "b", "g", "j")
    )
    expect_equal(
        nrow(kwic(txt, char_bi)),
        0
    )
    expect_equal(
        nrow(kwic(txt, list("c d", "g h"))),
        0
    )
    expect_equal(
        kwic(txt, list(c("c", "d"), c("g", "h")))$keyword,
        c("c d", "g h", "g h")
    )
    expect_equal(
        kwic(txt, phrase(c("c d", "g h")))$keyword,
        c("c d", "g h", "g h")
    )
    
    expect_equal(
        kwic(txt, coll_bi)$keyword,
        c("a b", "e g", "g h",
          "a b", "e g", "g h")
    )
    expect_equal(
        kwic(txt, coll_tri)$keyword,
        c("e g h", "e g h")
    )

    expect_equal(
        kwic(txt, phrase(coll_bi))$keyword,
        c("a b", "e g", "g h",
          "a b", "e g", "g h")
    )
    expect_equal(
        kwic(txt, phrase(dict_bi))$keyword,
        c("a b", "a b")
    )
    
    expect_equal(
        kwic(txt, dict_uni),
        kwic(txt, char_uni)
    )
    expect_equal(
        kwic(txt, dict_bi)$keyword,
        c("a b", "a b")
    )

    ## on tokens
    expect_equal(
        kwic(toks_uni, char_uni)$keyword,
        c("a", "b", "g", 
          "a", "b", "g", "j")
    )
    expect_equal(
        kwic(toks_uni, list_uni)$keyword,
        c("a", "b", "g", 
          "a", "b", "g", "j")
    )
    expect_equal(
        nrow(kwic(toks_uni, char_bi)),
        0
    )
    expect_equal(
        nrow(kwic(toks_uni, list("c d", "g h"))),
        0
    )
    expect_equal(
        kwic(toks_uni, list(c("c", "d"), c("g", "h")))$keyword,
        c("c d", "g h", "g h")
    )
    expect_equal(
        kwic(toks_uni, phrase(c("c d", "g h")))$keyword,
        c("c d", "g h", "g h")
    )
    
    expect_equal(nrow(kwic(toks_uni, coll_bi)), 6)
    expect_equal(nrow(kwic(toks_uni, coll_tri)), 2)
    
    expect_equal(
        kwic(toks_uni, phrase(coll_bi))$keyword,
        c("a b", "e g", "g h", "a b", "e g", "g h")
    )
    expect_equal(
        nrow(kwic(toks_bi, phrase(coll_bi))),
        0
    )
    
    expect_equal(
        kwic(toks_uni, dict_uni),
        kwic(toks_uni, char_uni)
    )
    expect_equal(nrow(kwic(toks_uni, dict_bi)), 2)

})


test_that("kwic error when dfm is given, #1006", {
    toks <- tokens('a b c')
    expect_error(kwic(toks, dfm('b c d')))
})

