context("textstat_readability")

test_that("readability works: basic", {
    txt <- "This was adjusted by a prolongation of the period of reimbursement in nature of a new loan 
            at an interest of 5% for the term of ten years, and the expenses of this operation were a commission of 3%.  
            The first installment of the loan of $2,000,000 from the Bank of the United States has been paid, as was directed by law.  
            For the second it is necessary that provision be made.  
            No pecuniary consideration is more urgent than the regular redemption and discharge of the public debt."
    expect_true(!is.na(textstat_readability(txt, "Flesch")$Flesch))
})

test_that("readability count is ok", {
    expect_equivalent(textstat_readability("The cat in the hat ate breakfast.", "Flesch")$Flesch, 103,
                      tolerance = 0.01)
    expect_equivalent(textstat_readability("The cat in the hat ate breakfast.", "FOG")$FOG, 2.8)
})

test_that("readability works with sentence length filtering", {
    txt <- c("PAGE 1. This is a single sentence.  Short sentence. Three word sentence.",
             "PAGE 2. Very short! Shorter.",
             "Very long sentence, with multiple parts, separated by commas.  PAGE 3.")
    rdb <- textstat_readability(txt)
    expect_equal(rdb$meanSentenceLength, c(3, 1.67, 5.50), tolerance = 0.01)
    
    rdb2 <- textstat_readability(txt, min_sentence_length = 3)
    expect_equal(rdb2$meanSentenceLength, c(4, 9))
})

test_that("readability works as koRpus", {
    skip_if_not_installed("koRpus")
    #q_rdb <- textstat_readability("The cat in the hat ate breakfast.")
    #fileName <- "sample_text2.txt"  
    #for this a bit longer file, the results differed a bit because the tokenizations are 
    #inconsistent between two packages. 
    fileName <- "sample_text.txt"
    q_rdb <- textstat_readability(readChar(fileName, file.info(fileName)$size))
    
    # readability analysis from package koRpus
    k_toks <- koRpus::tokenize(fileName, lang = "en")
    wordlist_DC <- data_char_wordlists$dalechall
    k_rdb <- koRpus::readability(k_toks, 
                                 word.lists = list(Bormuth = wordlist_DC, 
                                                   Dale.Chall = wordlist_DC, 
                                                   Harris.Jacobson = wordlist_DC))
    
    expect_equal(round(q_rdb$ARI, 2), round(k_rdb@ARI$grade, 2))
    expect_equal(round(q_rdb$Coleman.Liau.grade, 2), round(k_rdb@Coleman.Liau$grade, 2))
    expect_equal(round(q_rdb$Flesch, 2), round(k_rdb@Flesch$RE, 2))
    expect_equal(round(q_rdb$SMOG, 2), round(k_rdb@SMOG$grade, 2))
})

