context("test dfm_lookup")

test_that("test dfm_lookup, issue #389", {

    toks <- tokens(data_corpus_inaugural[1:5])
    dict <- dictionary(list(Country = "united states",
                            HOR = c("House of Re*"),
                            law = c('law*', 'constitution'), 
                            freedom = c('free*', 'libert*')))
    expect_equal(featnames(dfm(tokens_lookup(toks, dictionary = dict), tolower = FALSE)),
                 c("Country", "HOR", "law", "freedom"))
    # expect_error(dfm_lookup(dfm(toks), dictionary = dict),
    #               "dfm_lookup not implemented for ngrams > 1 and multi-word dictionary values")

    dict2 <- dictionary(list(Country = "united",
                             HOR = c("House"),
                             law = c('law*', 'constitution'), 
                             freedom = c('free*', 'libert*')))
    expect_equal(as.numeric(dfm(toks, dictionary = dict2)[, "Country"]),
                 c(4, 1, 3, 0, 1))
    
})

test_that("#459 apply a hierarchical dictionary to a dfm", {
    
    txt <- c(d1 = "The United States is bordered by the Atlantic Ocean and the Pacific Ocean.",
             d2 = "The Supreme Court of the United States is seldom in a united state.")
    testdfm <- dfm(txt)
    dict <- dictionary(list('geo'=list(
        Countries = c("States"),
        oceans = c("Atlantic", "Pacific")),
        'other'=list(
            gameconsoles = c("Xbox", "Nintendo"),
            swords = c("States"))))
    
    expect_equal(
        as.matrix(dfm_lookup(testdfm, dict, valuetype = "fixed", levels = 1)),
        matrix(c(3, 1, 1, 1), ncol = 2, dimnames = list(docs = c("d1", "d2"), 
                                                        features = c("geo", "other")))
    )
    
    expect_equal(
        as.matrix(dfm_lookup(testdfm, dict, valuetype = "fixed", levels = 1:2)),
        matrix(c(1, 1, 2, 0, 0, 0, 1, 1), ncol = 4, 
               dimnames = list(docs = c("d1", "d2"), 
                               features = c("geo.Countries", "geo.oceans", "other.gameconsoles", "other.swords")))
    )
    
    
    expect_equal(
        as.matrix(dfm_lookup(testdfm, dict, valuetype = "fixed", levels = 2)),
        matrix(c(1, 1, 2, 0, 0, 0, 1, 1), ncol = 4, 
               dimnames = list(docs = c("d1", "d2"), 
                               features = c("Countries", "oceans", "gameconsoles", "swords")))
    )
    
})

test_that("#459 extract the lower levels of a dictionary using a dfm", {
    txt <- c(d1 = "The United States has the Atlantic Ocean and the Pacific Ocean.",
             d2 = "Britain and Ireland have the Irish Sea and the English Channel.")
    dict <- dictionary(list('US'=list(
                                Countries = c("States"),
                                oceans = c("Atlantic", "Pacific")),
                            'Europe'=list(
                                Countries = c("Britain", "Ireland"),
                                oceans = list(west = "Sea", east = "Channel"))))
    
    testdfm <- dfm(txt)
    expect_equal(as.matrix(dfm_lookup(testdfm, dict, levels = 1)),
                 matrix(c(3, 0, 0, 4), nrow = 2,
                        dimnames = list(docs = c('d1', 'd2'), features = c('US', 'Europe'))))
    expect_equal(as.matrix(dfm_lookup(testdfm, dict, levels = 2)),
                 matrix(c(1, 2, 2, 2), nrow = 2,
                        dimnames = list(docs = c('d1', 'd2'), features = c('Countries', 'oceans'))))
    expect_equal(as.matrix(dfm_lookup(testdfm, dict, levels = 1:2)),
                 matrix(c(1, 0, 2, 0, 0, 2, 0, 2), nrow = 2,
                        dimnames = list(docs = c('d1', 'd2'), 
                                        features = c('US.Countries', 'US.oceans', 'Europe.Countries', 'Europe.oceans'))))
    expect_equal(as.matrix(dfm_lookup(testdfm, dict, levels = 3)),
                 matrix(c(0, 1, 0, 1), nrow = 2,
                        dimnames = list(docs = c('d1', 'd2'), features = c('west', 'east'))))
    expect_equal(as.matrix(dfm_lookup(testdfm, dict, levels = c(1,3))),
                 matrix(c(3, 0, 0, 2, 0, 1, 0, 1), nrow = 2,
                        dimnames = list(docs = c('d1', 'd2'), 
                                        features = c('US', 'Europe', 'Europe.west', 'Europe.east'))))
    expect_equal(as.matrix(dfm_lookup(testdfm, dict, levels = c(2,3))),
                 matrix(c(1, 2, 2, 0, 0, 1, 0, 1), nrow = 2,
                        dimnames = list(docs = c('d1', 'd2'), 
                                        features = c('Countries', 'oceans', 'oceans.west', 'oceans.east'))))
    expect_equal(as.matrix(dfm_lookup(testdfm, dict, levels = c(1,4))),
                 matrix(c(3, 0, 0, 4), nrow = 2,
                        dimnames = list(docs = c('d1', 'd2'), features = c('US', 'Europe'))))
    expect_equal(as.matrix(dfm_lookup(testdfm, dict, levels = 4)),
                 matrix(numeric(), nrow = 2, ncol = 0,
                        dimnames = list(docs = c('d1', 'd2'), features = NULL)))
    
})

