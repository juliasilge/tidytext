context('test tokens_lookup')


txt <- c(d1 = "The United States is bordered by the Atlantic Ocean and the Pacific Ocean.",
         d2 = "The Supreme Court of the United States is seldom in a united state.",
         d3 = "It's Arsenal versus Manchester United, states the announcer.",
         d4 = "We need Manchester Unity in the Federal Republic of Germany today.",
         d5 = "United statehood is a good state.",
         d6 = "luv the united states XXOO!")
toks <- tokens(txt, remove_punct = TRUE)

test_that("multi-word dictionary keys are counted correctly", {
    
    dict_mw_fixed <- dictionary(list(Countries = c("United States", "Federal Republic of Germany"),
                                     oceans = c("Atlantic Ocean", "Pacific Ocean"),
                                     Institutions = c("federal government", "Supreme Court"),
                                     team = c("Manchester United", "Arsenal")), tolower = FALSE)
    tokens_case_asis <- 
        tokens_lookup(toks, dict_mw_fixed, valuetype = "fixed", case_insensitive = FALSE)
    
    dfm_case_asis <- dfm(tokens_case_asis, tolower = FALSE)
    expect_equal(as.vector(dfm_case_asis[, "Countries"]), c(1, 1, 0, 1, 0, 0))
    expect_equal(as.vector(dfm_case_asis[, "team"]), c(0, 0, 2, 0, 0, 0))
    
    expect_equal(as.vector(dfm_case_asis["d3", "team"]), 2)
    # note the overlap of Manchester United states in d3
    expect_equal(as.vector(dfm_case_asis["d3", "Countries"]), 0)
    
    tokens_case_ignore <- 
        tokens_lookup(toks, dict_mw_fixed, valuetype = "fixed", case_insensitive = TRUE)
    dfm_case_ignore <- dfm(tokens_case_ignore, tolower = FALSE)
    expect_equal(as.vector(dfm_case_ignore[, "Countries"]), c(1, 1, 1, 1, 0, 1))
    
    expect_equal(as.vector(dfm_case_ignore["d3", "team"]), 2)
    # note the overlap of Manchester United states in d3
    expect_equal(as.vector(dfm_case_ignore["d3", "Countries"]), 1)
    
    dict_mw_glob <- dictionary(list(Countries = c("United States", "Federal * of *"),
                                    oceans = c("* Ocean"),
                                    Institutions = c("federal gover*", "Supreme Court"),
                                    team = c("Manchester *", "Arsenal")), tolower = FALSE)
    tokens_case_asis_glob <- 
        tokens_lookup(toks, dict_mw_glob, valuetype = "glob", case_insensitive = FALSE)
    
    dfm_case_asis_glob <- dfm(tokens_case_asis_glob, tolower = FALSE)
    expect_equal(as.vector(dfm_case_asis_glob[, "Countries"]), c(1, 1, 0, 1, 0, 0))
    expect_equal(as.vector(dfm_case_asis_glob[, "oceans"]), c(2, 0, 0, 0, 0, 0))
    expect_equal(as.vector(dfm_case_asis_glob[, "team"]), c(0, 0, 2, 1, 0, 0))
    
})

test_that("entirely single-word dictionary keys are counted correctly", {
    
    dict_sw_fixed <- dictionary(list(Countries = c("States", "Germany"),
                                     oceans = c("Atlantic", "Pacific"),
                                     Institutions = c("government", "Court"),
                                     team = c("Manchester", "Arsenal")), tolower = FALSE)    
    
    tokens_case_asis <- 
        tokens_lookup(toks, dict_sw_fixed, valuetype = "fixed", case_insensitive = FALSE)
    dfm_case_asis <- dfm(tokens_case_asis, tolower = FALSE)
    expect_equal(as.vector(dfm_case_asis[, "Countries"]), c(1, 1, 0, 1, 0, 0))
    expect_equal(as.vector(dfm_case_asis[, "team"]), c(0, 0, 2, 1, 0, 0))
    
    expect_equal(as.vector(dfm_case_asis["d3", "team"]), 2)
    # note the overlap of Manchester United states in d3
    expect_equal(as.vector(dfm_case_asis["d3", "Countries"]), 0)
    
    tokens_case_ignore <- 
        tokens_lookup(toks, dict_sw_fixed, valuetype = "fixed", case_insensitive = TRUE)
    dfm_case_ignore <- dfm(tokens_case_ignore, tolower = FALSE)
    expect_equal(as.vector(dfm_case_ignore[, "Countries"]), c(1, 1, 1, 1, 0, 1))
    
    expect_equal(as.vector(dfm_case_ignore["d3", "team"]), 2)
    expect_equal(as.vector(dfm_case_ignore["d3", "Countries"]), 1)
    
})


