context('Testing textmodel-ca.R')

ie2010dfm <- dfm(data_corpus_irishbudget2010)

test_that("textmodel-ca (rsvd) works as expected as ca::ca", {
    skip_if_not_installed("ca")
    wca <- ca::ca(as.matrix(ie2010dfm))
    wtca <- textmodel_ca(ie2010dfm)
    expect_equal(wca$rowdist, wtca$rowdist, tolerance = 1e-6)
    expect_equal(wca$coldist, wtca$coldist, tolerance = 1e-6)
    
    expect_equal(abs(wca$rowcoord[,1]), abs(wtca$rowcoord[,1]), tolerance = 1e-6)
    expect_equal(abs(wca$colcoord[,1]), abs(wtca$colcoord[,1]), tolerance = 1e-6)
    
    expect_equal(abs(wca$rowcoord[,2]), abs(wtca$rowcoord[,2]), tolerance = 1e-6)
    expect_equal(abs(wca$colcoord[,2]), abs(wtca$colcoord[,2]), tolerance = 1e-6)
    
    expect_equal(wca$rowinertia, wtca$rowinertia, tolerance = 1e-6)
    expect_equal(wca$colinertia, wtca$colinertia, tolerance = 1e-6)
    
    expect_equal(wca$sv[seq_along(wtca$sv)], wtca$sv, tolerance = 1e-6)
})

test_that("textmodel-ca works as expected as ca::ca : use mt", {
    skip_if_not_installed("ca")
    wca <- ca::ca(as.matrix(ie2010dfm))
    wtca <- textmodel_ca(ie2010dfm, sparse = TRUE)
    
    expect_gt(cor(wca$rowdist, wtca$rowdist), 0.99)
    expect_gt(cor(wca$coldist, wtca$coldist), 0.99)
    
    expect_gt(cor(abs(wca$rowcoord[,1]), abs(wtca$rowcoord[,1])), 0.99)
    expect_gt(cor(abs(wca$colcoord[,1]), abs(wtca$colcoord[,1])), 0.99)
    
    expect_gt(cor(abs(wca$rowcoord[,2]), abs(wtca$rowcoord[,2])), 0.99)
    expect_gt(cor(abs(wca$colcoord[,2]), abs(wtca$colcoord[,2])), 0.99)
    
    expect_gt(cor(wca$rowinertia, wtca$rowinertia), 0.99)
    expect_gt(cor(wca$colinertia, wtca$colinertia), 0.99)
    
    cc <- cor(wca$sv[seq_along(wtca$sv)], wtca$sv)
    expect_gt(cc, 0.99)
})

test_that("textmodel-ca works as expected as ca::ca: for given number of dimension", {
    skip_if_not_installed("ca")
    wca <- ca::ca(as.matrix(ie2010dfm))
    wtca <- textmodel_ca(ie2010dfm, nd = 10)
    expect_equal(wca$rowdist, wtca$rowdist, tolerance = 1e-6)
    expect_equal(wca$coldist, wtca$coldist, tolerance = 1e-6)
    
    expect_equal(abs(wca$rowcoord[,1]), abs(wtca$rowcoord[,1]), tolerance = 1e-6)
    expect_equal(abs(wca$colcoord[,1]), abs(wtca$colcoord[,1]), tolerance = 1e-6)
    
    expect_equal(abs(wca$rowcoord[,2]), abs(wtca$rowcoord[,2]), tolerance = 1e-6)
    expect_equal(abs(wca$colcoord[,2]), abs(wtca$colcoord[,2]), tolerance = 1e-6)
    
    expect_equal(wca$rowinertia, wtca$rowinertia, tolerance = 1e-6)
    expect_equal(wca$colinertia, wtca$colinertia, tolerance = 1e-6)
    
    expect_equal(wca$sv[seq_along(wtca$sv)], wtca$sv, tolerance = 1e-6)
})

test_that("textmodel-ca(sparse) works as expected on another dataset", {
    usdfm <- dfm(data_corpus_inaugural, verbose = FALSE)
    skip_if_not_installed("ca")
    wca <- ca::ca(as.matrix(usdfm))
    wtca <- textmodel_ca(usdfm, sparse = TRUE)
    
    expect_gt(cor(wca$rowdist, wtca$rowdist), 0.99)
    expect_gt(cor(wca$coldist, wtca$coldist), 0.99)
    
    expect_gt(cor(abs(wca$rowcoord[,1]), abs(wtca$rowcoord[,1])), 0.99)
    expect_gt(cor(abs(wca$colcoord[,1]), abs(wtca$colcoord[,1])), 0.99)
    
    expect_gt(cor(abs(wca$rowcoord[,2]), abs(wtca$rowcoord[,2])), 0.99)
    expect_gt(cor(abs(wca$colcoord[,2]), abs(wtca$colcoord[,2])), 0.99)
    
    expect_gt(cor(wca$rowinertia, wtca$rowinertia), 0.99)
    expect_gt(cor(wca$colinertia, wtca$colinertia), 0.99)
    
    cc <- cor(wca$sv[seq_along(wtca$sv)], wtca$sv)
    expect_gt(cc, 0.99)
})


test_that("ca coefficients methods work", {
    camodel <- textmodel_ca(data_dfm_lbgexample)
    expect_equal(coef(camodel), coefficients(camodel))
    expect_equal(
        coef(camodel, doc_dim = 2)$coef_document,
        camodel$rowcoord[, 2]
    )
})

test_that("ca textplot_scale1d method works", {
    camodel <- textmodel_ca(data_dfm_lbgexample)
    textplot_scale1d(camodel, margin = "document")
    expect_error(
        textplot_scale1d(camodel, margin = "features"),
        "textplot_scale1d for features not implemented for CA models"
    )
})

