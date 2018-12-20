context("Testing corpus_segment and char_segment")

test_that("char_segment works with punctuations", {
    txt <- c(d1 = "Sentence one.  Second sentence is this one!\n
             Here is the third sentence.",
             d2 = "Only sentence of doc2?  No there is another.")
    char_seg <- char_segment(txt, "\\p{P}", valuetype = "regex", 
                             remove_pattern = FALSE, pattern_position = "after")
    expect_equal(char_seg[4], c(d2.1 = "Only sentence of doc2?"))
})

test_that("char_segment works for tags", {
    txt <- c("##INTRO This is the introduction.
                           ##DOC1 This is the first document.
                           Second sentence in Doc 1.
                           ##DOC3 Third document starts here.
                           End of third document.",
                           "##INTRO Document ##NUMBER Two starts before ##NUMBER Three.")
    char_seg <- char_segment(txt, "##[A-Z0-9]+", valuetype = "regex",
                                pattern_position = "before", remove_pattern = TRUE)
    expect_equal(char_seg[5], "Two starts before")
})

test_that("char_segment works for glob customized tags", {
    txt <- c("INTRO: This is the introduction. 
                           DOC1: This is the first document.  
                           Second sentence in Doc 1.  
                           DOC3: Third document starts here.  
                           End of third document.",
             "INTRO: Document NUMBER: Two starts before NUMBER: Three.")
    char_seg <- char_segment(txt, "*:", valuetype = "glob", 
                                pattern_position = "before", remove_pattern = TRUE)
    expect_equal(char_seg[6], "Three.")
})

test_that("char_segment works for glob customized tags, test 2", {
    txt <- c("[INTRO] This is the introduction. 
                           [DOC1] This is the first document.  
                           Second sentence in Doc 1.  
                           [DOC3] Third document starts here.  
                           End of third document.",
             "[INTRO] Document [NUMBER] Two starts before [NUMBER] Three.")
    char_seg <- char_segment(txt, "[*]", valuetype = "glob", 
                                pattern_position = "before", remove_pattern = TRUE)
    expect_equal(char_seg[6], "Three.")
})

test_that("corpus_segment works with blank before tag", {
    corp <- corpus(c("\n##INTRO This is the introduction.
                        ##DOC1 This is the first document.  Second sentence in Doc 1.
                           ##DOC3 Third document starts here.  End of third document.",
                           "##INTRO Document ##NUMBER Two starts before ##NUMBER Three."))
    corp_seg <- corpus_segment(corp, "##[A-Z0-9]+", valuetype = "regex", 
                               pattern_position = "before", extract_pattern = TRUE)
    summ <- summary(corp_seg)
    expect_equal(summ[1, "Tokens"], 5)
    expect_equal(as.character(summ[1, "Text"]), "text1.1")
})


test_that("corpus_segment works with use_docvars TRUE or FALSE", {
    corp <- corpus(c(d1 = "##TEST One two ##TEST2 Three",
                     d2 = "##TEST3 Four"),
                   docvars = data.frame(test = c("A", "B"), stringsAsFactors = FALSE))
    corp_seg1 <- corpus_segment(corp, "##[A-Z0-9]+", valuetype = "regex", 
                           pattern_position = "before", extract_pattern = TRUE, use_docvars = TRUE)
    summ1 <- summary(corp_seg1)
    expect_equal(summ1$test, c("A", "A", "B"))
    
    corp_seg2 <- corpus_segment(corp, "##[A-Z0-9]+", valuetype = "regex", 
                                pattern_position = "before", extract_pattern = TRUE, use_docvars = FALSE)
    summ2 <- summary(corp_seg2)
    expect_equal(names(summ2), c("Text", "Types", "Tokens", "Sentences", "pattern"))
})

test_that("char_segment works with Japanese texts", {
    
    skip_on_os("windows")
    txt <- "日本語の終止符は.ではない。しかし、最近は．が使われることある。"
    expect_equal(char_segment(txt, '\\p{P}', valuetype = "regex", 
                              remove_pattern = FALSE, pattern_position = "after"),
                 c("日本語の終止符は.", "ではない。", "しかし、", "最近は．", "が使われることある。"))
    
    expect_equal(char_segment(txt, '。', valuetype = "fixed", remove_pattern = FALSE,
                              pattern_position = "after"),
                 c("日本語の終止符は.ではない。", "しかし、最近は．が使われることある。"))
})

test_that("corpus_segment works with position argument", {
    
    corp1 <- corpus(c(d1 = "##TEST One two ##TEST2 Three",
                      d2 = "##TEST3 Four"))
    corp1_seg <- corpus_segment(corp1, '##', valuetype = 'fixed', 
                                pattern_position = "before", extract_pattern = FALSE)
    expect_equal(texts(corp1_seg), c("d1.1" = "##TEST One two",
                                     "d1.2" = "##TEST2 Three",
                                     "d2.1" = "##TEST3 Four"))
    
    corp2 <- corpus(c(d1 = "TEST One two; TEST2 Three;",
                      d2 = "TEST3 Four;"))
    corp2_seg <- corpus_segment(corp2, ';', valuetype = 'fixed', 
                                pattern_position = 'after', extract_pattern = FALSE)
    expect_equal(texts(corp2_seg), c("d1.1" = "TEST One two;",
                                     "d1.2" = "TEST2 Three;",
                                     "d2.1" = "TEST3 Four;"))
    
    corp3 <- corpus(c(d1 = "**TEST One two ##TEST2 Three",
                      d2 = "??TEST3 Four"))
    corp3_seg <- corpus_segment(corp3, '[*#?]{2}', valuetype = 'regex', 
                                pattern_position = 'before', extract_pattern = FALSE)
    expect_equal(texts(corp3_seg), c("d1.1" = "**TEST One two",
                                     "d1.2" = "##TEST2 Three",
                                     "d2.1" = "??TEST3 Four"))
    
    corp4 <- corpus(c(d1 = "TEST One two; TEST2 Three?",
                      d2 = "TEST3 Four!"))
    corp4_seg <- corpus_segment(corp4, '[!?;]', valuetype = 'regex', pattern_position = 'after',
                                extract_pattern = FALSE)
    expect_equal(texts(corp4_seg), c("d1.1" = "TEST One two;",
                                     "d1.2" = "TEST2 Three?",
                                     "d2.1" = "TEST3 Four!"))
    
})


