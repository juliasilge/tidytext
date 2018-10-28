context('test tokens_compound.R')

test_that("tokens_compound join tokens correctly", {
      
    txt <- c("a b c d e f g", "A B C D E F G", "A b C d E f G", 
             "aaa bbb ccc ddd eee fff ggg", "a_b b_c c_d d_e e_f f_g") 
    toks <- tokens(txt)
    seqs <- tokens(c("a b", "C D", "aa* bb*", "eEE FFf", "d_e e_f"), 
                   what = "fastestword")
    expect_equivalent(
        as.list(tokens_compound(toks, seqs, valuetype = "glob", case_insensitive = TRUE)),
        list(c("a_b", "c_d", "e", "f", "g"),
             c("A_B", "C_D", "E", "F", "G"),
             c("A_b", "C_d", "E", "f", "G"),
             c("aaa_bbb", "ccc", "ddd", "eee_fff", "ggg"),
             c("a_b", "b_c", "c_d", "d_e_e_f", "f_g"))
    )
    
    expect_equivalent(
        as.list(tokens_compound(toks, seqs, valuetype = "glob", case_insensitive = FALSE)),
        list(c("a_b", "c", "d", "e", "f", "g"),
             c("A", "B", "C_D", "E", "F", "G"),
             c("A", "b", "C", "d", "E", "f", "G"),
             c("aaa_bbb", "ccc", "ddd", "eee", "fff", "ggg"),
             c("a_b", "b_c", "c_d", "d_e_e_f", "f_g"))
    )
    
    seqs_fixed <- tokens(c("a b", "C D", "aa bb", "eEE FFf", "d_e e_f"), 
                         what = "fastestword")
    expect_equivalent(
        as.list(tokens_compound(toks, seqs_fixed, valuetype = "glob", case_insensitive = TRUE)),
        list(c("a_b", "c_d", "e", "f", "g"),
             c("A_B", "C_D", "E", "F", "G"),
             c("A_b", "C_d", "E", "f", "G"),
             c("aaa", "bbb", "ccc", "ddd", "eee_fff", "ggg"),
             c("a_b", "b_c", "c_d", "d_e_e_f", "f_g"))
    )
    
    expect_equivalent(
        as.list(tokens_compound(toks, seqs_fixed, valuetype = "glob", case_insensitive = FALSE)),
        list(c("a_b", "c", "d", "e", "f", "g"),
             c("A", "B", "C_D", "E", "F", "G"),
             c("A", "b", "C", "d", "E", "f", "G"),
             c("aaa", "bbb", "ccc", "ddd", "eee", "fff", "ggg"),
             c("a_b", "b_c", "c_d", "d_e_e_f", "f_g"))
    )
})

test_that("tokens_compound join a sequences of sequences", {
    
    txt <- c("a b c d e f g", "A B C D E F G") 
    toks <- tokens(txt)
    seqs <- tokens(c("a b", "b c d", "E F", "F G"), 
                   what = "fastestword")
    expect_equal(
        as.list(tokens_compound(toks, seqs, valuetype = "glob", case_insensitive = TRUE, join = TRUE)),
        list(text1 = c("a_b_c_d", "e_f_g"),
             text2 = c("A_B_C_D", "E_F_G"))
    )
    
    expect_equal(
        as.list(tokens_compound(toks, seqs, valuetype = "glob", case_insensitive = TRUE, join = FALSE)),
        list(text1 = c("a_b", "b_c_d", "e_f", "f_g"),
             text2 = c("A_B", "B_C_D", "E_F", "F_G"))
    )
    
    txts <- 'we like high quality sound'
    seqs <- phrase(c('high quality', 'quality sound'))
    expect_equal(as.list(tokens_compound(tokens(txts), seqs, join = TRUE)),
                      list(text1 = c("we", "like", "high_quality_sound")))
    expect_equal(as.list(tokens_compound(tokens(txts), seqs, join = FALSE)),
                      list(text1 = c("we", "like", "high_quality", "quality_sound")))
    
})

