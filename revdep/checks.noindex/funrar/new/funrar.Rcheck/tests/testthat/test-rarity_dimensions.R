library("dplyr")
library("Matrix")
context("Measuring Functional Rarity Dimensions")

# Common Objects ---------------------------------------------------------------
given_traits = data.frame(tr1     = 1:3,
                          tr2     = c(1, 1, 0),
                          tr3     = c(0, 0, 1))

trait_names = colnames(given_traits)

rownames(given_traits) = letters[1:3]

pres_mat = matrix(rep(NA, 9), nrow = 3, ncol = 3)
pres_mat[lower.tri(pres_mat, TRUE)] = 1
pres_mat = apply(pres_mat, 2, rev)
pres_mat[3, 3] = 1

dimnames(pres_mat) = list(sites = paste0("s", 1:3), species = letters[1:3])

sparse_mat = as(pres_mat, "sparseMatrix")

# Tests ------------------------------------------------------------------------
test_that("'uniqueness_dimensions()' outputs good objects", {
  ui_dim = uniqueness_dimensions(pres_mat, given_traits,
                                 metric = "euclidean")

  expect_s3_class(ui_dim, "data.frame")
  expect_named(ui_dim, c("species", paste0("Ui_", trait_names), "Ui_all"))
  expect_equal(dim(ui_dim), c(3, 5))
})

test_that("'distinctiveness_dimensions()' outputs good objects", {
  di_dim = distinctiveness_dimensions(pres_mat, given_traits,
                                      metric = "euclidean")

  # General check
  expect_type(di_dim, "list")
  expect_named(di_dim, c(paste0("Di_", trait_names), "Di_all"))

  # Check that all elements are matrices
  expect_true(all(vapply(di_dim, class, "char") == "matrix"))

  # Check that all elements have good dimension
  expect_true(di_dim %>%
                lapply(dim) %>%  # Get dimensions of each element
                # Is it the same as input matrix?
                lapply(function(x) all.equal(x, dim(pres_mat))) %>%
                as.logical() %>%
                all())  # Is it the case for all elements?

  ## Check that all elements are well named
  # Column Names
  expect_true(di_dim %>%
                lapply(colnames) %>%
                lapply(function(x) all.equal(x, colnames(pres_mat))) %>%
                as.logical() %>%
                all())
  # Row Names
  expect_true(di_dim %>%
                lapply(row.names) %>%
                lapply(function(x) all.equal(x, row.names(pres_mat))) %>%
                as.logical() %>%
                all())
})

test_that("'uniqueness_dimensions()' works with sparse matrices", {
  expect_warning(uniqueness_dimensions(sparse_mat, given_traits),
                 paste0("Only numeric traits provided, consider using ",
                        "euclidean distance."),
                 fixed = TRUE)

  sparse_ui_dim = uniqueness_dimensions(sparse_mat, given_traits,
                                        metric = "euclidean")

  expect_s3_class(sparse_ui_dim, "data.frame")
  expect_named(sparse_ui_dim, c("species", paste0("Ui_", trait_names),
                                    "Ui_all"))
  expect_equal(dim(sparse_ui_dim), c(3, 5))
})

test_that("'distinctiveness_dimensions()' works with sparse matrices", {
  sparse_di_dim = distinctiveness_dimensions(sparse_mat, given_traits,
                                             metric = "euclidean")

  # General checks
  expect_type(sparse_di_dim, "list")
  expect_named(sparse_di_dim, c(paste0("Di_", trait_names), "Di_all"))

  # Check that all elements are matrices
  expect_true(all(vapply(sparse_di_dim, class, "char") == "dgeMatrix"))

  # Check that all elements have good dimension
  expect_true(sparse_di_dim %>%
                lapply(dim) %>%  # Get dimensions of each element
                # Is it the same as input matrix?
                lapply(function(x) all.equal(x, dim(pres_mat))) %>%
                as.logical() %>%
                all())  # Is it the case for all elements?

  # Check that all elements are well named
  expect_true(sparse_di_dim %>%
                lapply(colnames) %>%
                lapply(function(x) all.equal(x, colnames(pres_mat))) %>%
                as.logical() %>%
                all())
  expect_true(sparse_di_dim %>%
                lapply(row.names) %>%
                lapply(function(x) all.equal(x, row.names(pres_mat))) %>%
                as.logical() %>%
                all())
})

test_that("'*_dimensions()' functions outputs the right computations", {
  simple_mat = matrix(rep(1, 4), ncol = 2)

  simple_trait = data.frame(tr1 = c(0, 1))
  rownames(simple_trait) = c("a", "b")

  dimnames(simple_mat) = list(sites = c("s1", "s2"), species = c("a", "b"))

  simple_ui_dim = uniqueness_dimensions(simple_mat, simple_trait,
                                        metric = "euclidean")
  simple_di_dim = distinctiveness_dimensions(simple_mat, simple_trait,
                                             metric = "euclidean")

  expected_ui = data.frame(species = c("a", "b"),
                           Ui_tr1  = c(1, 1),
                           Ui_all  = c(1, 1))

  expected_single_di = matrix(1, ncol = 2, nrow = 2)
  dimnames(expected_single_di) = dimnames(simple_mat)
  expected_di = list(Di_tr1 = expected_single_di, Di_all = expected_single_di)

  expect_identical(simple_ui_dim, expected_ui)
  expect_identical(simple_di_dim, expected_di)
})
