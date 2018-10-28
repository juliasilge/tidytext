# Test file for function to convert abundance matrix to relative abundances
# matrix
context("Convert Absolute and Relative Abund Matrices")

# Packages ---------------------------------------------------------------------
library(Matrix)

# Common objects ---------------------------------------------------------------

# Abundance Matrix to test
abs_abund_mat = matrix(c(4, 1, 1, NA,
                         NA, rep(1, 3),
                         NA, 1, 1, NA,
                         NA, NA, 1, 1),
                       ncol = 4)

sparse_abs_abund = as(abs_abund_mat, "sparseMatrix")

# Corresponding relative abundances matrix
rel_abund_mat = matrix(c(1,  1/3, 1/4, NA,
                         NA, 1/3, 1/4, 1/2,
                         NA, 1/3, 1/4, NA,
                         NA, NA,  1/4, 1/2),
                       ncol = 4)

sparse_rel_abund = as(rel_abund_mat, "sparseMatrix")

# Corresponding presence-absence matrix
# With NA
pres_mat = abs_abund_mat

pres_mat[!is.na(abs_abund_mat)] = 1

# Without NA
pres_zero_mat = pres_mat
pres_zero_mat[is.na(pres_zero_mat)] = 0

sparse_pres = as(pres_mat, "sparseMatrix")


# Corresponding data frames
dim_names = list(sites = paste0("s", 1:4), species = letters[1:4])

dimnames(abs_abund_mat) = dim_names
dimnames(rel_abund_mat) = dim_names
dimnames(pres_zero_mat) = dim_names
dimnames(pres_mat)      = dim_names

abs_abund_df = matrix_to_tidy(abs_abund_mat)
rel_abund_df = matrix_to_tidy(rel_abund_mat)
pres_zero_df = matrix_to_tidy(pres_zero_mat)
pres_df  = matrix_to_tidy(pres_mat)

# Tests ------------------------------------------------------------------------

test_that("Can convert from absolute to relative abundances matrices", {
  # On regular matrices
  expect_equal(make_relative(abs_abund_mat), rel_abund_mat)

  # On sparse matrices
  expect_equal(make_relative(sparse_abs_abund), sparse_rel_abund)
})

test_that(paste("Test if matrix or data.frame has relative abundances or",
                "presence-absence"), {

  # Matrices
  expect_false(is_relative(abs_abund_mat))
  expect_false(is_relative(sparse_abs_abund))

  expect_true(is_relative(rel_abund_mat))
  expect_true(is_relative(sparse_rel_abund))
  expect_true(is_relative(pres_mat))
  expect_true(is_relative(pres_zero_mat))
  expect_true(is_relative(sparse_pres))

  # Data Frames
  expect_false(is_relative(abs_abund_df, "value"))

  expect_true(is_relative(rel_abund_df, "value"))
  expect_true(is_relative(pres_zero_df, "value"))
  expect_true(is_relative(pres_df, "value"))
})
