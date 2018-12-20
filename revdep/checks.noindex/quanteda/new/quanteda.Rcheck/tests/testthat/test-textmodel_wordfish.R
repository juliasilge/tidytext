context('Testing textmodel-wordfish.R')

ie2010dfm <- dfm(data_corpus_irishbudget2010)
wfm <- textmodel_wordfish(ie2010dfm, dir = c(6,5), sparse = TRUE)
wfm_d <- textmodel_wordfish(ie2010dfm, dir = c(6,5), sparse = FALSE)
wfs <- summary(wfm)
wfp <- predict(wfm)

test_that("textmodel-wordfish (sparse) works as expected as austin::wordfish", {
    skip_if_not_installed("austin")
    wfmodelAustin <- austin::wordfish(quanteda::as.wfm(ie2010dfm), dir = c(6,5))
    cc <- cor(wfm$theta, wfmodelAustin$theta)
    expect_gt(cc, 0.99)
    
    # dense methods
    cc <- cor(wfm_d$theta, wfmodelAustin$theta)
    expect_gt(cc, 0.99)
})

test_that("textmodel-wordfish works as expected: dense vs sparse vs sparse+mt", {
    cc <- cor(wfm_d$theta, wfm$theta)
    expect_gt(cc, 0.99)
})

test_that("print/show/summary method works as expected", {
    expect_output(
        print(wfm), 
        "^\\nCall:\\ntextmodel_wordfish\\.dfm\\(.*Dispersion.*14 documents; 5140 features\\.$"
    )
    expect_output(
        quanteda:::print.summary.textmodel(wfs),
        "^\\nCall:\\ntextmodel_wordfish\\.dfm\\("
    )
    expect_output(
        quanteda:::print.summary.textmodel(wfs),
        "Estimated Document Positions:"
    )
    expect_output(
        quanteda:::print.summary.textmodel(wfs),
        "Estimated Feature Scores:"        
    )
})

test_that("coef works for wordfish fitted", {
    expect_equivalent(coef(wfm, margin = "features")[, "beta"], wfm$beta, tolerance = 1e-8)
    expect_equivalent(coef(wfm, margin = "features")[, "psi"], wfm$psi, tolerance = 1e-8)
    expect_equivalent(coef(wfm, margin = "documents")[, "alpha"], wfm$alpha, tolerance = 1e-8)
    expect_equivalent(coef(wfm, margin = "documents")[, "theta"], wfm$theta, tolerance = 1e-8)
    expect_is(coef(wfm, margin = "both"), "list")
    expect_equal(length(coef(wfm, margin = "both")), 2)
    expect_equal(names(coef(wfm, margin = "both")), c("documents", "features"))

    # "for wordfish, coef and coefficients are the same", {
    expect_equal(coef(wfm), coefficients(wfm))
})

test_that("textmodel-wordfish works for quasipoisson - feature as expected: dense vs sparse vs sparse+mt", {
    #ie2010dfm <- dfm(data_corpus_irishbudget2010, verbose = FALSE)
    wfm_d <- textmodel_wordfish(ie2010dfm, dir = c(6,5), sparse = FALSE,
                                dispersion = "quasipoisson", dispersion_floor = 0)
    wfm <- textmodel_wordfish(ie2010dfm, dir = c(6,5), sparse = TRUE,
                                 dispersion = "quasipoisson", dispersion_floor = 0)
    expect_equal(
        cor(wfm_d$theta, wfm$theta),
        0.99,
        tolerance = .005
    )
})

test_that("textmodel-wordfish works for quasipoisson - overall as expected: dense vs sparse vs sparse+mt", {
    wfm_d <- textmodel_wordfish(ie2010dfm, dir = c(6,5), sparse = FALSE,
                                dispersion = "quasipoisson", dispersion_level = "overall")
    wfm <- textmodel_wordfish(ie2010dfm, dir = c(6,5), 
                                 dispersion = "quasipoisson", dispersion_level = "overall")
    cc<-cor(wfm_d$theta, wfm$theta)
    expect_gt(cc, 0.99)
})

test_that("textmodel-wordfish (sparse) works as expected on another dataset", {
    usdfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1900), verbose = FALSE)
    
    wfm_s <- textmodel_wordfish(usdfm, dir = c(6,5), sparse = TRUE, svd_sparse = TRUE, residual_floor = 0.5)
    wfm_d <- textmodel_wordfish(usdfm, dir = c(6,5), sparse = FALSE)
    cc <- cor(wfm_d$theta, wfm_s$theta)
    expect_gt(cc, 0.99)
    
    # with different sparsity of residual matrix
    wfm_s <- textmodel_wordfish(usdfm, dir = c(6,5), sparse = TRUE, svd_sparse = TRUE, residual_floor = 1)
    cc <- cor(wfm_d$theta, wfm_s$theta)
    expect_gt(cc, 0.99)
    
    wfm_s <- textmodel_wordfish(usdfm, dir = c(6,5), sparse = TRUE, svd_sparse = TRUE, residual_floor = 2)
    cc <- cor(wfm_d$theta, wfm_s$theta)
    expect_gt(cc, 0.99)
})

test_that("test wordfish predict methods", {
    pr <- predict(wfm)
    expect_equal(pr[1], c('2010_BUDGET_01_Brian_Lenihan_FF' = 1.82), tolerance = .01)
    
    pr2 <- predict(wfm, se.fit = TRUE)
    expect_is(pr2, "list")
    expect_equal(names(pr2), c("fit", "se.fit"))
    expect_equal(pr2$se.fit[1], 0.019, tolerance = .01)
    
    pr3 <- predict(wfm, se.fit = TRUE, interval = "confidence")
    expect_equal(names(pr3), c("fit", "se.fit"))
})


