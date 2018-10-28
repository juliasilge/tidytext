context("corpus_sample tests")


doccorpus <- corpus(c(one = "Sentence one.  Sentence two.  Third sentence.",
                      two = "First sentence, doc2.  Second sentence, doc2."))
sentcorpus <- corpus_reshape(doccorpus, to = "sentences")


test_that("test corpus_sample to see if without grouping, documents can be oversampled", {
    # sampling without document grouping should be able to produce oversampling of a document
    set.seed(100)
    expect_gt(
        sum(stringi::stri_detect_regex(docnames(corpus_sample(sentcorpus, replace = TRUE)), "^one")),
        3
    )         
})

test_that("test corpus_sample to see if with grouping, documents can be oversampled", {
    # sampling without document grouping should be able to produce oversampling of a document
    # resample 10 times
    for (i in 1:10) {
        expect_equal(
            sum(stringi::stri_detect_regex(docnames(corpus_sample(sentcorpus, replace = TRUE, by = "_document")), "^one")),
            3
        )
    }
})

test_that("disabled nresample funtions \"work\"", {
    expect_equal(quanteda:::nresample(data_corpus_inaugural), 0)
    expect_equal(quanteda:::is.resampled(data_corpus_inaugural), FALSE)
})
