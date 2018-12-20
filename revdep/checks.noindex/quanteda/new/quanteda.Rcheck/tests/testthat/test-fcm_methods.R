context("test fcm_methods")

test_that("fcm_compress works as expected, not working for 'window' context",{
    myfcm <- fcm(tokens("A D a C E a d F e B A C E D"), 
             context = "window", window = 3)
    expect_error(fcm_compress(myfcm), 
                 "compress_fcm invalid if fcm was created with a window context")
    
})

myfcm <- fcm(tokens(c("b A A d", "C C a b B e")), context = "document")

test_that("fcm_tolower and fcm_compress work as expected",{
    lc_fcm <- fcm_tolower(myfcm)
    expect_equivalent(rownames(lc_fcm), 
                      c("b", "a", "d", "c", "e"))
    mt <- matrix(c(1, 3, 1, 2, 2, 
                     0, 1, 2, 0, 1, 
                     0, 0, 0, 0, 0, 
                     0, 0, 0, 1, 2, 
                     0, 0, 0, 0, 0),
                   nrow = 5, ncol = 5, byrow = TRUE)
    expect_true(all(as.vector(Matrix::triu(lc_fcm)) == as.vector(mt)))
    expect_equal(lc_fcm@margin, myfcm@margin)
})

test_that("fcm_toupper and fcm_compress work as expected",{
    uc_fcm <- fcm_toupper(myfcm)
    expect_equivalent(rownames(uc_fcm), 
                      c("B", "A", "D", "C", "E"))
    mt <- matrix(c(1, 3, 1, 2, 2, 
                     0, 1, 2, 0, 1, 
                     0, 0, 0, 0, 0, 
                     0, 0, 0, 1, 2, 
                     0, 0, 0, 0, 0),
                   nrow = 5, ncol = 5, byrow = TRUE)
    expect_true(all(as.vector(Matrix::triu(uc_fcm)) == as.vector(mt)))
    expect_equal(uc_fcm@margin, myfcm@margin)
})


txt <- c(doc1 = "a B c D e",
         doc2 = "a BBB c D e",
         doc3 = "Aaaa BBB cc")
testfcm <- fcm(txt, context = "document", count = "frequency", tri = TRUE)

test_that("test fcm_select, fixed", {
    expect_equal(
        featnames(fcm_select(testfcm, c("a", "b", "c"), selection = "keep", valuetype = "fixed", verbose = FALSE)),
        c("a", "B", "c")
    )
    expect_equal(
        featnames(fcm_select(testfcm, c("a", "b", "c"), selection = "remove", valuetype = "fixed", verbose = FALSE)),
        setdiff(featnames(testfcm), c("a", "B", "c"))
    )
    expect_equal(
        featnames(fcm_select(testfcm, c("a", "b", "c"), selection = "keep", valuetype = "fixed", case_insensitive = FALSE, verbose = FALSE)),
        c("a", "c")
    )
    expect_equal(
        featnames(fcm_select(testfcm, c("a", "b", "c"), selection = "remove", valuetype = "fixed", case_insensitive = FALSE, verbose = FALSE)),
        setdiff(featnames(testfcm), c("a", "c"))
    )
#     expect_equal(
#         featnames(fcm_select(testfcm, c("aaaa", "bbb", "cc"), selection = "keep", valuetype = "fixed", min_nchar = 3, verbose = FALSE)),
#         c("BBB", "Aaaa")
#     )
#     expect_equal(
#         featnames(fcm_select(testfcm, c("aaaa", "bbb", "cc"), selection = "remove", valuetype = "fixed", min_nchar = 3, verbose = FALSE)),
#         setdiff(featnames(testfcm), c("BBB", "Aaaa"))
#     )
#     expect_equal(
#         featnames(fcm_select(testfcm, c("aaaa", "bbb", "cc"), selection = "keep", valuetype = "fixed", min_nchar = 3, max_nchar = 3, verbose = FALSE)),
#         c("BBB")
#     )
#     expect_equal(
#         featnames(fcm_select(testfcm, c("aaaa", "bbb", "cc"), selection = "remove", valuetype = "fixed", min_nchar = 3, max_nchar = 3, verbose = FALSE)),
#         setdiff(featnames(testfcm), c("BBB"))
#     )
})

