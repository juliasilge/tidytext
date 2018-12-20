context('test corpus.R')

test_that("test show.corpus", {

    testcorpus <- corpus(c('The'))
    expect_that(
        show(testcorpus),
        prints_text('Corpus consisting of 1 document.')
    )


    testcorpus <- corpus(
        c('The', 'quick', 'brown', 'fox')
    )
    expect_that(
        show(testcorpus),
        prints_text('Corpus consisting of 4 documents.')
    )

    testcorpus <- corpus(
        c('The', 'quick', 'brown', 'fox'),
        docvars=data.frame(list(test=1:4))
    )
    expect_that(
        show(testcorpus),
        prints_text('Corpus consisting of 4 documents and 1 docvar.')
    )

    testcorpus <- corpus(
        c('The', 'quick', 'brown', 'fox'),
        docvars=data.frame(list(test=1:4, test2=1:4))
    )
    expect_that(
        show(testcorpus),
        prints_text('Corpus consisting of 4 documents and 2 docvars.')
    )

})


test_that("test c.corpus", {
    concat.corpus <- c(data_corpus_inaugural, data_corpus_inaugural, data_corpus_inaugural)

    expected_docvars <-rbind(docvars(data_corpus_inaugural), docvars(data_corpus_inaugural), docvars(data_corpus_inaugural))
    rownames(expected_docvars) <- make.unique(rep(rownames(docvars(data_corpus_inaugural)), 3), sep='')

    expect_equal(
        docvars(concat.corpus),
        expected_docvars
    )

    expect_is(
        docvars(concat.corpus),
        'data.frame'
    )

    expected_texts <- c(texts(data_corpus_inaugural), texts(data_corpus_inaugural), texts(data_corpus_inaugural))
    names(expected_texts) <- make.unique(rep(names(texts(data_corpus_inaugural)), 3), sep='')
  
    expect_equal(
        texts(concat.corpus),
        expected_texts
    )

    expect_is(
        texts(concat.corpus),
        'character'
    )


    expect_true(
        grepl('Concatenation by c.corpus', metacorpus(concat.corpus)$source)
    )

})

test_that("test corpus constructors works for kwic", {
    kw <- kwic(data_char_sampletext, "econom*")
    
    # split_context = TRUE, extract_keyword = TRUE
    kwiccorpus <- corpus(kw, split_context = TRUE, extract_keyword = TRUE)
    expect_that(kwiccorpus, is_a("corpus"))
    expect_equal(names(docvars(kwiccorpus)),
                 c("docname", "from", "to", "keyword", "context"))
    
    # split_context = FALSE, extract_keyword = TRUE
    expect_identical(docvars(corpus(kwic(data_char_sampletext, "econom*"),
                                    split_context = FALSE, extract_keyword = TRUE)),
                     data.frame(keyword = rep("economy", 5), stringsAsFactors = FALSE,
                                row.names = paste0("text1.L", as.character(kw[["from"]])))
    )
    # split_context = FALSE, extract_keyword = FALSE
    expect_identical(docvars(corpus(kwic(data_char_sampletext, "econom*"),
                                    split_context = FALSE, extract_keyword = FALSE)),
                     data.frame(stringsAsFactors = FALSE,
                                row.names = paste0("text1.L", as.character(kw[["from"]])))
    )
    # split_context = TRUE, extract_keyword = FALSE
    expect_identical(docvars(corpus(kwic(data_char_sampletext, "econom*"),
                                    split_context = FALSE, extract_keyword = FALSE)),
                     data.frame(stringsAsFactors = FALSE,
                                row.names = paste0("text1.L", as.character(kw[["from"]])))
    )
    
    # test text handling for punctuation - there should be no space before the ?
    kwiccorpus <- corpus(kwic(data_char_sampletext, "econom*"),
                         split_context = FALSE, extract_keyword = FALSE)
    expect_identical(
        texts(kwiccorpus)[2],
        c(text1.L202 = "it is decimating the domestic economy? As we are tired")
    )
    
    # ; and !
    txt <- c("This is; a test!")
    expect_equivalent(
        texts(corpus(kwic(txt, "a"), split_context = FALSE)),
        txt
    )
    
    # quotes
    txt <- "This 'is' only a test!"
    expect_equivalent(
         texts(corpus(kwic(txt, "a"), split_context = FALSE)),
         txt
    )
    txt <- "This \"is\" only a test!"
    expect_equivalent(
        texts(corpus(kwic(txt, "a"), split_context = FALSE)),
        txt
    )
    txt <- 'This "is" only (a) test!'
    expect_equivalent(
        texts(corpus(kwic(txt, "a", window = 10), split_context = FALSE)),
        txt
    )
    txt <- 'This is only (a) test!'
    expect_equivalent(
        texts(corpus(kwic(txt, "a", window = 10), split_context = FALSE)),
        txt
    )    
})


