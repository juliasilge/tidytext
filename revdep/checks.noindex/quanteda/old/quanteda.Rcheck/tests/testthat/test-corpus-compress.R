context('test compressed corpus option.R')

txt <- c(doc1 = "This is a sample text.\nIt has three lines.\nThe third line.",
         doc2 = "one\ntwo\tpart two\nthree\nfour.",
         doc3 = "A single sentence formerly with anemoji.",
         doc4 = "A sentence with \"escaped quotes\".")
dv <- data.frame(varnumeric = 10:13, varfactor = factor(c("A", "B", "A", "B")), varchar = letters[1:4])
data_corpus_test    <- corpus(txt, docvars = dv, metacorpus = list(source = "From test-corpuzip.R"))
data_corpuszip_test <- corpus(txt, docvars = dv, metacorpus = list(source = "From test-corpuzip.R"), compress = TRUE)
metacorpus(data_corpus_test, "created") <- "same"
metacorpus(data_corpuszip_test, "created") <- "same"

test_that("as.corpus.corpuszip works", {
    skip_on_cran()
    expect_equal(data_corpus_test, as.corpus(data_corpuszip_test))
})

test_that("print method works for corpuszip", {
    expect_output(print(data_corpus_test), regexp = "^Corpus consisting of 4 documents and 3 docvars\\.$")
    expect_output(print(data_corpuszip_test), regexp = "^Corpus consisting of 4 documents and 3 docvars \\(compressed")
})

test_that("summary method works for corpuszip", {
    expect_output(print(summary(data_corpus_test)), regexp = "^Corpus consisting of 4 documents")
    expect_output(print(summary(data_corpuszip_test)), regexp = "^Corpus consisting of 4 documents \\(compressed")
})

test_that("is.corpus methods work", {
    expect_true(is.corpuszip(data_corpuszip_test))
    expect_true(is.corpus(data_corpuszip_test))
    expect_true(!is.corpuszip(data_corpus_test))
    expect_true(is.corpus(data_corpus_test))
})

test_that("+ and c() methods work for corpus and corpuszip", {
    expect_equal(docvars(data_corpuszip_test + data_corpuszip_test),
                 docvars(data_corpus_test + data_corpus_test))
    expect_equal(texts(data_corpuszip_test + data_corpuszip_test),
                 texts(data_corpus_test + data_corpus_test))
    expect_equal(docvars(c(data_corpuszip_test, data_corpuszip_test, data_corpuszip_test)),
                 docvars(c(data_corpus_test, data_corpus_test, data_corpus_test)))
    expect_equal(texts(c(data_corpuszip_test, data_corpuszip_test, data_corpuszip_test)),
                 texts(c(data_corpus_test, data_corpus_test, data_corpus_test)))
})

test_that("as.character and texts methods work for corpus and corpuszip", {
    expect_equal(texts(data_corpuszip_test), texts(data_corpus_test))
    expect_equal(as.character(data_corpuszip_test), as.character(data_corpus_test))
})


test_that("collocations works for corpus and corpuszip", {
    expect_equal(textstat_collocations(data_corpuszip_test), textstat_collocations(data_corpus_test))
    expect_equal(as.character(data_corpuszip_test), as.character(data_corpus_test))
})

test_that("corpus_reshape works for corpus and corpuszip", {
    c1 <- corpus_reshape(data_corpus_test, to = "sentences")
    c2 <- corpus_reshape(data_corpuszip_test, to = "sentences")
    metacorpus(c1, "created") <- metacorpus(c2, "created") <- NULL
    metacorpus(c1, "notes") <- metacorpus(c2, "notes") <- NULL
    expect_equal(c1, c2)
})

test_that("corpus_sample works for corpus and corpuszip", {
    set.seed(100)
    c1 <- corpus_sample(data_corpus_test)
    set.seed(100)
    c2 <- corpus_sample(data_corpuszip_test)
    metacorpus(c1, "created") <- metacorpus(c2, "created") <- NULL
    expect_equal(texts(c1), texts(c2))
    expect_equal(docvars(c1), docvars(c2))
})

test_that("corpus_segment works for corpus and corpuszip", {
    c1 <- corpus_segment(data_corpus_test, "sentences")
    c2 <- corpus_segment(data_corpuszip_test, "sentences")
    metacorpus(c1, "created") <- metacorpus(c2, "created") <- NULL
    metacorpus(c1, "notes") <- metacorpus(c2, "notes")
    expect_equal(c1, c2)
})

test_that("corpus_subset works for corpus and corpuszip", {
    c1 <- corpus_subset(data_corpus_test, varfactor == "B")
    c2 <- corpus_subset(data_corpuszip_test, varfactor == "B")
    expect_equal(texts(c1), texts(c2))
    expect_equal(docvars(c1), docvars(c2))
})


test_that("dfm works for corpus and corpuszip", {
    expect_equal(dfm(data_corpus_test), dfm(data_corpuszip_test))
})

test_that("old corpus texts() and docvars() are same as new: data_corpus_inaugural", {
    expect_equal(docnames(data_corpus_test), docnames(data_corpuszip_test))
    expect_equal(docvars(data_corpus_test), docvars(data_corpuszip_test))
    expect_equal(texts(data_corpus_test), texts(data_corpuszip_test))
})

test_that("corpuszip: texts and as.character are the same", {
    expect_equal(as.character(data_corpuszip_test),
                 texts(as.character(data_corpuszip_test)))
    expect_equal(as.character(data_corpus_test),
                 texts(as.character(data_corpus_test)))
})

test_that("old corpus texts() and docvars() are same as new: data_corpus_inaugural", {
    expect_equal(docnames(data_corpus_test), docnames(data_corpuszip_test))
    expect_equal(texts(data_corpus_test), texts(data_corpuszip_test))
    expect_equal(docvars(data_corpus_test), docvars(data_corpuszip_test))
})

test_that("texts<- works with corpuszip", {
    texts(data_corpus_test)[c(2,4)] <- "REPLACEMENT TEXT."
    expect_equivalent(texts(data_corpus_test)[2], "REPLACEMENT TEXT.")
    expect_equivalent(texts(data_corpus_test)[1], "This is a sample text.\nIt has three lines.\nThe third line.")

    texts(data_corpuszip_test)[c(2,4)] <- "REPLACEMENT TEXT."
    expect_equivalent(texts(data_corpuszip_test)[2], "REPLACEMENT TEXT.")
    expect_equivalent(texts(data_corpuszip_test)[1], "This is a sample text.\nIt has three lines.\nThe third line.")
})

test_that("[[ and [ methods are the same for corpus and corpuszip", {
    expect_equal(data_corpus_test[[c("varfactor", "varchar")]],
                 data_corpuszip_test[[c("varfactor", "varchar")]])
    expect_equal(data_corpus_test[c(2,4)],
                 data_corpuszip_test[c(2,4)])

    # assignment using `[[`
    data_corpus_test[["newvar"]] <- 4:1
    data_corpuszip_test[["newvar"]] <- 4:1
    expect_equal(docvars(data_corpus_test),
                 docvars(data_corpuszip_test))

})

test_that("n* methods are the same for corpus and corpuszip", {
    expect_equal(ndoc(data_corpus_test), ndoc(data_corpuszip_test))
    expect_equal(nsentence(data_corpus_test), nsentence(data_corpuszip_test))
    expect_equal(ntoken(data_corpus_test), ntoken(data_corpuszip_test))
    expect_equal(ntype(data_corpus_test), ntype(data_corpuszip_test))
})

