context('test plots.R')

dev.new(width = 10, height = 10)

test_that("test plot.kwic scale argument default", {

    sda <- kwic(texts(data_corpus_inaugural)[[1]], 'american')
    sdp <- kwic(texts(data_corpus_inaugural)[[1]], 'people')
    mda <- kwic(data_corpus_inaugural, 'american')
    mdp <- kwic(data_corpus_inaugural, 'people')

    # Single document, should be absolute
    p <- textplot_xray(sda)
    expect_equal(p$labels$x, 'Token index')

    # Single document, multiple keywords, should be absolute
    p <- textplot_xray(sda, sdp)
    expect_equal(p$labels$x, 'Token index')

    # Multiple documents, should be relative
    p <- textplot_xray(mda)
    expect_equal(p$labels$x, 'Relative token index')

    # Multiple documents, multiple keywords, should be relative
    p <- textplot_xray(mda, mdp)
    expect_equal(p$labels$x, 'Relative token index')

    # Explicit overrides
    p <- textplot_xray(sda, scale='absolute')
    expect_equal(p$labels$x, 'Token index')
    p <- textplot_xray(sda, sdp, scale='absolute')
    expect_equal(p$labels$x, 'Token index')
    p <- textplot_xray(mda, scale='absolute')
    expect_equal(p$labels$x, 'Token index')
    p <- textplot_xray(mda, mdp, scale='absolute')
    expect_equal(p$labels$x, 'Token index')

    p <- textplot_xray(sda, scale='relative')
    expect_equal(p$labels$x, 'Relative token index')
    p <- textplot_xray(sda, sdp, scale='relative')
    expect_equal(p$labels$x, 'Relative token index')
    p <- textplot_xray(mda, scale='relative')
    expect_equal(p$labels$x, 'Relative token index')
    p <- textplot_xray(mda, mdp, scale='relative')
    expect_equal(p$labels$x, 'Relative token index')


})


test_that("test plot.kwic facet order parameter", {

    p <- textplot_xray(kwic(data_corpus_inaugural, 'american'), sort=TRUE)
    plot_docnames <- as.character(unique(ggplot2::ggplot_build(p)$layout$panel_layout$docname))
    if(identical(plot_docnames, character(0))) {
        plot_docnames <- as.character(unique(ggplot2::ggplot_build(p)$layout$layout$docname))
    }
    expect_true(
        all(
            plot_docnames[order(plot_docnames)] == plot_docnames
        )
    )
    p <- textplot_xray(kwic(data_corpus_inaugural, 'american'), kwic(data_corpus_inaugural, 'people'), sort=TRUE)
    plot_docnames <- as.character(unique(ggplot2::ggplot_build(p)$layout$panel_layout$docname))
    if(identical(plot_docnames, character(0))) {
        plot_docnames <- as.character(unique(ggplot2::ggplot_build(p)$layout$layout$docname))
    }
    expect_true(
        all(
            plot_docnames[order(plot_docnames)] == plot_docnames
        )
    )

    # Default should be false
    p <- textplot_xray(kwic(data_corpus_inaugural[c(53:54, 1:2)], 'american'), 
                       kwic(data_corpus_inaugural[c(53:54, 1:2)], 'people'))
    plot_docnames <- as.character(unique(ggplot2::ggplot_build(p)$layout$panel_layout$docname))
    if(identical(plot_docnames, character(0))) {
        plot_docnames <- as.character(unique(ggplot2::ggplot_build(p)$layout$layout$docname))
    }
    expect_false(
        all(
            plot_docnames[order(plot_docnames)] == plot_docnames
        )
    )
    
})

test_that("test plot.kwic keeps order of keywords passed", {
    p <- textplot_xray(kwic(data_corpus_inaugural, 'people'), kwic(data_corpus_inaugural, 'american'), sort=TRUE)
    keywords <- as.character(unique(ggplot2::ggplot_build(p)$layout$panel_layout$keyword))
    if(identical(keywords, character(0))) {
        keywords <- as.character(unique(ggplot2::ggplot_build(p)$layout$layout$keyword))
    }
    
    expect_equal(
        keywords,
        c('people', 'american')
    )
})

test_that("test textplot_wordcloud works for dfm objects", {
    mt <- dfm(data_corpus_inaugural[1:5])
    mt <- dfm_trim(mt, min_termfreq = 10)
    expect_silent(textplot_wordcloud(mt))
})