test_that("test corpus constructors works for character", {

    expect_that(corpus(data_char_ukimmig2010), is_a("corpus"))

})

test_that("test corpus constructors works for data.frame", {
    
    mydf <- data.frame(letter_factor = factor(rep(letters[1:3], each = 2)),
                       some_ints = 1L:6L,
                       some_text = paste0("This is text number ", 1:6, "."),
                       some_logical = rep(c(TRUE, FALSE), 3),
                       stringsAsFactors = FALSE,
                       row.names = paste0("fromDf_", 1:6))
    mycorp <- corpus(mydf, text_field = "some_text", 
                     metacorpus = list(source = "From a data.frame called mydf."))
    expect_equal(docnames(mycorp), 
                 paste("fromDf", 1:6, sep = "_"))
    expect_equal(mycorp[["letter_factor"]][3,1],
                 factor("b", levels = c("a", "b", "c")))
    
    mydf2 <- mydf
    names(mydf2)[3] <- "text"
    expect_equal(corpus(mydf, text_field = "some_text"),
                 corpus(mydf2))
    expect_equal(corpus(mydf, text_field = "some_text"),
                 corpus(mydf, text_field = 3))
    
    expect_error(corpus(mydf, text_field = "some_ints"),
                 "text_field must refer to a character mode column")
    expect_error(corpus(mydf, text_field = c(1,3)),
                 "text_field must refer to a single column")
    expect_error(corpus(mydf, text_field = c("some_text", "letter_factor")),
                 "text_field must refer to a single column")
    expect_error(corpus(mydf, text_field = 0),
                 "text_field index refers to an invalid column")
    expect_error(corpus(mydf, text_field = -1),
                 "text_field index refers to an invalid column")
    expect_error(corpus(mydf, text_field = "notfound"),
                 "column name notfound not found")
    
    # expect_error(corpus(mydf, text_field = "some_text", docid_field = "some_ints"),
    #              "docid_field must refer to a character mode column")
    expect_error(corpus(mydf, text_field = "some_text", docid_field = c(1,3)),
                 "docid_field must refer to a single column")
    expect_error(corpus(mydf, text_field = "some_text", docid_field = c("some_text", "letter_factor")),
                 "docid_field must refer to a single column")
    expect_error(corpus(mydf, text_field = "some_text", docid_field = 0),
                 "docid_field column not found or invalid")
    expect_error(corpus(mydf, text_field = "some_text", docid_field = -1),
                 "docid_field column not found or invalid")
    expect_error(corpus(mydf, text_field = "some_text", docid_field = "notfound"),
                 "docid_field column not found or invalid")
})


test_that("test corpus constructor works for tm objects", {
    skip_if_not_installed("tm")
    require(tm)
    
    # VCorpus
    data(crude, package = "tm")    # load in a tm example VCorpus
    mytmCorpus <- corpus(crude)
    expect_equal(substring(texts(mytmCorpus)[1], 1, 21),
                 c("127"  = "Diamond Shamrock Corp"))
    
    data(acq, package = "tm")
    mytmCorpus2 <- corpus(acq)
    expect_equal(dim(docvars(mytmCorpus2)), c(50,12))
    
    # SimpleCorpus
    txt <- system.file("texts", "txt", package = "tm")
    mytmCorpus3 <- SimpleCorpus(DirSource(txt, encoding = "UTF-8"),
                                control = list(language = "lat"))
    qcorpus3 <- corpus(mytmCorpus3)
    expect_equal(content(mytmCorpus3), texts(qcorpus3))
    expect_equal(unclass(meta(mytmCorpus3, type = "corpus")[1]),
                 metacorpus(qcorpus3)[names(meta(mytmCorpus3, type = "corpus"))])
    
    # any other type
    mytmCorpus4 <- mytmCorpus3
    class(mytmCorpus4)[1] <- "OtherCorpus"
    expect_error(
        corpus(mytmCorpus4),
        "Cannot construct a corpus from this tm OtherCorpus object"
    )
    detach("package:tm", unload = TRUE)
    detach("package:NLP", unload = TRUE)
})