test_that("dfm_lookup raises error when dictionary has multi-word entries", {
    toks <- tokens(data_corpus_inaugural[1:5])
    dict <- dictionary(list(Country = "united states"), separator = ' ')
    expect_equal(
        featnames(dfm_lookup(dfm(tokens_ngrams(toks, n = 2, concatenator = " ")), dictionary = dict)), 
        c("Country")
    )
})

test_that("dfm_lookup works with multi-word keys, issue #704", {
    
    dict <- dictionary(list('en'=list('foreign policy' = 'foreign', 'domestic politics' = 'domestic')))
    testdfm <- dfm(data_corpus_inaugural[1:5])
    expect_equal(featnames(dfm_lookup(testdfm, dict)),
                 c("en.foreign policy", "en.domestic politics"))
    
})

test_that("dfm_lookup return dfm even if no matches, issue #704", {
    dict <- dictionary(list('en'=list('foreign policy' = 'aaaaa', 'domestic politics' = 'bbbbb')))
    testdfm <- dfm(data_corpus_inaugural[1:5])
    expect_true(is.dfm(dfm_lookup(testdfm, dict)))
})

test_that("dfm_lookup return all features even if no matches when exclusive = FALSE, issue #116", {
    dict <- dictionary(list('en'=list('foreign policy' = 'aaaaa', 'domestic politics' = 'bbbbb')))
    testdfm <- dfm(data_corpus_inaugural[1:5])
    expect_equivalent(testdfm, dfm_lookup(testdfm, dict, exclusive = FALSE))
})

test_that("dfm_lookup verbose output works correctly", {
    expect_message(
        dfm_lookup(dfm(c(d1 = "a b c d", d2 = "c d e f g")), 
               dictionary(list(one = "a", two = c("d", "e"))), verbose = TRUE),
        "applying a dictionary consisting of 2 keys"
    )
    expect_silent(
        dfm_lookup(dfm(c(d1 = "a b c d", d2 = "c d e f g")), 
                   dictionary(list(one = "a", two = c("d", "e"))), verbose = FALSE)
    )
})

test_that("dfm_lookup with nomatch works", {
    txt <- c(d1 = "a c d d", d2 = "a a b c c c e f")
    dfm1 <- dfm(txt)
    dict <- dictionary(list(one = c("a", "b"), two = c("e", "f")))

    expect_equal(
        as.matrix(dfm_lookup(dfm1, dict)),
        as.matrix(dfm_lookup(dfm1, dict, nomatch = "_unmatched"))[, 1:2]
    )
    expect_equal(
        as.matrix(dfm_lookup(dfm1, dict, nomatch = "_unmatched")),
        matrix(c(1,3,0,2,3,3), nrow = 2, dimnames = list(docs = c("d1", "d2"), features = c("one", "two", "_unmatched")))
    )
    expect_warning(
        dfm_lookup(dfm1, dict, nomatch = "ANYTHING", exclusive = FALSE),
        "nomatch only applies if exclusive = TRUE"
    )
})