test_that("test textplot_wordcloud comparison works", {
    skip_on_travis()
    skip_on_cran()
    skip_on_os('linux')
    testcorp <- corpus_reshape(corpus(data_char_sampletext))
    set.seed(1)
    docvars(testcorp, "label") <- sample(c("A", "B"), size = ndoc(testcorp), replace = TRUE)
    docnames(testcorp) <- paste0("text", 1:ndoc(testcorp))
    testdfm <- dfm(testcorp, remove = stopwords("english"))
    testdfm_grouped <- dfm(testcorp, remove = stopwords("english"), groups = "label")
    
    dev.new(width = 10, height = 10)
    expect_silent(
        textplot_wordcloud(testdfm_grouped, comparison = TRUE)
    )
    expect_silent(
        textplot_wordcloud(testdfm_grouped, random_order = FALSE)
    )
    expect_silent(
        textplot_wordcloud(testdfm_grouped, ordered_color = FALSE)
    )
    dev.off()
    expect_error(
        textplot_wordcloud(testdfm, comparison = TRUE),
        "Too many documents to plot comparison, use 8 or fewer documents\\."
    )
})

test_that("test textplot_wordcloud raise deprecation message", {
    
    mt <- dfm(data_corpus_inaugural[1:5])
    mt <- dfm_trim(mt, min_termfreq = 10)
    expect_warning(textplot_wordcloud(mt, min.freq = 10), 'min.freq is deprecated')
    expect_warning(textplot_wordcloud(mt, use.r.layout = 10), 'use.r.layout is no longer use')
})

test_that("test textplot_scale1d wordfish in the most basic way", {
    wf <- textmodel_wordfish(dfm(data_corpus_irishbudget2010), dir = c(6,5))
    expect_false(identical(textplot_scale1d(wf, sort = TRUE), 
                           textplot_scale1d(wf, sort = FALSE)))
    expect_silent(textplot_scale1d(wf, sort = TRUE, groups = docvars(data_corpus_irishbudget2010, "party")))
    expect_silent(textplot_scale1d(wf, sort = FALSE, groups = docvars(data_corpus_irishbudget2010, "party")))
    
    expect_silent(textplot_scale1d(wf, doclabels = apply(docvars(data_corpus_irishbudget2010, c("name", "party")), 
                                                          1, paste, collapse = " ")))
    
    p1 <- textplot_scale1d(wf, margin = "features", sort = TRUE)
    p2 <- textplot_scale1d(wf, margin = "features", sort = FALSE)
    p1$plot_env <- NULL
    p2$plot_env <- NULL
    expect_equivalent(p1, p2)
})

test_that("test textplot_scale1d wordscores in the most basic way", {
    mt <- dfm(data_corpus_irishbudget2010)
    ws <- textmodel_wordscores(mt, c(rep(NA, 4), -1, 1, rep(NA, 8)))
    pr <- predict(ws, mt, force = TRUE)
    expect_false(identical(textplot_scale1d(pr, sort = TRUE), 
                           textplot_scale1d(pr, sort = FALSE)))
    expect_silent(textplot_scale1d(pr, sort = TRUE, groups = docvars(data_corpus_irishbudget2010, "party")))
    expect_silent(textplot_scale1d(pr, sort = FALSE, groups = docvars(data_corpus_irishbudget2010, "party")))
    
    expect_silent(textplot_scale1d(pr, doclabels = apply(docvars(data_corpus_irishbudget2010, c("name", "party")), 
                                                         1, paste, collapse = " ")))
    
    p1 <- textplot_scale1d(ws, margin = "features", sort = TRUE)
    p2 <- textplot_scale1d(ws, margin = "features", sort = FALSE)
    p1$plot_env <- NULL
    p2$plot_env <- NULL
    expect_equivalent(p1, p2)
    
    expect_error(
        textplot_scale1d(ws, margin = "documents"),
        "This margin can only be run on a predicted wordscores object"
    )
    expect_error(
        textplot_scale1d(predict(ws), margin = "features"),
        "This margin can only be run on a fitted wordscores object"
    )
})

