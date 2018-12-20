context("test textmodel_nb")

## Example from 13.1 of _An Introduction to Information Retrieval_
txt <- c(d1 = "Chinese Beijing Chinese",
         d2 = "Chinese Chinese Shanghai",
         d3 = "Chinese Macao",
         d4 = "Tokyo Japan Chinese",
         d5 = "Chinese Chinese Chinese Tokyo Japan")
nb_dfm <- dfm(txt, tolower = FALSE)
nb_class <- factor(c("Y", "Y", "Y", "N", NA), ordered = TRUE)

nb_multi_smooth <- 
    textmodel_nb(nb_dfm, nb_class, prior = "docfreq", distribution = "multinomial", smooth = 1)
nb_multi_nosmooth <- 
    textmodel_nb(nb_dfm, nb_class, prior = "docfreq", distribution = "multinomial", smooth = 0)
nb_bern_smooth <- 
    textmodel_nb(nb_dfm, nb_class, prior = "docfreq", distribution = "Bernoulli", smooth = 1)
nb_bern_nosmooth <- 
    textmodel_nb(nb_dfm, nb_class, prior = "docfreq", distribution = "Bernoulli", smooth = 0)

test_that("class priors are preserved in correct order", {
    expect_equal(textmodel_nb(nb_dfm, nb_class, prior = "uniform")$Pc,
                 c(N = 0.5, Y = 0.5))
    expect_equal(textmodel_nb(nb_dfm, nb_class, prior = "docfreq")$Pc,
                 c(N = 0.25, Y = 0.75))
    expect_equal(round(textmodel_nb(nb_dfm, nb_class, prior = "termfreq")$Pc, 2),
                 c(N = 0.27, Y = 0.73))
})


test_that("bernoulli diff from multinomial model (#776)", {
    expect_true(
        !identical(nb_multi_smooth$PcGw[1,], nb_bern_smooth$PcGw[1,])
    )
})

test_that("multinomial likelihoods and class posteriors are correct", {
    # test for results from p261, https://nlp.stanford.edu/IR-book/pdf/irbookonlinereading.pdf
    
    # with smoothing
    expect_identical(nb_multi_smooth$PwGc["Y", "Chinese"], 3/7)
    expect_identical(nb_multi_smooth$PwGc["Y", "Tokyo"], 1/14)
    expect_identical(nb_multi_smooth$PwGc["Y", "Japan"], 1/14)
    expect_identical(nb_multi_smooth$PwGc["N", "Chinese"], 2/9)
    expect_identical(nb_multi_smooth$PwGc["N", "Tokyo"], 2/9)
    expect_identical(nb_multi_smooth$PwGc["N", "Japan"], 2/9)
    
    # without smoothing
    expect_identical(nb_multi_nosmooth$PwGc["Y", "Chinese"], 5/8)
    expect_identical(nb_multi_nosmooth$PwGc["Y", "Tokyo"], 0/8)
    expect_identical(nb_multi_nosmooth$PwGc["Y", "Japan"], 0/8)
    expect_identical(nb_multi_nosmooth$PwGc["N", "Chinese"], 1/3)
    expect_identical(nb_multi_nosmooth$PwGc["N", "Tokyo"], 1/3)
    expect_identical(nb_multi_nosmooth$PwGc["N", "Japan"], 1/3)
})

test_that("Bernoulli likelihoods and class posteriors are correct", {
    # test for results from p261, https://nlp.stanford.edu/IR-book/pdf/irbookonlinereading.pdf
    
    # with smoothing
    expect_identical(nb_bern_smooth$PwGc["Y", "Chinese"], 4/5)
    expect_identical(nb_bern_smooth$PwGc["Y", "Japan"], 1/5)
    expect_identical(nb_bern_smooth$PwGc["Y", "Tokyo"], 1/5)
    expect_identical(nb_bern_smooth$PwGc["Y", "Beijing"], 2/5)
    expect_identical(nb_bern_smooth$PwGc["Y", "Macao"], 2/5)
    expect_identical(nb_bern_smooth$PwGc["Y", "Shanghai"], 2/5)
    expect_identical(nb_bern_smooth$PwGc["N", "Chinese"], 2/3)
    expect_identical(nb_bern_smooth$PwGc["N", "Japan"], 2/3)
    expect_identical(nb_bern_smooth$PwGc["N", "Tokyo"], 2/3)
    expect_identical(nb_bern_smooth$PwGc["N", "Beijing"], 1/3)
    expect_identical(nb_bern_smooth$PwGc["N", "Macao"], 1/3)
    expect_identical(nb_bern_smooth$PwGc["N", "Shanghai"], 1/3)
    
    # without smoothing
    expect_identical(nb_bern_nosmooth$PwGc["Y", "Chinese"], 3/3)
    expect_identical(nb_bern_nosmooth$PwGc["Y", "Japan"], 0/3)
    expect_identical(nb_bern_nosmooth$PwGc["Y", "Tokyo"], 0/3)
    expect_identical(nb_bern_nosmooth$PwGc["Y", "Beijing"], 1/3)
    expect_identical(nb_bern_nosmooth$PwGc["Y", "Macao"], 1/3)
    expect_identical(nb_bern_nosmooth$PwGc["Y", "Shanghai"], 1/3)
    expect_identical(nb_bern_nosmooth$PwGc["N", "Chinese"], 1/1)
    expect_identical(nb_bern_nosmooth$PwGc["N", "Japan"], 1/1)
    expect_identical(nb_bern_nosmooth$PwGc["N", "Tokyo"], 1/1)
    expect_identical(nb_bern_nosmooth$PwGc["N", "Beijing"], 0/1)
    expect_identical(nb_bern_nosmooth$PwGc["N", "Macao"], 0/1)
    expect_identical(nb_bern_nosmooth$PwGc["N", "Shanghai"], 0/1)
})

