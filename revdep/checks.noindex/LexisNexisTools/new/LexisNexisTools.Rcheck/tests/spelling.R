if (requireNamespace("spelling", quietly = TRUE))
  spelling::spell_check_test(vignettes = TRUE, error = TRUE, skip_on_cran = TRUE)