# test_that("test textplot_keyness ", {
#     prescorpus <- corpus_subset(data_corpus_inaugural, President %in% c("Obama", "Trump"))
#     presdfm <- dfm(prescorpus, groups = "President", remove = stopwords("english"),
#                    remove_punct = TRUE)
#     result <- textstat_keyness(presdfm, target = "Trump", measure = "chi2")
#     
#     # shows the correct statistic measure 
#     p3 <- textplot_keyness(result, show_reference = TRUE)
#     expect_equal(p3$labels$y, colnames(result)[2])
# })

test_that("test textplot_keyness: show_reference works correctly ", {
    prescorpus <- corpus_subset(data_corpus_inaugural, President %in% c("Obama", "Trump"))
    presdfm <- dfm(prescorpus, groups = "President", remove = stopwords("english"),
                   remove_punct = TRUE)
    result <- textstat_keyness(presdfm, target = "Trump")
    
    k <- 10
    p1 <- textplot_keyness(result, show_reference = FALSE, n = k)
    p2 <- textplot_keyness(result, show_reference = TRUE, n = k)
    
    # raises error when min_count is too high
    expect_error(textplot_keyness(result, show_reference = FALSE, min_count = 100),
                 'Too few words in the documents')
    # plot with two different fills when show_reference = TRUE
    expect_equal(dim(table(ggplot2::ggplot_build(p1)$data[[1]]$colour)), 1)
    expect_equal(dim(table(ggplot2::ggplot_build(p2)$data[[1]]$colour)), 2)

    # number of words plotted doubled when show_reference = TRUE
    expect_equal(nrow(ggplot2::ggplot_build(p1)$data[[1]]), k)
    expect_equal(nrow(ggplot2::ggplot_build(p2)$data[[1]]), 2 * k)

    # works with integer color 
    expect_silent(textplot_keyness(result, color = 1:2))
    
    # test that textplot_keyness works with pallette (vector > 2 colors)
    expect_silent(textplot_keyness(result, show_reference = TRUE, 
                                   color = RColorBrewer::brewer.pal(6,"Dark2")))

})

test_that("test textplot_network", {
    txt <- "A D A C E A D F E B A C E D"
    testfcm <- fcm(txt, context = "window", window = 3, tri = FALSE)
    testdfm <- dfm(txt)
    expect_silent(textplot_network(testfcm, vertex_color = 'red', offset = 0.1))
    expect_silent(textplot_network(testdfm, offset = 0.1))
    expect_error(textplot_network(testfcm, min_freq = 100), 
                 'There is no co-occurence higher than the threshold')
    
    # works with interger color
    expect_silent(textplot_network(testfcm, vertex_color = 2))
    expect_silent(textplot_network(testfcm, edge_color = 2))
})

test_that("test textplot_affinity", {
    af <- textmodel_affinity(data_dfm_lbgexample, y = c("L", NA, NA, NA, "R", NA))
    afpred <- predict(af) 
    expect_silent(textplot_influence(influence(afpred)))
    expect_silent(textplot_influence(summary(influence(afpred))))
})

test_that("test textplot_network works with vectorlized argument", {
    txt <- "A D A C E A D F E B A C E D"
    
    testfcm <- fcm(txt, context = "window", window = 3, tri = FALSE)
    expect_silent(textplot_network(testfcm, vertex_color = rep(c(1, 2), nrow(testfcm) / 2)))
    expect_silent(textplot_network(testfcm, vertex_size = rowSums(testfcm) / 5))
    expect_silent(textplot_network(testfcm, vertex_labelcolor = rep(c(1, NA), nrow(testfcm) / 2)))
})

test_that("textplot_network error when fcm is too large", {
    testdfm <- dfm(data_corpus_irishbudget2010)
    expect_error(textplot_network(testdfm, min_freq = 1, offset = 0, omit_isolated = FALSE),
                   'fcm is too large for a network plot')
})

test_that("test textplot_network font-selection", {
    txt <- "A D A C E A D F E B A C E D"
    testfcm <- fcm(txt, context = "window", window = 3, tri = FALSE)
    testdfm <- dfm(txt)
    expect_silent(textplot_network(testfcm, offset = 0.1, 
                                   vertex_labelfont = "serif"))
    expect_silent(textplot_network(testdfm, offset = 0.1, 
                                   vertex_labelfont = "sans"))
    expect_error(textplot_network(testfcm, min_freq = 0.1, 
                                  vertex_labelfont = "not_a_real_font"),
               "not_a_real_font is not found on your system")
})

dev.off()