test_that("test corpus constructor works for VCorpus with one document (#445)", {
    skip_if_not_installed("tm")
    require(tm)
    tmCorpus_length1 <- VCorpus(VectorSource(data_corpus_inaugural[2]))
    expect_silent(qcorpus <- corpus(tmCorpus_length1))
    expect_equivalent(texts(qcorpus)[1], data_corpus_inaugural[2])
    detach("package:tm", unload = TRUE)
    detach("package:NLP", unload = TRUE)
})

test_that("test corpus constructor works for complex VCorpus (#849)", {
    skip_if_not_installed("tm")
    load("../data/corpora/complex_Corpus.rda")
    qc <- corpus(complex_Corpus)
    expect_equal(
        head(docnames(qc), 3),
        c("41113_201309.1", "41113_201309.2", "41113_201309.3")
    )
    expect_equal(
        tail(docnames(qc), 3),
        c("41223_201309.2553", "41223_201309.2554", "41223_201309.2555")
    )
    expect_output(
        print(qc),
        "Corpus consisting of 8,230 documents and 16 docvars\\."
    )
})

test_that("corpus_subset works", {
    txt <- c(doc1 = "This is a sample text.\nIt has three lines.\nThe third line.",
             doc2 = "one\ntwo\tpart two\nthree\nfour.",
             doc3 = "A single sentence.",
             doc4 = "A sentence with \"escaped quotes\".")
    dv <- data.frame(varnumeric = 10:13, varfactor = factor(c("A", "B", "A", "B")), varchar = letters[1:4])

    data_corpus_test    <- corpus(txt, docvars = dv, metacorpus = list(source = "From test-corpus.R"))
    expect_equal(ndoc(corpus_subset(data_corpus_test, varfactor == "B")), 2)
    expect_equal(docnames(corpus_subset(data_corpus_test, varfactor == "B")), c("doc2", "doc4"))
    
    data_corpus_test_nodv  <- corpus(txt, metacorpus = list(source = "From test-corpus.R"))
    expect_equal(ndoc(corpus_subset(data_corpus_test_nodv, LETTERS[1:4] == "B")), 1)
    expect_equal(docnames(corpus_subset(data_corpus_test_nodv, LETTERS[1:4] == "B")), c("doc2"))

})

test_that("corpus works for texts with duplicate filenames", {
    txt <- c(one = "Text one.", two = "text two", one = "second first text")
    cor <- corpus(txt)
    expect_equal(docnames(cor), c("one", "two", "one.1"))
})

test_that("create a corpus on a corpus", {
    expect_identical(
        data_corpus_irishbudget2010,
        corpus(data_corpus_irishbudget2010)
    )
    
    tmpcorp <- data_corpus_irishbudget2010
    docnames(tmpcorp) <- paste0("d", seq_len(ndoc(tmpcorp)))
    expect_identical(
        tmpcorp,
        corpus(data_corpus_irishbudget2010, docnames =  paste0("d", seq_len(ndoc(tmpcorp))))
    )
    
    expect_identical(
        corpus(data_corpus_irishbudget2010, compress = TRUE),
        corpus(texts(data_corpus_irishbudget2010), 
               docvars = docvars(data_corpus_irishbudget2010),
               metacorpus = metacorpus(data_corpus_irishbudget2010),
               compress = TRUE)
    )
})

test_that("head, tail.corpus work as expected", {
    crp <- corpus_subset(data_corpus_inaugural, Year < 2018)
    
    expect_equal(
        docnames(head(crp, 3)),
        c("1789-Washington", "1793-Washington", "1797-Adams")
    )
    expect_equal(
        docnames(head(crp, -55)),
        c("1789-Washington", "1793-Washington", "1797-Adams")
    )
    expect_equal(
        docnames(tail(crp, 3)),
        c("2009-Obama", "2013-Obama", "2017-Trump")
    )
    expect_equal(
        docnames(tail(crp, -55)),
        c("2009-Obama", "2013-Obama", "2017-Trump")
    )
})