test_that("dfm_lookup works with exclusive = TRUE, #958", {
    
    txt <- c("word word2 document documents documenting",
             "use using word word2")
    dict <- dictionary(list(
        document = "document*",
        use      = c("use", "using")
    ))
    
    mx <- dfm(txt)
    expect_equal(
        as.matrix(dfm_lookup(mx, dict, exclusive = TRUE)),
        matrix(c(3,0,0,2), ncol = 2, dimnames = list(docs = c("text1", "text2"), 
                                                     features = c("document", "use")))
    )
    expect_equal(
        as.matrix(dfm_lookup(mx, dict, exclusive = FALSE, capkeys = TRUE)),
        matrix(c(1,1,1,1,3,0,0,2), ncol = 4, dimnames = list(docs = c("text1", "text2"), 
                                                             features = c("word", "word2", "DOCUMENT", "USE")))
    )
    expect_equal(
        as.matrix(dfm_lookup(mx, dict, exclusive = FALSE, capkeys = FALSE)),
        matrix(c(1,1,1,1,3,0,0,2), ncol = 4, dimnames = list(docs = c("text1", "text2"), 
                                                             features = c("word", "word2", "document", "use")))
    )
})

test_that("dfm_lookup works with zero count features, #958", {

    dict <- dictionary(list(A = 'aa', B = 'bb', D = 'dd'))
    mx1 <- as.dfm(matrix(c(0, 0 , 0, 0, 1, 2), nrow = 2, 
                         dimnames = list(c("doc1", "doc2"), c("aa", "bb", "cc"))))
    mx2 <- as.dfm(matrix(c(4, 5 , 0, 0, 0, 0), nrow = 2, 
                         dimnames = list(c("doc1", "doc2"), c("aa", "bb", "cc"))))
    
    expect_equal(as.matrix(dfm_lookup(mx1, dict, exclusive = TRUE)),
                 matrix(c(0, 0 , 0, 0, 0, 0), nrow = 2, 
                        dimnames = list(docs = c("doc1", "doc2"), features = c("A", "B", "D"))))
    
    expect_equal(as.matrix(dfm_lookup(mx2, dict, exclusive = TRUE)),
                 matrix(c(4, 5 , 0, 0, 0, 0), nrow = 2, 
                        dimnames = list(docs = c("doc1", "doc2"), features = c("A", "B", "D"))))
    
    expect_equal(as.matrix(dfm_lookup(mx1, dict, exclusive = FALSE)),
                 matrix(c(0, 0 , 0, 0, 1, 2), nrow = 2, 
                        dimnames = list(docs = c("doc1", "doc2"), features = c("A", "B", "cc"))))
    
    expect_equal(as.matrix(dfm_lookup(mx2, dict, exclusive = FALSE)),
                 matrix(c(4, 5 , 0, 0, 0, 0), nrow = 2, 
                        dimnames = list(docs = c("doc1", "doc2"), features = c("A", "B", "cc"))))
})

test_that("dfm_lookup works on a weighted dfm", {
    dict <- dictionary(list(first = LETTERS[1:5], second = LETTERS[6:10]))
    d <- dfm_weight(data_dfm_lbgexample, "prop")
    expect_equal(
        colSums(dfm_lookup(d, dictionary = dict)),
        c(first = 0.082, second = .740),
        tol = .001
    )
})

test_that("dfm_lookup with nomatch works with key that do not appear in the text, #1347", {
    
    txt <- c("12032 Musgrave rd red hill", 
             "13 rad street windermore park queensland",
             "130 right road", 
             "130 rtn road")
    toks <- tokens(txt)
    dict <- dictionary(list(CR = c("rd", "red"), 
                            CB = c("street", "feet"), 
                            CA = c("parl", "dark"))) # CA does not appear at all
    dfm_dict <- dfm_lookup(dfm(toks), dict, nomatch = "NONE")
    expect_identical(as.matrix(dfm_dict),
                      matrix(c(2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 3, 5, 3, 3), 
                             nrow = 4, dimnames = list(docs = c("text1", "text2", "text3", "text4"),
                                                       features = c("CR", "CB", "CA", "NONE"))))
})
