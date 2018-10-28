Sys.setenv("R_TESTS" = "")

library(testthat)
library(quanteda)

Sys.setenv("_R_CHECK_LENGTH_1_CONDITION_" = TRUE)

ops <- quanteda_options()
quanteda_options(reset = TRUE)

test_check("quanteda")
quanteda_options(ops)