test_that("internal documents fn works", {
    mydfm <- dfm(corpus_subset(data_corpus_inaugural, Year < 1800))
    expect_is(quanteda:::documents.dfm(mydfm), "data.frame")
    expect_equal(
        dim(quanteda:::documents.dfm(mydfm)),
        c(3, 3)
    )
})

test_that("corpus constructor works with tibbles", {
    skip_if_not_installed("tibble")
    dd <- tibble::data_frame(a=1:3, text=c("Hello", "quanteda", "world"))
    expect_is(
        corpus(dd),
        "corpus"
    )
    expect_equal(
        texts(corpus(dd)),
        c(text1 = "Hello", text2 = "quanteda", text3 = "world")
    )
})

test_that("corpus works on dplyr grouped data.frames (#1232)", {
    skip_if_not_installed("dplyr")
    mydf_grouped <- 
        data.frame(letter_factor = factor(rep(letters[1:3], each = 2)),
                   some_ints = 1L:6L,
                   text = paste0("This is text number ", 1:6, "."),
                   stringsAsFactors = FALSE,
                   row.names = paste0("fromDf_", 1:6)) %>%
        dplyr::group_by(letter_factor) %>% 
        dplyr::mutate(n_group = n())
    expect_output(
        print(corpus(mydf_grouped)),
        "^Corpus consisting of 6 documents and 3 docvars\\.$"
    )
})

test_that("corpus + operator works", {
    corp1 <- corpus(LETTERS[1:3], docvars = data.frame(one = 1:3, two = 4:6))
    corp2 <- corpus(LETTERS[1:3], docvars = data.frame(one = 7:9, three = 10:12))
    sm <- summary(corp1 + corp2)
    expect_identical(sm$one, c(1:3, 7:9))
    expect_identical(sm$two, c(4:6, NA, NA, NA))
    expect_identical(sm$three, c(NA, NA, NA, 10:12))
    expect_identical(
        texts(corpus(LETTERS[1:3]) + corpus(LETTERS[3:5])),
        c(text1 = "A", text2 = "B", text3 = "C", text11 = "C", text21= "D", text31 = "E")
    )
})

test_that("corpus.data.frame sets docnames correctly", {
    txt <- c("Text one.", "Text two.  Sentence two.", "Third text is here.")
    dnames <- paste(LETTERS[1:3], "dn", sep = "-")
    rnames <- paste(LETTERS[1:3], "rn", sep = "-")
    df_with_text_docid_rownames <- 
        data.frame(text = txt,  doc_id = dnames, row.names = rnames, stringsAsFactors = FALSE)
    df_with_NOtext_docid_rownames <- 
        data.frame(other = txt, doc_id = dnames, row.names = rnames, stringsAsFactors = FALSE)
    df_with_text_docid_NOrownames <- 
        data.frame(text = txt,  doc_id = dnames, row.names = NULL, stringsAsFactors = FALSE)
    df_with_NOtext_docid_NOrownames <- 
        data.frame(other = txt, doc_id = dnames, row.names = NULL, stringsAsFactors = FALSE)
    df_with_NOtext_NOdocid_NOrownames <- 
        data.frame(other = txt,                  row.names = NULL, stringsAsFactors = FALSE)
    df_with_text_NOdocid_rownames <- 
        data.frame(text = txt,                   row.names = rnames, stringsAsFactors = FALSE)
    df_with_text_NOdocid_NOrownames <- 
        data.frame(text = txt,                   row.names = NULL, stringsAsFactors = FALSE)
    df_with_NOtext_NOdocid_rownames <- 
        data.frame(other = txt,                  row.names = rnames, stringsAsFactors = FALSE)

    expect_identical(
        docnames(corpus(df_with_text_docid_rownames)),
        c("A-dn", "B-dn", "C-dn")
    )
    expect_error(
        corpus(df_with_text_docid_rownames, docid_field = "notfound"),
        "docid_field column not found or invalid"
    )
    expect_identical(
        docnames(corpus(df_with_text_NOdocid_rownames)),
        c("A-rn", "B-rn", "C-rn")
    )
    expect_identical(
        docnames(corpus(df_with_text_NOdocid_NOrownames)),
        paste0(quanteda_options("base_docname"), seq_len(nrow(df_with_text_NOdocid_NOrownames)))
    )
    
    newdf <- data.frame(df_with_text_docid_rownames, new = c(99, 100, 101))
    expect_identical(
        docnames(corpus(newdf, docid_field = "new")),
        c("99", "100", "101")
    )
    expect_identical(
        docvars(corpus(newdf, docid_field = "new")),
        data.frame(doc_id = c("A-dn", "B-dn", "C-dn"), row.names = as.character(99:101), 
                   stringsAsFactors = FALSE)
    )
    expect_identical(
        docvars(corpus(newdf)),
        data.frame(new = as.numeric(99:101), row.names = c("A-dn", "B-dn", "C-dn"), 
                   stringsAsFactors = FALSE)
    )

    newdf2 <- newdf
    names(newdf2)[2] <- "notdoc_id"
    row.names(newdf2) <- NULL
    expect_identical(
        docvars(corpus(newdf2)),
        data.frame(
            notdoc_id = c("A-dn", "B-dn", "C-dn"),
            new = c(99, 100, 101),
            row.names = paste0(quanteda_options("base_docname"), 
                               seq_len(nrow(df_with_text_NOdocid_NOrownames))),
            stringsAsFactors = FALSE
        )
    )

    newdf <- data.frame(df_with_text_NOdocid_NOrownames, new = c(99, 100, 101))
    expect_identical(
        docnames(corpus(newdf, docid_field = "new")),
        c("99", "100", "101")
    )        

    newdf <- data.frame(df_with_text_NOdocid_NOrownames, new = c(TRUE, FALSE, TRUE))
    expect_identical(
        docnames(corpus(newdf, docid_field = "new")),
        c("TRUE", "FALSE", "TRUE.1")
    )        
})