test_that("test fcm_select, glob", {
    feats <- c("a*", "B*", "c")
    expect_equal(
        featnames(fcm_select(testfcm, feats, selection = "keep", valuetype = "glob", verbose = FALSE)),
        c("a", "B", "c", "BBB", "Aaaa")
    )
    expect_equal(
        featnames(fcm_select(testfcm, feats, selection = "remove", valuetype = "glob", verbose = FALSE)),
        setdiff(featnames(testfcm), c("a", "B", "c", "BBB", "Aaaa"))
    )
    expect_equal(
        featnames(fcm_select(testfcm, feats, selection = "keep", valuetype = "glob", case_insensitive = FALSE, verbose = FALSE)),
        c("a", "B", "c", "BBB")
    )
    expect_equal(
        featnames(fcm_select(testfcm, feats, selection = "remove", valuetype = "glob", case_insensitive = FALSE, verbose = FALSE)),
        setdiff(featnames(testfcm), c("a", "B", "c", "BBB"))
    )
#     expect_equal(
#         featnames(fcm_select(testfcm, feats, selection = "keep", valuetype = "glob", min_nchar = 3, verbose = FALSE)),
#         c("BBB", "Aaaa")
#     )
#     expect_equal(
#         featnames(fcm_select(testfcm, feats, selection = "remove", valuetype = "glob", min_nchar = 3, verbose = FALSE)),
#         setdiff(featnames(testfcm), c("BBB", "Aaaa"))
#     )
})

test_that("test fcm_select, regex", {
    feats <- c("[A-Z].*", "c.+")
    expect_equal(
        featnames(fcm_select(testfcm, feats, selection = "keep", valuetype = "regex", verbose = FALSE)),
        c("a", "B", "c", "D", "e", "BBB", "Aaaa", "cc")
    )
    expect_equal(
        featnames(fcm_select(testfcm, feats, selection = "remove", valuetype = "regex", verbose = FALSE)),
        character(0)
    )
    expect_equal(
        featnames(fcm_select(testfcm, feats, selection = "keep", valuetype = "regex", case_insensitive = FALSE, verbose = FALSE)),
        c("B", "D", "BBB", "Aaaa", "cc")
    )
    expect_equal(
        featnames(fcm_select(testfcm, feats, selection = "remove", valuetype = "regex", case_insensitive = FALSE, verbose = FALSE)),
        setdiff(featnames(testfcm), c("B", "D", "BBB", "Aaaa", "cc"))
    )
#     expect_equal(
#         featnames(fcm_select(testfcm, feats, selection = "keep", valuetype = "regex", min_nchar = 3, verbose = FALSE)),
#         c("BBB", "Aaaa")
#     )
#     expect_equal(
#         featnames(fcm_select(testfcm, feats, selection = "remove", valuetype = "regex", min_nchar = 3, verbose = FALSE)),
#         setdiff(featnames(testfcm), c("BBB", "Aaaa"))
#     )
})

test_that("glob works if results in no features", {
    expect_true(is.fcm(fcm_select(testfcm, "notthere")))
})

test_that("featnames.NULL, docnames.NULL works as expected", {
    expect_equal(featnames(NULL), NULL)
    expect_equal(docnames(NULL), NULL)
})

test_that("selection that is out of bounds", {
    expect_equal(fcm_select(testfcm), testfcm)
    
    # some tests for docnames and featnames
    expect_equal(docnames(NULL), NULL)
    expect_equal(featnames(NULL), NULL)
})

test_that("longer selection than longer than features that exist (related to #447)", {
    testfcm <- fcm(tokens(c(d1 = 'a b', d2 = 'a b c d e')))
    feat <- c('b', 'c', 'd', 'e', 'f', 'g')
    # bugs in C++ needs repeated tests
    expect_message(fcm_select(testfcm, feat, verbose = TRUE),
                   "kept 4 features")
    expect_equivalent(
        as.matrix(fcm_select(testfcm, feat)),
        matrix(c(0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0), nrow = 4, byrow = TRUE)
    )
})

test_that("test fcm_select with features from a dfm,  fixed", {
    txt <- c("a", "b", "c")
    mx <- dfm(txt)
    expect_equal(
        featnames(fcm_select(testfcm, mx, selection = "keep", valuetype = "fixed", verbose = FALSE)),
        featnames(mx)
    )
    expect_equal(
        featnames(fcm_select(testfcm, mx, selection = "remove", valuetype = "fixed", verbose = FALSE)),
        setdiff(featnames(testfcm), featnames(mx))
    )
})

# test_that("test fcm_compress stops if features are changed only in on dimension", {
#     myfcm <- fcm(tokens(c("b A A d", "C C a b B e")), context = "document")
#     myfcm@Dimnames[[1]] <- tolower(myfcm@Dimnames[[1]])
#     expect_error(fcm_compress(myfcm))
# })

test_that("test fcm_compress retains class", {
    myfcm <- fcm(tokens(c("b A A d", "C C a b B e")), context = "document")
    colnames(myfcm) <- rownames(myfcm) <- tolower(colnames(myfcm))
    newfcm <- fcm_compress(myfcm)
    expect_equivalent(class(newfcm), "fcm")
})

test_that("shortcut functions works", {
    testfcm <- fcm(data_corpus_inaugural[1:5])
    expect_equal(fcm_select(testfcm, stopwords('english'), selection = 'keep'),
                 fcm_keep(testfcm, stopwords('english')))
    expect_equal(fcm_select(testfcm, stopwords('english'), selection = 'remove'),
                 fcm_remove(testfcm, stopwords('english')))
})