test_that("Bernoulli nb predicted values are correct", {
    book_lik_Y <- 3/4 * 4/5 * 1/5 * 1/5 * (1-2/5) * (1-2/5) * (1-2/5)  # 0.005184 
    book_lik_N <- 1/4 * 2/3 * 2/3 * 2/3 * (1-1/3) * (1-1/3) * (1-1/3)  # 0.02194787
    nb_bern_smooth_pred <- predict(nb_bern_smooth, nb_dfm, type = "prob")
    expect_equal( 
        book_lik_Y / (book_lik_Y + book_lik_N),
        nb_bern_smooth_pred["d5", "Y"]
    )
    expect_equal( 
        book_lik_N / (book_lik_Y + book_lik_N),
        nb_bern_smooth_pred["d5", "N"]
    )
})

test_that("Works with newdata with different features from the model (#1329 and #1322)", {
    
    mt1 <- dfm(c(text1 = "a b c", text2 = "d e f"))
    mt2 <- dfm(c(text3 = "a b c", text4 = "e f g"))
    
    nb <- textmodel_nb(mt1, factor(1:2))
    
    expect_silent(predict(nb, newdata = mt1, force = TRUE))
    expect_warning(predict(nb, newdata = mt2, force = TRUE),
                   "1 feature in newdata not used in prediction\\.")
    expect_error(predict(nb, newdata = mt2),
                 "newdata's feature set is not conformant to model terms\\.")
})

test_that("Works with features with zero probability", {
  
    mt <- as.dfm(matrix(c(0, 0, 3, 1, 4, 2), nrow = 2))
    nb <- textmodel_nb(mt, factor(1:2), smooth = 0)
    expect_silent(predict(nb))
})

test_that("types works (#1322)", {
    pr <- predict(nb_multi_smooth)
    expect_identical(names(pr), docnames(nb_multi_smooth))
    expect_is(pr, "factor")
    
    pr_prob <- predict(nb_multi_smooth, type = "probability")
    expect_identical(colnames(pr_prob), c("N", "Y"))
    expect_identical(rownames(pr_prob), c("d1", "d2", "d3", "d4", "d5"))
    expect_equal(pr_prob[1, ], c(N = .065, Y = .935), tol = .001)
    expect_is(pr_prob, "matrix")
    
    pr_lp <- predict(nb_multi_smooth, type = "logposterior")
    expect_identical(colnames(pr_lp), c("N", "Y"))
    expect_identical(rownames(pr_lp), c("d1", "d2", "d3", "d4", "d5"))
    expect_equal(pr_lp[1, ], c(N = -6.59, Y = -3.93), tol = .01)
    expect_is(pr_lp, "matrix")
})

test_that("textmodel_nb print methods work", {
    nb <- textmodel_nb(data_dfm_lbgexample, c(seq(-1.5, 1.5, .75), NA))
    expect_output(
        quanteda:::print.textmodel_nb(nb),
        "^\\nCall:\\ntextmodel_nb.dfm\\(x = data_dfm_lbgexample, y = c\\(seq\\(-1\\.5,"
    )
    
    nbs <- summary(nb)
    expect_output(
        quanteda:::print.summary.textmodel(nbs),
        "^\\nCall:\\ntextmodel_nb.dfm\\(x = data_dfm_lbgexample, y = c\\(seq\\(-1\\.5,"
    )
})

test_that("raise warning of unused dots", {
    expect_warning(predict(nb_multi_smooth, something = TRUE),
                   "\\.\\.\\. is not used")
})