test_that("corpus handles NA correctly (#1372)", {
    expect_true(!any(
        is.na(texts(corpus(c("a b c", NA, "d e f"))))
    ))
    expect_true(!any(
        is.na(texts(corpus(data.frame(text = c("a b c", NA, "d e f"), stringsAsFactors = FALSE))))
    ))
})

test_that("correctly handle data.frame with improper column names (#1388)", {
    df <- data.frame(text = LETTERS[1:5],
                     dvar1 = 1:5,
                     dvar2 = letters[22:26],
                     dvar3 = 6:10,
                     stringsAsFactors = FALSE)
    
    # when one column name is NA
    names(df)[3] <- NA
    expect_equal(
        corpus(df) %>% docvars() %>% names(),
        c("dvar1", "V2", "dvar3")
    )
    
    # when two column names are NA
    names(df)[3:4] <- NA
    expect_equal(
        corpus(df) %>% docvars() %>% names(),
        c("dvar1", "V2", "V3")
    )
    
    # when one column name is blank
    names(df)[3:4] <- c("dv", "")
    expect_equal(
        corpus(df) %>% docvars() %>% names(),
        c("dvar1", "dv", "V3")
    )
    
    # when two column names are blank
    names(df)[3:4] <- ""
    expect_equal(
        corpus(df) %>% docvars() %>% names(),
        c("dvar1", "V2", "V3")
    )
})

test_that("handle data.frame with improper column names and text and doc_id fields", {
    df <- data.frame(thetext = LETTERS[1:5],
                     docID = paste0("txt", 1:5),
                     dvar1 = 1:5,
                     dvar2 = letters[22:26],
                     dvar3 = 6:10,
                     stringsAsFactors = FALSE)
    
    names(df)[c(3, 5)] <- c(NA, "")
    crp <- corpus(df, text_field = "thetext", docid_field = "docID")
    
    expect_equal(names(docvars(crp)), c("V1", "dvar2", "V3"))
    expect_equal(docnames(crp), paste0("txt", 1:5))
    expect_equivalent(texts(crp), LETTERS[1:5])
})

test_that("handle data.frame variable renaming when one already exists", {
    df <- data.frame(thetext = LETTERS[1:5],
                     docID = paste0("txt", 1:5),
                     x = 1:5,
                     V3 = letters[22:26],
                     x = 6:10,
                     stringsAsFactors = FALSE)
    names(df)[c(3, 5)] <- c(NA, "")
    crp <- corpus(df, text_field = "thetext", docid_field = "docID")
    expect_equal(names(docvars(crp)), c("V1", "V3", "V3.1"))
})