test_that("multi-word dictionary behavior is not sensitive to the order of dictionary entries", {
    
    txt <- c(d1 = "The United States is a country.", 
             d2 = "Arsenal v Manchester United, states the announcer.")
    toks <- tokens(txt, remove_punct = TRUE)
    dict1 <- dictionary(list(Countries = c("United States"),
                             team = c("Manchester United", "Arsenal")))
    dict2 <- dictionary(list(team = c("Arsenal", "Manchester United"),
                             Countries = c("United States")))
    expect_equal(
        as.list(tokens_lookup(toks, dictionary = dict1, valuetype = "fixed")),
        as.list(tokens_lookup(toks, dictionary = dict2, valuetype = "fixed"))
    )
    
})

test_that("#388 issue about overlapping key values is resolved: fixed matches", {
    txt <- c(d1 = "The United States is bordered by the Atlantic Ocean and the Pacific Ocean.",
             d2 = "The Supreme Court of the United States is seldom in a united state.")
    toks <- tokens(txt)
    dict_fixed <- dictionary(list(Countries = c("States"),
                                  oceans = c("Atlantic", "Pacific"),
                                  gameconsoles = c("Xbox", "Nintendo"),
                                  swords = c("States")))
    
    expect_equal(as.list(tokens_lookup(toks, dict_fixed, valuetype = "fixed")),
                 list(d1 = c("Countries", "swords", "oceans", "oceans"),
                      d2 = c("Countries", "swords")))
})

test_that("#388 issue about overlapping key values is resolved: glob matches", {
    txt <- c(d1 = "The United States is bordered by the Atlantic Ocean and the Pacific Ocean.",
             d2 = "The Supreme Court of the United States is seldom in a united state.")
    toks <- tokens(txt)
    dict_glob <- dictionary(list(Countries = c("Stat*"),
                                 oceans = c("*ic"),
                                 gameconsoles = c("?box", "Nintendo*"),
                                 swords = "*s"), tolower = FALSE)
    
    expect_equal(as.list(tokens_lookup(toks, dict_glob, valuetype = "glob")),
                 list(d1 = c("Countries", "swords", "swords", "oceans", "oceans"),
                      d2 = c("Countries", "swords", "swords", "Countries")))
    expect_equal(as.list(tokens_lookup(toks, dict_glob, valuetype = "glob", case_insensitive = FALSE)),
                 list(d1 = c("Countries", "swords", "swords", "oceans", "oceans"),
                      d2 = c("Countries", "swords", "swords")))
})

test_that("#388 issue about overlapping key values is resolved: regex matches", {
    txt <- c(d1 = "The United States is bordered by the Atlantic Ocean and the Pacific Ocean.",
             d2 = "The Supreme Court of the United States is seldom in a united state.")
    toks <- tokens(txt)
    dict_regex <- dictionary(list(Countries = c("Stat.*$"),
                                  oceans = c("[A-Z][a-z]+ic"),
                                  gameconsoles = c("Xbox"),
                                  swords = "s$"), tolower = FALSE)
    
    expect_equal(as.list(tokens_lookup(toks, dict_regex, valuetype = "regex")),
                 list(d1 = c("Countries", "swords", "swords", "oceans", "oceans"),
                      d2 = c("Countries", "swords", "swords", "Countries")))
    expect_equal(as.list(tokens_lookup(toks, dict_regex, valuetype = "regex", case_insensitive = FALSE)),
                 list(d1 = c("Countries", "swords", "swords", "oceans", "oceans"),
                      d2 = c("Countries", "swords", "swords")))
    
})

test_that("non-exclusive lookup is working",{
    
    toks <- tokens(c(d1 = "Mexico signed a new libertarian law with Canada.",
                     d2 = "Let freedom ring in the United States!"),
                   remove_punct = TRUE)
    dict <- dictionary(list(country = c("united states", "mexico", "canada"), 
                            "law words" = c('law*', 'constitution'), 
                            freedom = c('free', "freedom", 'libertarian'),
                            overlap = "United"))
    
    expect_equal(as.list(tokens_lookup(toks, dict, exclusive = FALSE, capkeys = TRUE)),
                 list(d1=c("COUNTRY", "signed", "a", "new", "FREEDOM", "LAW WORDS", "with", "COUNTRY"),
                      d2=c("Let", "FREEDOM", "ring", "in", "the", "COUNTRY", "OVERLAP")))
})

