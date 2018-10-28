library(quanteda)
library(testthat)

context('test ngrams.R')

test_that("test that ngrams produces the results from Guthrie 2006", {
      toks <- tokens(c('insurgents killed in ongoing fighting'))

      bi_grams <- c('insurgents_killed', 'killed_in', 'in_ongoing', 
         'ongoing_fighting')
      two_skip_bi_grams <-  c('insurgents_killed', 'insurgents_in', 
         'insurgents_ongoing', 'killed_in', 'killed_ongoing', 'killed_fighting',
         'in_ongoing', 'in_fighting', 'ongoing_fighting')
      tri_grams <- c('insurgents_killed_in', 'killed_in_ongoing', 
         'in_ongoing_fighting')
      two_skip_tri_grams <-  c('insurgents_killed_in', 
          'insurgents_killed_ongoing', 'insurgents_killed_fighting',
          'insurgents_in_ongoing', 'insurgents_in_fighting', 
          'insurgents_ongoing_fighting', 'killed_in_ongoing', 
          'killed_in_fighting', 'killed_ongoing_fighting', 
          'in_ongoing_fighting')
      
      expect_equivalent(setdiff(
          as.list(tokens_ngrams(toks, n=2, skip=0))[[1]],
          bi_grams
          ), character(0)
      )
      
      expect_equivalent(setdiff(
          as.list(tokens_ngrams(toks, n=2, skip=0:2))[[1]],
          two_skip_bi_grams
          ), character(0)
      )
      
      expect_equivalent(setdiff(
          as.list(tokens_ngrams(toks, n=3, skip=0))[[1]],
          tri_grams
          ), character(0)
      )
      
      expect_equivalent(setdiff(
          as.list(tokens_ngrams(toks, n=3, skip=0:2))[[1]],
          two_skip_tri_grams
          ), character(0)
      )
      
      expect_equivalent(setdiff(
        as.list(tokens_ngrams(toks, n = 2:3))[[1]],
        c(bi_grams, tri_grams)
        ), character(0)
      )

      expect_equivalent(setdiff(
          as.list(suppressWarnings(tokens_ngrams(toks, n = 2:3)))[[1]],
          c(bi_grams, tri_grams)
      ), character(0)
      )
})

test_that("test `tokens_ngrams` on characters", {
    ngms <- quanteda:::tokens_ngrams.character(c('insurgents', 'killed', 'in', 'ongoing', 'fighting'))
    charNgms <- char_ngrams(c('insurgents','killed', 'in', 'ongoing', 'fighting'))
    expect_equivalent(
        ngms,
        c('insurgents_killed', 'killed_in', 'in_ongoing', 'ongoing_fighting')
    )
    
    expect_equivalent(
        charNgms,
        c('insurgents_killed', 'killed_in', 'in_ongoing', 'ongoing_fighting')
    )
    
    expect_warning(quanteda:::tokens_ngrams.character('insurgents killed', 'in', 'ongoing', 'fighting'), 
                 "whitespace detected: you may need to run tokens\\(\\) first")
    
    expect_warning(quanteda:::tokens_ngrams.character(c('insurgents killed in ongoing fighting'), n = 1, skip = 1), 
                   "skip argument ignored for n = 1")
})

test_that("test `tokens_ngrams` on skipgrams", {
    toks <- tokens("insurgents killed in ongoing fighting")
    ngms <- tokens_skipgrams(toks, n = 2, skip = 0:1, concatenator = " ") 
    expect_equivalent(
        as.list(ngms)[[1]],
        c('insurgents killed', "insurgents in",     "killed in" ,        "killed ongoing" , 
          "in ongoing",        "in fighting",       "ongoing fighting")
    )
})


test_that("tokens_ngrams does nothing when n = 1 and skip = 0 (#1395)", {
    
    toks <- tokens("insurgents killed in ongoing fighting")
    expect_identical(tokens_ngrams(toks, n = 1, skip = 0, concatenator = " "), toks)
    
})

test_that("test there is no competition between threads", {
    
    skip_on_cran()
    skip_on_travis()
    skip_on_appveyor()
    
    # increase the chance to generate the same ngram by duplicating texts
    txt <- char_tolower(rep("Insurgents killed in ongoing fighting.", 10))
    toks <- tokens(txt, remove_punct = TRUE)
    
    ngrs <- rep(list(c("insurgents_killed", "killed_in", "in_ongoing", "ongoing_fighting",
                       "insurgents_killed_in", "killed_in_ongoing", "in_ongoing_fighting")), 10)
    names(ngrs) <- names(toks)
    
    # needs to be repeated becasue thread compeition happen at low chance 
    for(k in 1:1000) {
        expect_identical(as.list(tokens_ngrams(toks, n = 2:3)), ngrs)
    }
})
    
test_that("tokens_ngrams(x, n = ...) works when ntokens(x) < n", {
    ## issue #392
    expect_equivalent(unclass(as.list(tokens_ngrams(tokens("a"), n = 2)))[[1]],
                      char_ngrams("a", n = 2))
})

