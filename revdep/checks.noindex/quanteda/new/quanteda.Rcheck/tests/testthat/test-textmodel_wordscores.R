context("test textmodel_wordscores")

test_that("test wordscores on LBG data", {
    ws <- textmodel_wordscores(data_dfm_lbgexample, c(seq(-1.5, 1.5, .75), NA))
    pr <- predict(ws, newdata = data_dfm_lbgexample[6, ], interval = "none")
    expect_equal(unclass(pr), c(V1 = -.45), tolerance = .01)
    
    pr2 <- predict(ws, data_dfm_lbgexample, interval = "none")
    expect_is(pr2, "numeric")
    expect_equal(names(pr2), docnames(data_dfm_lbgexample))
    expect_equal(pr2["V1"], c(V1 = -.45), tolerance = .01)
    
    pr3 <- predict(ws, data_dfm_lbgexample, se.fit = TRUE, interval = "none")
    expect_is(pr3, "list")
    expect_equal(names(pr3), c("fit", "se.fit"))
    expect_equal(pr3$se.fit[6], 0.01, tolerance = .01)
})

test_that("a warning occurs for mv with multiple ref scores", {
    ws <- textmodel_wordscores(data_dfm_lbgexample, c(seq(-1.5, 1.5, .75), NA))
    expect_warning(predict(ws, rescaling = "mv"),
                   "More than two reference scores found with MV rescaling; using only min, max values")
})

test_that("test wordscores on LBG data, MV rescaling", {
    ws <- textmodel_wordscores(data_dfm_lbgexample, c(seq(-1.5, 1.5, .75), NA))
    pr <- suppressWarnings(predict(ws, data_dfm_lbgexample, rescaling = "mv", interval = "none"))
    expect_equal(pr["V1"], c(V1 = -.51), tolerance = .001)
})

test_that("test wordscores on LBG data, LBG rescaling", {
    ws <- textmodel_wordscores(data_dfm_lbgexample, c(seq(-1.5, 1.5, .75), NA))
    pr <- predict(ws, data_dfm_lbgexample, rescaling = "lbg", interval = "none")
    expect_equal(pr["V1"], c(V1 = -.53), tolerance = .01)
})

test_that("test wordscores fitted and predicted", {
    y <- c(seq(-1.5, 1.5, .75), NA)
    ws <- textmodel_wordscores(data_dfm_lbgexample, y)
    expect_equal(ws$x, data_dfm_lbgexample)
    expect_equal(ws$y, y)
    expect_equal("textmodel_wordscores.dfm", as.character(ws$call)[1])
})

test_that("coef works for wordscores fitted", {
    ws <- textmodel_wordscores(data_dfm_lbgexample, c(seq(-1.5, 1.5, .75), NA))
    expect_equal(coef(ws), ws$wordscores)
    expect_equal(coef(ws), coefficients(ws))
})

test_that("predict.textmodel_wordscores with rescaling works with additional reference texts (#1251)", {
    refscores <- rep(NA, ndoc(data_dfm_lbgexample))
    refscores[docnames(data_dfm_lbgexample) == "R1"] <- -1
    refscores[docnames(data_dfm_lbgexample) == "R5"] <- 1

    ws1999 <- textmodel_wordscores(data_dfm_lbgexample, refscores, 
                                   scale = "linear", smooth = 1)
    expect_identical(
        unclass(predict(ws1999, rescaling = "mv"))[c("R1", "R5")],
        c(R1 = -1, R5 = 1)
    )
})

