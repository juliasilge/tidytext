context("test dfm_compress")

test_that("dfm_compress: simple test", {
    mat <- rbind(dfm(c("b A A", "C C a b B"), tolower = FALSE, verbose = FALSE),
                 dfm("A C C C C C", tolower = FALSE, verbose = FALSE))
    colnames(mat) <- char_tolower(featnames(mat))
    expect_equal(as.matrix(dfm_compress(mat, margin = "documents")),
                 matrix(c(1,1,3,0,5,2,0,1,0,1), nrow = 2,
                        dimnames = list(docs = c("text1", "text2"), features = featnames(mat))))
    expect_equal(
        as.matrix(dfm_compress(mat, margin = "features")),
        matrix(c(1,2,0,2,1,1,0,2,5), nrow = 3,
               dimnames = list(docs = docnames(mat), features = c("b", "a", "c")))
    )
    expect_equal(
        as.matrix(dfm_compress(mat, margin = "both")),
        matrix(c(1,2,3,1,5,2), nrow = 2,
               dimnames = list(docs = c("text1", "text2"), features = c("b", "a", "c")))
    )
})


test_that("dfm_compress: no effect if no compression needed", {
    compactdfm <- dfm(data_corpus_inaugural[1:5], tolower = TRUE, verbose = FALSE)
    expect_equal(dim(compactdfm), dim(dfm_compress(compactdfm)))
})

test_that("dfm_compress: empty features are preserved", {
    testdfm <- new("dfm", Matrix::Matrix(matrix(c(0,0,0, 2,1,5, 0,1,0, 1,1,0), nrow = 3,
                                                      dimnames = list(docs = paste0("d", 1:3),
                                                                      features = c("a", "b", "c", "b"))),
                                               sparse = TRUE))
    expect_equal(colSums(dfm_compress(testdfm))[1], c(a = 0))
})

test_that("dfm_compress: empty documents are preserved", {
    testdfm <- new("dfm", Matrix::Matrix(matrix(c(0,0,0, 2,1,0, 0,1,0, 1,1,0), nrow = 3,
                                                      dimnames = list(docs = paste0("d", 1:3),
                                                                      features = c("a", "b", "c", "b"))),
                                               sparse = TRUE))
    expect_equal(rowSums(dfm_compress(testdfm))[3], c(d3 = 0))
})

#test_that("dfm_compress dfmDense: simple test", {
#    mat <- rbind(dfm(c("b A A", "C C a b B"), tolower = FALSE, verbose = FALSE),
#                 dfm("A C C C C C", tolower = FALSE, verbose = FALSE))
#    # make into a dense object
#    mat <- dfm_smooth(mat)
#    colnames(mat) <- char_tolower(featnames(mat))
#    expect_equal(as.matrix(dfm_compress(mat, margin = "documents")),
#                 matrix(c(3,2,5,1,7,3,2,2,2,2), nrow = 2,
#                        dimnames = list(docs = c("text1", "text2"), features = featnames(mat))))
#    expect_equal(
#        as.matrix(dfm_compress(mat, margin = "features")),
#        matrix(c(3,4,2,4,3,3,1,3,6), nrow = 3,
#               dimnames = list(docs = docnames(mat), features = c("b", "a", "c")))
#    )
#    expect_equal(
#        as.matrix(dfm_compress(mat, margin = "both")),
#        matrix(c(5,4,7,3,7,3), nrow = 2,
#               dimnames = list(docs = c("text1", "text2"), features = c("b", "a", "c")))
#    )
#})