test_that("tokens_compound is not affected by the order of compounds", {
    expect_equal(
        as.list(tokens_compound(tokens("The people of the United States of America."), 
                                c("United States of America", "United States"))),
        as.list(tokens_compound(tokens("The people of the United States of America."), 
                                c("United States", "United States of America")))
    )
})

test_that("tokens_compound preserved document names", {
    expect_equal(
        names(tokens_compound(tokens(c(d1 = "The people of the United States of America.",
                                       d2 = "The United States is south of Canada.")),
                              c("United States", "United States of America"))),
        c("d1", "d2")
    )
})

test_that("tokens_compound works with padded tokens", {
    toks <- tokens(c(doc1 = 'a b c d e f g'))
    toks <- tokens_remove(toks, c('b', 'e'), padding = TRUE)
    toks <- tokens_compound(toks, phrase("c d"))
    expect_equal(sort(attr(toks, "types")),
                 sort(c("a", "c_d", "f", "g")))
})

test_that("tokens_compound works as expected with nested tokens", {

    expect_equal(
        as.character(tokens_compound(tokens("a b c d"), phrase(c("a b", "a b c")), 
                     join = FALSE)),
        c("a_b_c", "d")
    )
    expect_equal(
        as.character(tokens_compound(tokens("a b c d"), phrase(c("a b", "a b c")), 
                     join = TRUE)),
        c("a_b_c", "d")
    )
})

test_that("tokens_compound works as expected with nested and overlapping tokens", {

    expect_equal(
        as.character(tokens_compound(tokens("a b c d e"), 
                                     phrase(c("a b", "a b c", "c d")),
                                     join = FALSE)),
        c("a_b_c", "c_d", "e")
    )
    expect_equal(
        as.character(tokens_compound(tokens("a b c d e"), 
                                     phrase(c("a b", "a b c", "c d")),
                                     join = TRUE)),
        c("a_b_c_d", "e")
    )
})

test_that("tokens_compound works as expected with collocations", {
    cols <- textstat_collocations(tokens("capital gains taxes are worse than inheritance taxes"),
                                  size = 2, min_count = 1)
    toks <- tokens("The new law included capital gains taxes and inheritance taxes.")
    
    expect_equal(
        as.character(tokens_compound(toks, phrase(cols), join = FALSE))[c(5, 6, 8)],
        c("capital_gains", "gains_taxes", "inheritance_taxes")
    )
    expect_equal(
        as.character(tokens_compound(toks, phrase(cols), join = TRUE))[c(5, 7)],
        c("capital_gains_taxes", "inheritance_taxes")
    )

    expect_equal(
         tokens_compound(toks, cols),
         tokens_compound(toks, phrase(cols))
     )
    expect_equal(
        tokens_compound(toks, cols, join = TRUE),
        tokens_compound(toks, phrase(cols), join = TRUE)
    )
})

test_that("tokens_compound works as expected with dictionaries", {
    dict <- dictionary(list(taxcgt = c("capital gains tax*"), taxit = "inheritance tax*"))
    toks <- tokens("The new law included capital gains taxes and inheritance taxes.")
    expect_equal(
        as.character(tokens_compound(toks, dict))[c(5, 7)],
        c("capital_gains_taxes", "inheritance_taxes")
    )
    expect_equal(
        tokens_compound(toks, dict),
        tokens_compound(toks, phrase(dict))
    )
    
    dict <- dictionary(list(tax1 = c("capital gains", "taxes"), 
                            tax2 = "gains taxes"))
    expect_equal(
        as.character(tokens_compound(toks, dict, join = TRUE))[5],
        c("capital_gains_taxes")
    )
    expect_equal(
        as.character(tokens_compound(toks, dict, join = FALSE))[5:6],
        c("capital_gains", "gains_taxes")
    )
})

test_that("tokens_compound error when dfm is given, #1006", {
    toks <- tokens('a b c')
    expect_error(tokens_compound(toks, dfm('b c d')))
})