# test_that("test wordscores predict is same for virgin texts with and without ref texts", {
#     y <- c(seq(-1.5, 1.5, .75), NA)
#     ws <- textmodel_wordscores(data_dfm_lbgexample, y)
#     
#     expect_equal(
#         predict(ws)["V1"],
#         predict(ws, data_dfm_lbgexample)["V1"]
#     )
#     expect_equal(
#         suppressWarnings(predict(ws, include_reftexts = FALSE, rescaling = "mv")["V1"]),
#         suppressWarnings(predict(ws, include_reftexts = TRUE, rescaling = "mv")["V1"])
#     )
#     expect_equal(
#         suppressWarnings(predict(ws, include_reftexts = FALSE, rescaling = "lbg")["V1"]),
#         suppressWarnings(predict(ws, include_reftexts = TRUE, rescaling = "lbg")["V1"])
#     )
#     
#     expect_equal(
#         predict(ws, include_reftexts = FALSE, se.fit = TRUE)["V1"],
#         predict(ws, include_reftexts = TRUE, se.fit = TRUE)["V1"]
#     )
#     expect_equal(
#         predict(ws, include_reftexts = FALSE, interval = "confidence", se.fit = TRUE)$fit["V1", , drop = FALSE],
#         predict(ws, include_reftexts = TRUE, interval = "confidence", se.fit = TRUE)$fit["V1", , drop = FALSE]
#     )
#     expect_equal(
#         predict(ws, include_reftexts = FALSE, interval = "confidence", 
#                 se.fit = TRUE)$se.fit,
#         predict(ws, include_reftexts = TRUE, interval = "confidence", 
#                 se.fit = TRUE)$se.fit[which(docnames(ws) == "V1")]
#     )
#     expect_equal(
#         predict(ws, include_reftexts = FALSE, interval = "confidence", 
#                 rescaling = "lbg", se.fit = TRUE)$se.fit,
#         predict(ws, include_reftexts = TRUE, interval = "confidence", 
#                 rescaling = "lbg", se.fit = TRUE)$se.fit[which(docnames(ws) == "V1")]
#     )
# })


# test_that("coef works for wordscores predicted, rescaling = none", {
#     ws <- textmodel_wordscores(data_dfm_lbgexample, c(seq(-1.5, 1.5, .75), NA))
#     pr <- predict(ws, rescaling = "none")
#     expect_equal(coef(pr)$coef_feature, ws@Sw)
#     expect_true(is.null(coef(ws)$coef_feature_se))
#     expect_equal(coef(pr)$coef_document, pr@textscores$textscore_raw)
#     expect_equal(coef(pr)$coef_document_se, pr@textscores$textscore_raw_se)
# })

# test_that("coef works for wordscores predicted, rescaling = mv", {
#     pr <- suppressWarnings(
#         predict(textmodel_wordscores(data_dfm_lbgexample, 
#                                      c(seq(-1.5, 1.5, .75), NA)), 
#                 rescaling = "mv")
#     )
#     expect_equal(coef(pr)$coef_document, pr@textscores$textscore_mv)
#     expect_equal(
#         coef(pr)$coef_document_se, 
#         (pr@textscores$textscore_mv - pr@textscores$textscore_mv_lo) / 1.96,
#         tolerance = .001
#     )
# })

# test_that("coef works for wordscores predicted, rescaling = lbg", {
#     pr <- predict(textmodel_wordscores(data_dfm_lbgexample, c(seq(-1.5, 1.5, .75), NA)), 
#                   rescaling = "lbg")
#     expect_equal(coef(pr)$coef_document, pr@textscores$textscore_lbg)
#     expect_equal(
#         coef(pr)$coef_document_se, 
#         (pr@textscores$textscore_lbg - pr@textscores$textscore_lbg_lo) / 1.96,
#         tolerance = .001
#     )
# })



test_that("coef and coefficients are the same", {
    ws <- textmodel_wordscores(data_dfm_lbgexample, c(seq(-1.5, 1.5, .75), NA))
    pr <- predict(ws, interval = "none")
    expect_equal(coef(ws), coefficients(ws))
    # expect_equal(coef(pr), coefficients(pr))
})