test_that("tokens_lookup preserves case on keys", {
    ## issue #393
    toks <- tokens(data_corpus_inaugural[1:5])
    dict <- dictionary(list(Country = "united states",
                            HOR = c("House of Re*")))
    expect_identical(featnames(dfm(tokens_lookup(toks, dict), tolower = FALSE)),
                     c("Country", "HOR"))
})

test_that("multi-word dictionary behavior is not affected by padding", {
    
    toks <- tokens(c(d1 = "Mexico signed a new libertarian law with Canada.",
                     d2 = "Let freedom ring in the United States!"),
                   remove_punct = TRUE)
    toks <- tokens(txt, remove_punct = TRUE)
    toks2 <- tokens_remove(toks, stopwords('english'), padding = TRUE)
    dict <- dictionary(list(country = c("united states", "mexico", "canada"), 
                            "law words" = c('law*', 'constitution'), 
                            freedom = c('free', "freedom", 'libertarian'),
                            overlap = "United"))
    expect_equal(
        as.list(tokens_lookup(toks, dictionary = dict, valuetype = "fixed")),
        as.list(tokens_lookup(toks2, dictionary = dict, valuetype = "fixed"))
    )
    
})


test_that("#459 apply a hierarchical dictionary", {
    
    txt <- c(d1 = "The United States is bordered by the Atlantic Ocean and the Pacific Ocean.",
             d2 = "The Supreme Court of the United States is seldom in a united state.")
    toks <- tokens(txt)
    dict <- dictionary(list('geo'=list(
        Countries = c("States"),
        oceans = c("Atlantic", "Pacific")),
        'other'=list(
            gameconsoles = c("Xbox", "Nintendo"),
            swords = c("States"))), tolower = FALSE)
    
    expect_equal(as.list(tokens_lookup(toks, dict, valuetype = "fixed", levels=1)),
                 list(d1 = c("geo", "other", "geo", "geo"),
                      d2 = c("geo", "other")))
    
    expect_equal(as.list(tokens_lookup(toks, dict, valuetype = "fixed", levels=1:2)),
                 list(d1 = c("geo.Countries", "other.swords", "geo.oceans", "geo.oceans"),
                      d2 = c("geo.Countries", "other.swords")))
    
    expect_equal(as.list(tokens_lookup(toks, dict, valuetype = "fixed", levels=2)),
                 list(d1 = c("Countries", "swords", "oceans", "oceans"),
                      d2 = c("Countries", "swords")))
})

test_that("#459 extract the lower levels of a dictionary using tokens_lookup", {
    txt <- c(d1 = "The United States has the Atlantic Ocean and the Pacific Ocean.",
             d2 = "Britain and Ireland have the Irish Sea and the English Channel.")
    toks <- tokens(txt)
    dict <- dictionary(list('US' = list(
                                    Countries = c("States"),
                                    oceans = c("Atlantic", "Pacific")),
                            'Europe' = list(
                                Countries = c("Britain", "Ireland"),
                                oceans = list(west = "Irish Sea", 
                                              east = "English Channel"))))

    expect_equal(as.list(tokens_lookup(toks, dict, levels = 1)),
                 list(d1 = c('US', 'US', 'US'), 
                      d2 = c('Europe', 'Europe', 'Europe', 'Europe')))
    expect_equal(as.list(tokens_lookup(toks, dict, levels = 2)),
                 list(d1 = c('Countries', 'oceans', 'oceans'), 
                      d2 = c('Countries', 'Countries', 'oceans', 'oceans')))
    expect_equal(as.list(tokens_lookup(toks, dict, levels = 1:2)),
                 list(d1 = c('US.Countries', 'US.oceans', 'US.oceans'), 
                      d2 = c('Europe.Countries', 'Europe.Countries', 'Europe.oceans', 'Europe.oceans')))
    expect_equal(as.list(tokens_lookup(toks, dict, levels = 3)),
                 list(d1 = character(), 
                      d2 = c('west', 'east')))
    expect_equal(as.list(tokens_lookup(toks, dict, levels = c(1,3))),
                 list(d1 = c('US', 'US', 'US'), 
                      d2 = c('Europe', 'Europe', 'Europe.west', 'Europe.east')))
    expect_equal(as.list(tokens_lookup(toks, dict, levels = c(2,3))),
                 list(d1 = c('Countries', 'oceans', 'oceans'), 
                      d2 = c('Countries', 'Countries', 'oceans.west', 'oceans.east')))
    expect_equal(as.list(tokens_lookup(toks, dict, levels = c(1, 4))),
                 list(d1 = c('US', 'US', 'US'), 
                      d2 = c('Europe', 'Europe', 'Europe', 'Europe')))
    expect_equal(as.list(tokens_lookup(toks, dict, levels = 4)),
                 list(d1 = character(), 
                      d2 = character()))
})

