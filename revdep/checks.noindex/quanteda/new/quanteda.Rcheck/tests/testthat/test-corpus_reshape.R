context("Testing corpus_reshape")

test_that("corpus_reshape works for sentences", {
    mycorpus <- corpus(c(textone = "This is a sentence.  Another sentence.  Yet another.", 
                         texttwo = "Premiere phrase.  Deuxieme phrase."), 
                       docvars = data.frame(country=c("UK", "USA"), year=c(1990, 2000)),
                       metacorpus = list(notes = "Example showing how corpus_reshape() works."))
    mycorpus_reshaped <- corpus_reshape(mycorpus, to = "sentences")
    expect_equal(as.character(mycorpus_reshaped)[4], c(texttwo.1 = "Premiere phrase."))
    expect_equal(docvars(mycorpus_reshaped, "country"), factor(c("UK", "UK", "UK", "USA", "USA")))
})

test_that("corpus_reshape works for paragraphs", {
    mycorpus <- corpus(c(d1 = "Paragraph one.  

Second paragraph is this one!  Here is the third sentence.",
                                      d2 = "Only paragraph of doc2?  

No there is another."),
             docvars = data.frame(document = c("one", "two")))
    mycorpus_reshaped <- corpus_reshape(mycorpus, to = "paragraphs")
    
    expect_equal(as.character(mycorpus_reshaped)[4],
                 c(d2.2 = "No there is another."))
})

test_that("corpus_reshape works to sentences and back", {
    mycorpus <- corpus(c(textone = "This is a sentence.  Another sentence.  Yet another.", 
                         texttwo = "Premiere phrase.  Deuxieme phrase."), 
                       docvars = data.frame(country=c("UK", "USA"), year=c(1990, 2000)),
                       metacorpus = list(notes = "Example showing how corpus_reshape() works."))
    mycorpus_reshaped <- corpus_reshape(mycorpus, to = "sentences")
    mycorpus_unshaped <- corpus_reshape(mycorpus_reshaped, to = "documents")
    expect_equal(texts(mycorpus),
                 texts(mycorpus_unshaped))
    expect_equal(docvars(mycorpus),
                 docvars(mycorpus_unshaped))
})

test_that("corpus_reshape works to paragraphs and back", {
    mycorpus <- corpus(c(textone = "This is a paragraph.\n\nAnother paragraph.\n\nYet paragraph.", 
                         texttwo = "Premiere phrase.\n\nDeuxieme phrase."), 
                       docvars = data.frame(country=c("UK", "USA"), year=c(1990, 2000)),
                       metacorpus = list(notes = "Example showing how corpus_reshape() works."))
    mycorpus_reshaped <- corpus_reshape(mycorpus, to = "paragraphs")
    mycorpus_unshaped <- corpus_reshape(mycorpus_reshaped, to = "documents")
    expect_equal(texts(mycorpus),
                 texts(mycorpus_unshaped))
    expect_equal(docvars(mycorpus),
                 docvars(mycorpus_unshaped))
})

test_that("corpus_reshape works with empty documents, issue #670", {
    mycorpus <- corpus(c(textone = "This is a paragraph.\n\nAnother paragraph.\n\nYet paragraph.", 
                         texttwo = "Premiere phrase.\n\nDeuxieme phrase.",
                         textthree = ""), 
                       docvars = data.frame(country=c("UK", "USA", "Japan"), year=c(1990, 2000, 2010)),
                       metacorpus = list(notes = "Example showing how corpus_reshape() works."))
    mycorpus_reshaped <- corpus_reshape(mycorpus, to = "paragraphs")
    mycorpus_unshaped <- corpus_reshape(mycorpus_reshaped, to = "documents")
    expect_equal(texts(mycorpus),
                 texts(mycorpus_unshaped))
    expect_equal(docvars(mycorpus),
                 docvars(mycorpus_unshaped))
})

test_that("corpus_reshape produces error message for non-available to values", {
    mycorpus <- corpus(c(textone = "This is a sentence.  Another sentence.  Yet another.", 
                         texttwo = "Premiere phrase.  Deuxieme phrase."), 
                       docvars = data.frame(country=c("UK", "USA"), year=c(1990, 2000)),
                       metacorpus = list(notes = "Example showing how corpus_reshape() works."))
    expect_error(
        corpus_reshape(mycorpus, to = "documents"),
        "reshape to documents only goes from sentences or paragraphs"
    )
    expect_error(
        corpus_reshape(corpus_reshape(mycorpus, to = "sentences"), to = "sentences"),
        "reshape to sentences or paragraphs only goes from documents"
    )
})