test_that("confidence intervals all work", {
    ws <- textmodel_wordscores(data_dfm_lbgexample, c(seq(-1.5, 1.5, .75), NA))
    
    pr <- predict(ws, se.fit = TRUE, interval = "confidence", rescaling = "none")
    expect_equal(names(pr), c("fit", "se.fit"))
    expect_equal(colnames(pr$fit), c("fit", "lwr", "upr"))
    expect_is(pr$fit, "matrix")
    
    pr_lbg <- predict(ws, se.fit = TRUE, interval = "confidence", rescaling = "lbg")
    expect_equal(names(pr_lbg), c("fit", "se.fit"))
    expect_equal(colnames(pr_lbg$fit), c("fit", "lwr", "upr"))
    expect_is(pr_lbg$fit, "matrix")
    
    pr_mv <- suppressWarnings(
        predict(ws, se.fit = TRUE, interval = "confidence", rescaling = "mv")
    )
    expect_equal(names(pr_mv), c("fit", "se.fit"))
    expect_equal(colnames(pr_mv$fit), c("fit", "lwr", "upr"))
    expect_is(pr_mv$fit, "matrix")
    expect_equal(pr_mv$fit[c(1, 5), "fit"], c(R1 = -1.5, R5 = 1.5))
})

test_that("textmodel_wordscores print methods work", {
    ws <- textmodel_wordscores(data_dfm_lbgexample, c(seq(-1.5, 1.5, .75), NA))
    expect_output(
        quanteda:::print.textmodel_wordscores(ws),
        "^\\nCall:\\ntextmodel_wordscores\\.dfm\\(.*Scale: linear;.*37 scored features\\.$"
    )
    
    sws <- summary(ws)
    expect_output(
        quanteda:::print.summary.textmodel(sws),
        "^\\nCall:\\ntextmodel_wordscores\\.dfm\\(.*Reference Document Statistics:.*Wordscores:\\n"
    )
})

test_that("additional quanteda methods", {
    ws <- textmodel_wordscores(data_dfm_lbgexample, c(-1.5, NA, NA, NA, .75, NA))
    expect_equal(ndoc(ws), 6)
    expect_equal(nfeat(ws), 37)
    expect_equal(docnames(ws), docnames(data_dfm_lbgexample))
    expect_equal(featnames(ws), 
                 featnames(data_dfm_lbgexample))
})

test_that("Works with newdata with different features from the model (#1329)", {
    
    mt1 <- dfm(c(text1 = "a b c", text2 = "d e f"))
    mt2 <- dfm(c(text3 = "a b c", text4 = "e f g"))
    
    ws <- textmodel_wordscores(mt1, 1:2)
    expect_silent(predict(ws, newdata = mt1, force = TRUE))
    expect_warning(predict(ws, newdata = mt2, force = TRUE),
                  "1 feature in newdata not used in prediction\\.")
    expect_error(predict(ws, newdata = mt2, force = FALSE),
                 "newdata's feature set is not conformant to model terms\\.")

})

test_that("raise warning of unused dots", {
    ws <- textmodel_wordscores(data_dfm_lbgexample, c(seq(-1.5, 1.5, .75), NA))
    expect_warning(predict(ws, something = TRUE),
                   "\\.\\.\\. is not used")
})

test_that("textmodel_wordscores does not use NA wordscores scores", {
    thedfm <- data_dfm_lbgexample[, c("A", "B", "S", "ZJ", "ZK")]
    thedfm["V1", "ZJ"] <- 1
    thedfm <- as.dfm(thedfm)
    ws <- textmodel_wordscores(thedfm, c(-1, NA, NA, NA, 1, NA))
    
    expect_identical(ws$wordscores, c(A = -1, B = -1, ZJ = 1, ZK = 1))
    pws <- suppressWarnings(predict(ws))
    class(pws) <- class(pws)[-1]
    expect_identical(
        pws, 
        c(R1 = -1, R2 = 0, R3 = 0, R4 = 0, R5 = 1, V1 = 1)
    )
    expect_warning(
        predict(ws),
        "1 feature in newdata not used in prediction\\."
    )
})