test_that("#480 reset padding flag", {
    
    toks <- tokens(data_corpus_inaugural[1:5])
    toks <- tokens_remove(toks, stopwords('english'), padding = TRUE)
    dict <- dictionary(list(Country = "united states",
                            HOR = c("House of Re*")))
    expect_false('' %in% featnames(dfm(tokens_lookup(toks, dict, exclusive = TRUE), tolower = FALSE)))
})


test_that("#500 tokens_lookup separates entry words by separator", {
    
    toks <- tokens(data_corpus_inaugural[1:5])
    dict <- dictionary(list(Country = "united_states",
                            HOR = c("House_of_Re*")), separator = '_')
    expect_identical(featnames(dfm(tokens_lookup(toks, dict), tolower = FALSE)),
                     c("Country", "HOR"))
})


# test_that("#500 tokens_lookup do not separate words when multiword = FALSE", {
#     toks <- as.tokens(list(d1 = c('United States', 'Atlantic Ocean', 'Pacific Ocean'),
#                            d2 = c('Supreme Court', 'United States')))
#     dict <- dictionary(list(Countries = c("United States"),
#                             oceans = c("Atlantic *", "Pacific *")))
#     
#     expect_equal(as.list(tokens_lookup(toks, dict, valuetype = "glob", multiword = FALSE)),
#                  list(d1 = c("Countries", "oceans", "oceans"),
#                       d2 = c("Countries")))
# })

test_that("#500 tokens_lookup substitute concatenator", {
    toks <- as.tokens(list(d1 = c('United-States', 'Atlantic-Ocean', 'Pacific-Ocean'),
                           d2 = c('Supreme-Court', 'United-States')), concatenator = '-')
    dict <- dictionary(list(Countries = c("United_States"),
                            oceans = c("Atlantic_*", "Pacific_*")), separator = '_')
    
    expect_equal(as.list(tokens_lookup(toks, dict, valuetype = "glob")),
                 list(d1 = c("Countries", "oceans", "oceans"),
                      d2 = c("Countries")))
})


test_that("#502 tokens_lookup count overlapped words", {
    
    txt <- c(d1 = "The United States of America is bordered by the Atlantic Ocean and the Pacific Ocean.",
             d2 = "The Supreme Court of the United States is seldom in a united state.")
    toks <- tokens(txt)
    dict <- dictionary(list(Countries = c("United States", "United States of America"),
                            oceans = c("Ocean")))
    expect_equal(as.list(tokens_lookup(toks, dict, valuetype = "glob")),
                 list(d1 = c("Countries", "oceans", "oceans"),
                      d2 = c("Countries")))
    expect_equal(as.list(tokens_lookup(toks, dict, valuetype = "fixed")),
                 list(d1 = c("Countries", "oceans", "oceans"),
                      d2 = c("Countries")))
    
    dict <- dictionary(list(Countries = c("United States", "Unit Stat of America"),
                            oceans = c("Ocean.*")))
    expect_equal(as.list(tokens_lookup(toks, dict, valuetype = "regex")),
                 list(d1 = c("Countries", "oceans", "oceans"),
                      d2 = c("Countries")))
    
    expect_equal(
        as.character(tokens_lookup(tokens("A B C"), dictionary(list(key = c("A B", "A B C"))))),
        c("key")
    )
    
    expect_equal(
        as.character(tokens_lookup(tokens("A B C"), dictionary(list(key = c("B C", "A B C"))))),
        c("key")
    )
})



