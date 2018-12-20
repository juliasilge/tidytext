context("test quanteda_options")

test_that("quanteda_options initialize works correctly", {
    threads_temp <- getOption("quanteda_threads")
    quanteda_options(verbose = TRUE, threads = 1)
    quanteda_options(initialize = TRUE)
    expect_equal(quanteda_options("threads"), 1)
    expect_equal(quanteda_options("verbose"), TRUE)
    quanteda_options(threads = threads_temp)
})

test_that("quanteda_options returns an error for non-existing options", {
    expect_error(
        quanteda_options(notanoption = TRUE),
        "notanoption is not a valid quanteda option"
    )
    expect_equal(
        quanteda_options("notanoption"),
        NULL
    )
})


test_that("quanteda_options works correctly to set options", {
    quanteda_options(verbose = TRUE)
    expect_equal(
        quanteda_options("verbose"),
        getOption("quanteda_verbose")
    )
    
    quanteda_options(threads = 2)
    expect_equal(
        quanteda_options("threads"),
        getOption("quanteda_threads")
    )
    
    quanteda_options(print_dfm_max_ndoc = 13L)
    expect_equal(
        quanteda_options("print_dfm_max_ndoc"),
        getOption("quanteda_print_dfm_max_ndoc")
    )
    
    quanteda_options(print_dfm_max_nfeat = 13L)
    expect_equal(
        quanteda_options("print_dfm_max_nfeat"),
        getOption("quanteda_print_dfm_max_nfeat")
    )
})

test_that("quanteda functions work if package is not attached (#864)", {
    skip("skipping test of option setting when quanteda is not attached")
    detach("package:quanteda", unload = TRUE)
    expect_output(
        print(quanteda::dfm(c("a b c d", "a c d e f"))),
        "Document-feature matrix of: 2 documents, 6 features"
    )
    require(quanteda)
})

test_that("quanteda_options reset works correctly", {
    quanteda_options(reset = TRUE)
    opts <- quanteda:::get_options_default()
    expect_equal(
        quanteda_options(),
        opts
    )
})

test_that("quanteda_options works with threads", {
    quanteda_options(reset = TRUE)
    expect_equal(
        as.numeric(Sys.getenv('RCPP_PARALLEL_NUM_THREADS')),
        min(2L, RcppParallel::defaultNumThreads())
    )
    expect_equal(
        as.numeric(Sys.getenv('RCPP_PARALLEL_NUM_THREADS')),
        quanteda_options("threads")
    )
    quanteda_options(threads = 2)
    expect_equal(
        quanteda_options("threads"),
        as.numeric(Sys.getenv('RCPP_PARALLEL_NUM_THREADS'))
    )
})

