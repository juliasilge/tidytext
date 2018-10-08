context("test texts")

test_that("test texts: general", {
    mycorp <- corpus(c(d1 = "This is first document", 
                       d2 = "This makes up a second text.",
                       d3 = "something completely different"),
                     docvars = data.frame(bool = c(TRUE, FALSE, TRUE),
                                          label_factor = factor(c("A", "B", "A")),
                                          label_txt = c("A", "B", "A")))
    expect_equal(texts(mycorp)[1], 
                 c(d1 = "This is first document"))
})

test_that("test texts with groups", {
    mycorp <- corpus(c(d1 = "This is first document", 
                       d2 = "This makes up a second text.",
                       d3 = "something completely different"),
                     docvars = data.frame(bool = c(TRUE, FALSE, TRUE),
                                          label_factor = factor(c("A", "B", "A")),
                                          label_txt = c("A", "B", "A")))
    expect_equal(texts(mycorp, groups = "bool")[2], 
                 c("TRUE" = "This is first document  something completely different"))
    expect_equal(texts(mycorp, groups = as.factor(docvars(mycorp, "bool")))[2], 
                 c("TRUE" = "This is first document  something completely different"))

    expect_equal(texts(mycorp, groups = "label_factor")[1], 
                 c(A = "This is first document  something completely different"))
    expect_equal(texts(mycorp, groups = docvars(mycorp, "label_factor"))[1], 
                 c(A = "This is first document  something completely different"))
    
    expect_equal(texts(mycorp, groups = "label_txt")[1], 
                 c(A = "This is first document  something completely different"))
    expect_equal(texts(mycorp, groups = docvars(mycorp, "label_txt"))[1], 
                 c(A = "This is first document  something completely different"))
    
    expect_error(texts(mycorp, groups = "label_txt2"),
                 "groups must name docvars or provide data matching the documents in x")
    expect_error(texts(mycorp, groups = 1:4),
                 "groups must name docvars or provide data matching the documents in x")
})

test_that("as.character.corpus same as texts.corpus", {
    expect_identical(texts(data_corpus_inaugural), 
                     as.character(data_corpus_inaugural))
})
