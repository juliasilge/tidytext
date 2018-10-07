library(dplyr)
context("Tidy Data Frame to Matrix Transformation")


# Needed objects --------------------------------------------------------------

# Valid Presence-Absence Matrix
valid_mat = matrix(c(1, 1, NA, NA,
                     NA, rep(1, 3),
                     NA, 1, 1, NA,
                     NA, NA, 1, 1),
                   ncol = 4)

colnames(valid_mat) = paste0("s", 1:4)
rownames(valid_mat) = letters[1:4]

log_mat = (valid_mat == 1 & !is.na(valid_mat))

suppressWarnings({
  com_df = lapply(colnames(log_mat), function(x) {
    species = rownames(valid_mat)[log_mat[, x]]
    data.frame(site = rep(x, length(species)), species = species)
  }) %>%
    bind_rows()
})

com_df$site = factor(com_df$site)

com_df$species = factor(com_df$species)


# Abundance Matrix
abund_mat = matrix(c(0.5, 0.5, NA, NA,
                     NA, rep(0.33, 3),
                     NA, 0.5, 0.5, NA,
                     0.25, 0.25, 0.25, 0.25),
                   ncol = 4)

dimnames(abund_mat) = list("species" = letters[1:4],
                           "site" = paste0("s", 1:4))

abund_diff = (abund_mat > 0 & !is.na(abund_mat))

suppressWarnings({
  abund_df = lapply(colnames(abund_mat), function(x) {
    values = abund_mat[abund_diff[, x], x]
    cbind(site = rep(x, length(values)), data.frame(species = names(values),
                                                    val = values))
  }) %>%
    bind_rows()
})

abund_df$species = as.factor(abund_df$species)

abund_df$site = as.factor(abund_df$site)


# Object with an NA value
na_df = abund_df
na_df[11, 3] = NA

na_mat = abund_mat
na_mat["d", "s4"] = NA

# Tests ------------------------------------------------------------------------

test_that("Conversion from tidy data.frame to matrix works", {

  expect_equivalent(stack_to_matrix(com_df, "species", "site"), valid_mat)
  expect_equivalent(stack_to_matrix(abund_df, "species", "site", "val"),
                    abund_mat)

  expect_error(stack_to_matrix(com_df, "speies", "site"),
               label = "Column 'speies' is not in data.frame")

  expect_error(stack_to_matrix(com_df, "speies", "seit"),
               label = "Columns 'speies' and 'seit' are not in data.frame")

})


test_that("Conversion from matrix to tidy data.frame works", {

  expect_equivalent(matrix_to_stack(valid_mat, row_to_col = "species",
                                   col_to_col = "site")[, -3], com_df)

  expect_equivalent(matrix_to_stack(abund_mat, value_col = "val"), abund_df)

  expect_equal(matrix_to_stack(valid_mat, row_to_col = NULL,
                              col_to_col = "site") %>%
                 colnames() %>%
                 .[2],
               "row")

  expect_equal(matrix_to_stack(valid_mat, row_to_col = "species",
                              col_to_col = NULL) %>%
                 colnames() %>%
                 .[1],
               "col")
})

test_that("Conversion from sparse & dense matrices to tidy data.frame", {
  library(Matrix)

  valid_sparse = as(valid_mat, "sparseMatrix")
  valid_dens   = as(valid_mat, "Matrix")

  abund_sparse = as(abund_mat, "sparseMatrix")
  abund_dens   = as(abund_mat, "Matrix")

  # Test for sparse matrices
  expect_equivalent(matrix_to_stack(valid_sparse, row_to_col = "species",
                                    col_to_col = "site")[, -3], com_df)

  expect_equivalent(matrix_to_stack(abund_sparse, value_col = "val"), abund_df)

  expect_equal(matrix_to_stack(valid_sparse, row_to_col = NULL,
                               col_to_col = "site") %>%
                 colnames() %>%
                 .[2],
               "row")

  expect_equal(matrix_to_stack(valid_sparse, row_to_col = "species",
                               col_to_col = NULL) %>%
                 colnames() %>%
                 .[1],
               "col")


  # Test for dense matrices
  expect_equivalent(matrix_to_stack(valid_dens, row_to_col = "species",
                                    col_to_col = "site")[, -3], com_df)

  expect_equivalent(matrix_to_stack(abund_dens, value_col = "val"), abund_df)

  expect_equal(matrix_to_stack(valid_dens, row_to_col = NULL,
                               col_to_col = "site") %>%
                 colnames() %>%
                 .[2],
               "row")

  expect_equal(matrix_to_stack(valid_dens, row_to_col = "species",
                               col_to_col = NULL) %>%
                 colnames() %>%
                 .[1],
               "col")
})

test_that("Conversion from tidy data.frame to sparse & dense matrices", {
  library(Matrix)

  ## Presence-absence matrices
  # Replace NAs with zero
  valid_zero = valid_mat
  valid_zero[is.na(valid_zero)] = 0
  # Target matrices
  valid_sparse = as(valid_zero, "sparseMatrix")
  names(dimnames(valid_sparse)) = c("species", "site")

  if (!requireNamespace("tidytext", quietly = TRUE)) {
    expect_error(stack_to_matrix(com_df, "species", "site", sparse = TRUE),
                 "The tidytext package need to be installed to get a sparse matrix")
  }

  expect_equal(stack_to_matrix(com_df, "species", "site", sparse = TRUE),
               valid_sparse)


  ## Matrices with abundances
  # Replace NAs with zero
  abund_zero = abund_mat
  abund_zero[is.na(abund_zero)] = 0
  # Target matrices
  abund_sparse = as(abund_zero, "sparseMatrix")
  names(dimnames(abund_sparse)) = c("species", "site")


  expect_equal(stack_to_matrix(abund_df, "species", "site", "val",
                               sparse = TRUE), abund_sparse)

})

test_that("Conversion works only for matrices or coercible objects",{

  valid_df = as.data.frame(valid_mat)

  expect_warning(matrix_to_stack(valid_df),
                 regexp = "Object is not a matrix. Coercing it to matrix",
                 fixed = TRUE)

  expect_error(suppressWarnings(matrix_to_stack(as.formula(mpg ~ cyl))))

})
