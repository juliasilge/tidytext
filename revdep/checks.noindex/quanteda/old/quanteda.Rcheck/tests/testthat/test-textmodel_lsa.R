context('Testing textmodel-lsa.R')

test_that("textmodel-lsa (rsvd) works as expected as lsa", {
    skip_if_not_installed("lsa")
    library("lsa")
    
    foxmatrix <- c(1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1,1)
    dim(foxmatrix) <- c(3, 4)
    rownames(foxmatrix) <- paste0("D", seq(1:3))
    #{lsa}
    foxlsaMatrix <- as.textmatrix(t(foxmatrix))
    #myMatrix <- lw_logtf(foxlsaMatrix) * gw_idf(foxlsaMatrix)
    
    myLSAspace <- suppressWarnings(lsa(foxlsaMatrix, dims = 2))
    
    #quanteda
    foxdfm <- as.dfm(foxmatrix)
    qtd_lsa <- textmodel_lsa(foxdfm, nd = 2)
    
    expect_equivalent(abs(qtd_lsa$docs), abs(myLSAspace$dk))
    expect_equivalent(abs(qtd_lsa$features), abs(myLSAspace$tk))
    expect_equivalent(abs(qtd_lsa$sk), abs(myLSAspace$sk))
})

test_that("predict works as expected as lsa::fold_in()", {
    skip_if_not_installed("lsa")
    library("lsa")
    
    foxmatrix <- c(1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 1)
    dim(foxmatrix) <- c(3, 4)
    rownames(foxmatrix) <- paste0("D", seq(1:3))
    
    newfox <- matrix(c(1, 0, 1, 0, 1, 1, 0, 0), nrow = 2, ncol = 4, byrow = TRUE)
    rownames(newfox) <- paste0("D", c(4:5))
    #{lsa}
    foxlsaMatrix <- as.textmatrix(t(foxmatrix))
    myLSAspace <- suppressWarnings(lsa(foxlsaMatrix, dims = 2))
    newSpace <- t(fold_in(t(newfox), myLSAspace))
    newSpace <- newSpace[ , ]
    #quanteda
    foxdfm <- as.dfm(foxmatrix)
    qtd_lsa <- textmodel_lsa(foxdfm, nd = 2)
    new_qtd_lsa <- predict(qtd_lsa, newfox)
    
    expect_equivalent(round(abs(new_qtd_lsa$matrix_low_rank), digits = 3), round(abs(newSpace), digits = 3))

})

test_that("textmodel-lsa (rsvd) works as expected as lsa::as.textmatrix()", {
    skip_if_not_installed("lsa")
    
    foxmatrix <- c(1, 0, 1, 2, 0, 1, 1, 0, 3, 0, 1, 1)
    dim(foxmatrix) <- c(3, 4)
    rownames(foxmatrix) <- paste0("D", seq(1:3))
    #{lsa}
    foxlsaMatrix <- as.textmatrix(t(foxmatrix))
    #myMatrix <- lw_logtf(foxlsaMatrix) * gw_idf(foxlsaMatrix)
    
    myLSAspace <- lsa(foxlsaMatrix, dims = 2)
    foxlsaMatrix_lowRank <- as.textmatrix(myLSAspace)
    foxlsaMatrix_lowRank <- foxlsaMatrix_lowRank[ , ]
    #quanteda
    foxdfm <- as.dfm(foxmatrix)
    qtd_lsa <- textmodel_lsa(foxdfm, nd = 2)
    
    expect_equivalent(round(abs(qtd_lsa$matrix_low_rank), 3), round(abs(t(foxlsaMatrix_lowRank)), 3))
})

test_that("textmodel-lsa works with margin argument", {

    ie_dfm <- dfm(data_corpus_irishbudget2010)
    ie_lsa1 <- textmodel_lsa(ie_dfm, margin = 'both')
    expect_equal(dim(ie_lsa1$matrix_low_rank), dim(ie_dfm))
    expect_true(is.dfm(as.dfm(ie_lsa1)))
    
    ie_lsa2 <- textmodel_lsa(ie_dfm, margin = 'documents')
    expect_equal(dim(ie_lsa2$matrix_low_rank), c(10, nfeat(ie_dfm)))
    expect_true(is.dfm(as.dfm(ie_lsa2)))
    
    ie_lsa3 <- textmodel_lsa(ie_dfm, margin = 'features')
    expect_equal(dim(ie_lsa3$matrix_low_rank), c(ndoc(ie_dfm), 10))
    expect_true(is.dfm(as.dfm(ie_lsa3)))
})