test_that("corpus_segment works for delimiter with remove_pattern", {

    txt <- c(d1 = "Sentence one.  Second sentence is this one!\n
                   Here is the third sentence.",
             d2 = "Only sentence of doc2?  No there is another.")

    mycorp <- corpus(txt, docvars = data.frame(title = c("doc1", "doc2")))
    mycorp_seg1 <- corpus_segment(mycorp, '[.!?]', valuetype = 'regex',
                                  pattern_position = "after",
                                  extract_pattern = FALSE)

    expect_equal(texts(mycorp_seg1),
                 c(d1.1 = "Sentence one.",
                   d1.2 = "Second sentence is this one!",
                   d1.3 = "Here is the third sentence.",
                   d2.1 = "Only sentence of doc2?",
                   d2.2 = "No there is another."))

    mycorp_seg2 <- corpus_segment(mycorp, pattern = '[.!?]', valuetype = 'regex',
                                  pattern_position = "after",
                                  extract_pattern = TRUE)
    expect_equal(texts(mycorp_seg2),
                 c(d1.1 = "Sentence one",
                   d1.2 = "Second sentence is this one",
                   d1.3 = "Here is the third sentence",
                   d2.1 = "Only sentence of doc2",
                   d2.2 = "No there is another"))
})

test_that("tag extraction works", {
    corp <- corpus(c("#tag1 Some text. #tag2 More text."))
    
    corpseg <- corpus_segment(corp, pattern = "#*", extract_pattern = TRUE)
    expect_equal(
        docvars(corpseg, "pattern"),
        c("#tag1", "#tag2")
    )
    
    corpseg <- corpus_segment(corp, pattern = "#*", extract_pattern = FALSE)
    expect_error(
        docvars(corpseg, "pattern"),
        "field\\(s\\) pattern not found"
    )
})

test_that("corpus_segment works for begining and end tags", {
    corp <- corpus(c(d1 = "##START ##INTRO This is the introduction.
                           ##DOC1 This is the first document.  Second sentence in Doc 1.
                           ##DOC3 Third document starts here.  End of third document.",
                     d2 = "##INTRO Document ##NUMBER Two starts before ##NUMBER Three. ##END"))
    
    corp_seg1 <- corpus_segment(corp, "##*", pattern_position = "before", extract_pattern = TRUE)
    expect_equal(head(docvars(corp_seg1, "pattern"), 1), "##START")
    expect_equal(head(texts(corp_seg1), 1), c(d1.1 = ""))
    expect_equal(tail(docvars(corp_seg1, "pattern"), 1), "##END")
    expect_equal(tail(texts(corp_seg1), 1), c(d2.4 = ""))
    
    corp_seg2 <- corpus_segment(corp, "##*", pattern_position = "before", extract_pattern = FALSE)
    expect_error(docvars(corp_seg2, "pattern"))
    expect_equal(head(texts(corp_seg2), 1), c(d1.1 = "##START"))
    expect_equal(tail(texts(corp_seg2), 1), c(d2.4 = "##END"))
    
    corp_seg3 <- corpus_segment(corp, "##*", pattern_position = "after", extract_pattern = TRUE)
    expect_equal(head(docvars(corp_seg3, "pattern"), 1), "##START")
    expect_equal(head(texts(corp_seg3), 1), c(d1.1 = ""))
    expect_equal(tail(docvars(corp_seg3, "pattern"), 1), "##END")
    expect_equal(tail(texts(corp_seg3), 1), c(d2.4 = "Three."))
    
    corp_seg4 <- corpus_segment(corp, "##*", pattern_position = "after", extract_pattern = FALSE)
    expect_error(docvars(corp_seg4, "pattern"))
    expect_equal(head(texts(corp_seg4), 1), c(d1.1 = "##START"))
    expect_equal(tail(texts(corp_seg4), 1), c(d2.4 = "Three. ##END"))
    
})

test_that("corpus_segment works with multiple patterns (#1394)", {
    
    txt <- "Some text, more text\\nINTRODUCTION This is a test\\nCONTACT John Doe SOURCE Library of Congress"
    
    expect_identical(char_segment(txt, c("INTRODUCTION*", "CONTACT", "SOURCE"), valuetype = "glob"),
                     c("This is a test\\n", "John Doe", "Library of Congress"))
    
    expect_identical(char_segment(txt, c("INTRODUCTION", "CONTACT", "SOURCE"), valuetype = "fixed"),
                     c("This is a test\\n", "John Doe", "Library of Congress"))
    
    
    expect_identical(texts(corpus_segment(corpus(txt), c("INTRODUCTION*", "CONTACT", "SOURCE"), valuetype = "glob")),
                     c(text1.1 = "This is a test\\n", text1.2 = "John Doe", text1.3 = "Library of Congress"))
    
    expect_identical(texts(corpus_segment(corpus(txt), c("INTRODUCTION", "CONTACT", "SOURCE"), valuetype = "fixed")),
                     c(text1.1 = "This is a test\\n", text1.2 = "John Doe", text1.3 = "Library of Congress"))
    
})




