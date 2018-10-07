context("Test Check Functions")


# Preliminary Data -------------------------------------------------------------
pres_mat = matrix(1, nrow = 4, ncol = 3)

colnames(pres_mat) = letters[1:3]

dist_mat = matrix(0, nrow = 3, ncol = 3)
colnames(dist_mat) = letters[1:3]
rownames(dist_mat) = letters[1:3]

com_df = matrix_to_stack(pres_mat, value_col = "pres", row_to_col = "site",
                         col_to_col = "species")


# Tests ------------------------------------------------------------------------
test_that("Messages show up with wrong input", {
  library(Matrix)

  expect_silent(check_matrix(pres_mat, "site-species"))
  expect_silent(check_matrix(dist_mat, "distance"))
  expect_silent(check_matrix(as(pres_mat, "sparseMatrix"), "site-species"))
  expect_silent(check_matrix(as(dist_mat, "sparseMatrix"), "distance"))

  expect_silent(check_bigger_dist(pres_mat, dist_mat))
  expect_silent(check_bigger_pres(pres_mat, dist_mat))

  expect_silent(full_matrix_checks(pres_mat, dist_mat))
  expect_silent(full_matrix_checks(as(pres_mat, "sparseMatrix"), dist_mat))
  expect_silent(full_matrix_checks(pres_mat, as(dist_mat, "sparseMatrix")))

  # Provided objects not matrices
  expect_error(
    check_matrix(NULL, "site-species"),
    regexp = "Provided site-species matrix is not a matrix"
  )
  expect_error(
    check_matrix(rep(1, 2), "site-species"),
    regexp = "Provided site-species matrix is not a matrix"
  )
  expect_error(
    check_matrix(NULL, "distance"),
    regexp = "Provided distance matrix is not a matrix"
  )
  expect_error(
    check_matrix(rep(1, 2),"distance"),
    regexp = "Provided distance matrix is not a matrix"
  )

  # Bigger distance matrix
  expect_message(
    check_bigger_dist(pres_mat[,1:2], dist_mat),
    regexp = paste("Distance matrix bigger than site-species matrix",
                   "Taking subset of distance matrix", sep = "\n")
  )

  # Bigger site-species matrix
  expect_message(
    check_bigger_pres(pres_mat, dist_mat[1:2, 1:2]),
    regexp = "^More species in site-species matrix than in distance.*"
  )
  expect_message(
    check_bigger_pres(pres_mat, dist_mat[1:2,]),
    regexp = "^More species in site-species matrix than in distance.*"
  )
  expect_message(
    check_bigger_pres(pres_mat, dist_mat[, 1:2]),
    regexp = "^More species in site-species matrix than in distance matrix.*"
  )

})

test_that("Find Common species between matrices or between df and matrix", {
  # Between matrices
  expect_equal(get_common_species(pres_mat, dist_mat), letters[1:3])

  expect_equal(get_common_species(pres_mat[,1:2], dist_mat), letters[1:2])
  expect_equal(get_common_species(pres_mat, dist_mat[1:2, 1:2]), letters[1:2])
  expect_equal(get_common_species(pres_mat, dist_mat[1:2,]), letters[1:2])
  expect_equal(get_common_species(pres_mat, dist_mat[, 1:2]), letters[1:2])

  expect_identical(get_common_species(pres_mat[0, 0], dist_mat), character(0))
  expect_identical(get_common_species(pres_mat, dist_mat[0, 0]), character(0))

  # Between distance matrix and data.frame
  expect_equal(species_in_common_df(com_df, "species", dist_mat), letters[1:3])

  expect_equal(species_in_common_df(com_df[1:4,], "species", dist_mat), "a")
  expect_equal(species_in_common_df(com_df, "species", dist_mat[1:2,]),
               letters[1:2])
  expect_equal(species_in_common_df(com_df, "species", dist_mat[, 1:2]),
               letters[1:2])
  expect_equal(species_in_common_df(com_df, "species", dist_mat[1:2, 1:2]),
               letters[1:2])
})

test_that("No common species gives an error", {
  bad_mat = pres_mat
  colnames(bad_mat) = letters[4:6]

  expect_silent(species_in_common(pres_mat, dist_mat))
  expect_silent(species_in_common_df(com_df, "species", dist_mat))

  expect_equal(species_in_common(pres_mat, dist_mat), letters[1:3])

  expect_error(
    species_in_common(bad_mat, dist_mat),
    regexp = "No species found in common between matrices"
  )
  expect_error(
    species_in_common_df(com_df, "species", dist_mat[0, 0]),
    regexp = "No species found in common between distance matrix and data.frame"
  )
  expect_error(
    species_in_common_df(com_df[0, 0], "species", dist_mat),
    regexp = "No species found in common between distance matrix and data.frame"
  )
})

test_that("Check for _stack() and _com() functions", {
  expect_silent(check_df(com_df))
  expect_silent(check_col_in_df(com_df, "site"))
  expect_silent(check_col_in_df(com_df, "species"))
  expect_silent(check_n_sp_df(com_df, "species", dist_mat))


  # Check if input is a data.frame
  expect_error(check_df(""),
               regexp = "Provided community data.frame is not a data.frame")
  expect_error(check_df(pres_mat),
               regexp = "Provided community data.frame is not a data.frame")

  # Check if column in data.frame
  expect_error(check_col_in_df(com_df, "abund"),
               regexp = "'abund' column not in provided data.frame")

  # Check number of species between distance matrix and community data.frame
  expect_message(
    check_n_sp_df(com_df, "species", dist_mat[1:2,]),
    regexp = "^More species in community data.frame than in distance matrix.*"
  )
  expect_message(
    check_n_sp_df(com_df[1:2,], "species", dist_mat),
    regexp = paste0("More species in distance matrix than in community data",
                    ".frame\n", "Taking subset of distance matrix")
  )
})


test_that("Full checks work", {
  expect_silent(full_matrix_checks(pres_mat, dist_mat))
  expect_silent(full_df_checks(com_df, "species"))
  expect_silent(full_df_checks(com_df, "species", "site"))
  expect_silent(full_df_checks(com_df, "species", "site", "pres"))
  expect_silent(full_df_checks(com_df, "species", "site", "pres", dist_mat))
  expect_silent(full_df_checks(com_df, "species", "site",
                               dist_matrix = dist_mat))

  expect_error(full_matrix_checks("", dist_mat))
  expect_error(full_matrix_checks(pres_mat, ""))
  expect_message(full_matrix_checks(pres_mat[,1:2], dist_mat))
  expect_message(full_matrix_checks(pres_mat, dist_mat[,1:2]))

  expect_error(full_df_checks("", "species", "site", abund = NULL, dist_mat))
  expect_error(full_df_checks(com_df, "sp", "site", abund = NULL, dist_mat))
  expect_error(full_df_checks(com_df, "species", "si", abund = NULL, dist_mat))
  expect_error(full_df_checks(com_df, "species", "site", "a", dist_mat))
  expect_error(full_df_checks(com_df, "species", "site", abund = NULL, ""))
  expect_error(full_df_checks(com_df, "species", "site", "species", dist_mat))
  expect_message(full_df_checks(com_df, "species", "site",
                                dist_matrix = dist_mat[1:2,]))
  expect_message(full_df_checks(com_df[1:2,], "species", "site",
                                dist_matrix = dist_mat))
})