test_that("tokens_lookup with nomatch works", {
    txts <- c(d1 = "a c d d", d2 = "a a b c c c e f")
    toks <- tokens(txts)
    dict <- dictionary(list(one = c("a", "b", "b c"), two = c("e", "f")))
    
    expect_equal(
        as.matrix(dfm(tokens_lookup(toks, dict))),
        as.matrix(dfm(tokens_lookup(toks, dict, nomatch = "_unmatched")))[, 1:2]
    )
    
    expect_equivalent(
        as.matrix(cbind("_unmatched" = ntoken(tokens_remove(toks, dict)))),
        as.matrix(dfm(tokens_lookup(toks, dict, nomatch = "_unmatched")))[, "_unmatched", drop = FALSE]
    )
    
    expect_equal(
        as.matrix(dfm(tokens_lookup(toks, dict, nomatch = "_unmatched"))),
        matrix(c(1,3,0,2,3,2), nrow = 2, dimnames = list(docs = c("d1", "d2"), features = c("one", "two", "_unmatched")))
    )
    expect_warning(
        tokens_lookup(toks, dict, nomatch = "ANYTHING", exclusive = FALSE),
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
    
    toks <- tokens(txt)
    expect_equal(
        as.list(tokens_lookup(toks, dict, exclusive = FALSE, capkeys = FALSE)),
        list(text1 = c('word', 'word2', 'document', 'document', 'document'), 
             text2 = c('use', 'use', 'word', 'word2'))
    )
    expect_equal(
        as.list(tokens_lookup(toks, dict, exclusive = FALSE, capkeys = TRUE)),
        list(text1 = c('word', 'word2', 'DOCUMENT', 'DOCUMENT', 'DOCUMENT'), 
             text2 = c('USE', 'USE', 'word', 'word2'))
    )
})

test_that("dfm_lookup match the same words in exclusive = TRUE and FALSE, #970", {
    
    toks <- tokens("say good bye to Hollywood")
    dict <- dictionary(list(pos = "good", farewell = "good bye"))
    
    expect_equal(as.list(tokens_lookup(toks, dict, exclusive = TRUE)),
                 list(text1 = c("pos", "farewell")))
    
    expect_equal(as.list(tokens_lookup(toks, dict, exclusive = FALSE)),
                 list(text1 = c("say", "POS", "FAREWELL", "to", "Hollywood")))

})

test_that("tokens_lookup works when exclusive = FALSE, #970", {
    
    dict <- dictionary(list(sequence1 = "a b", sequence2 = "x y", notseq = c("d", "e")))
    txt <- c(d1 = "a b c d e f g x y z",
             d2 = "a c d x z",
             d3 = "x y",
             d4 = "f g")
    toks <- tokens(txt)
    expect_equal(as.list(tokens_lookup(toks, dict, exclusive = FALSE)),
                 list(d1 = c("SEQUENCE1", "c", "NOTSEQ", "NOTSEQ", "f", "g", "SEQUENCE2", "z"), 
                      d2 = c("a","c", "NOTSEQ", "x", "z"),
                      d3 = c("SEQUENCE2"),
                      d4 = c("f", "g"))
                 )
    
})

test_that("tokens_lookup works when there is a key with non-existent values and when exclusive = FALSE, #1011", {
    
    dict <- dictionary(list(sequence1 = "a b", sequence2 = "x y", notseq = c("d", "e"), notexist = c("zzz")))
    txt <- c(d1 = "a b c d e f g x y z",
             d2 = "a c d x z",
             d3 = "x y",
             d4 = "f g")
    toks <- tokens(txt)
    expect_equal(as.list(tokens_lookup(toks, dict, exclusive = FALSE)),
                 list(d1 = c("SEQUENCE1", "c", "NOTSEQ", "NOTSEQ", "f", "g", "SEQUENCE2", "z"), 
                      d2 = c("a","c", "NOTSEQ", "x", "z"),
                      d3 = c("SEQUENCE2"),
                      d4 = c("f", "g"))
    )
    
})

test_that("tokens_lookup with nomatch works with key that do not appear in the text, #1347", {
    txt <- c("12032 Musgrave rd red hill", 
             "13 rad street windermore park queensland",
             "130 right road", 
             "130 rtn road")
    toks <- tokens(txt)
    dict <- dictionary(list(CR = c("rd", "red"), 
                            CB = c("street", "feet"), 
                            CA = c("parl", "dark"))) # CA does not appear at all
    toks_dict <- tokens_lookup(toks, dict, nomatch = "NONE")
    expect_identical(as.list(toks_dict), 
                      list(text1 = c("NONE", "NONE", "CR", "CR", "NONE"), 
                           text2 = c("NONE", "NONE", "CB", "NONE", "NONE", "NONE"), 
                           text3 = c("NONE", "NONE", "NONE"),
                           text4 = c("NONE", "NONE", "NONE")))
    expect_equivalent(unclass(toks_dict), 
                      list(c(4, 4, 1, 1, 4), c(4, 4, 2, 4, 4, 4), c(4, 4, 4), c(4, 4, 4)))
    expect_identical(types(toks_dict), c("CR", "CB", "CA", "NONE"))
})
