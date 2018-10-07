library(dplyr)
context("Functional Rarity Indices")


# General data -----------------------------------------------------------------

# Empty Matrix
empty_mat = matrix(rep(0, 4), ncol = 2)
rownames(empty_mat) = paste0("s", 1:2)
colnames(empty_mat) = letters[1:2]

# Valid Presence-Absence Matrix
valid_mat = matrix(c(1, 0, 0, 0,
                     rep(1, 3), 0,
                     0, rep(1, 3),
                     0, 1, 0, 1),
                   ncol = 4)

dimnames(valid_mat) = list("site" = paste0("s", 1:4), "species" = letters[1:4])

# Community Table
log_mat = (valid_mat == 1)

suppressWarnings({
  com_df = lapply(rownames(log_mat), function(x) {
    species = colnames(valid_mat)[log_mat[x, ]]
    data.frame(site = rep(x, length(species)), species = species)
  }) %>%
    bind_rows()
})


# Traits df
trait_df = data.frame(tr1 = c("A", "A", "B", "B"), tr2 = c(rep(0, 3), 1),
                       tr3 = seq(4, 16, 4))

rownames(trait_df) = letters[1:4]

# Distance Matrix
dist_mat = compute_dist_matrix(trait_df)


# Distinctiveness data --------------------------------------------------------

# Final distinctiveness table for all communities
correct_dist = structure(list(site = c("s1", "s1", "s2", "s2", "s2", "s3",
                                       "s3", "s4", "s4"),
                              species = c("a", "b", "b", "c", "d","b", "c",
                                          "c", "d"),
                              Di = c(1/9, 1/9, 6/9, 4/9, 6/9, 4/9, 4/9, 4/9,
                                     4/9)),
                         .Names = c("site", "species", "Di"),
                         row.names = c(NA, -9L), class = c("tbl_df", "tbl",
                                                           "data.frame")) %>%
  # Forced to arrange by species to specify for distinctiveness matrix
  arrange(species)

correct_dist_mat = table(correct_dist$site, correct_dist$species)

correct_dist_mat[which(correct_dist_mat == 0)] = NA_real_

correct_dist_mat[which(correct_dist_mat == 1)] = correct_dist$Di

# Distinctiveness with abundances
correct_dist_ab = correct_dist


# Undefined Distinctiveness
small_mat = matrix(c(1, 0, 0, 1), nrow = 2)
colnames(small_mat) = letters[1:2]
rownames(small_mat) = c("s1", "s2")

undef_dist = data_frame(site = c("s1", "s2"), species = c("a", "b"),
                        Di = rep(NaN, 2))

undef_dist_mat = table(undef_dist$site, undef_dist$species)

undef_dist_mat[which(undef_dist_mat == 0)] = NA_real_

undef_dist_mat[which(undef_dist_mat == 1)] = undef_dist$Di

suppressWarnings({
  suppressMessages({
    undef_test = distinctiveness(small_mat, dist_mat)
  })
})


# Scarcity data ----------------------------------------------------------------
com_df_ex = bind_cols(com_df, data.frame(abund = c(0.3, 0.7, 0.2, 0.6,
                                                         0.2, 0.5, 0.5, 0.2,
                                                         0.8)))
abund_mat = valid_mat
abund_mat[abund_mat == 1] = com_df_ex %>%
  arrange(species) %>%
  .$abund

scarcity_mat = apply(abund_mat, 1, function(x) {
  ifelse(x != 0, exp(-sum(x != 0)*log(2)*x), NA)
}) %>% t()

com_scarcity = com_df_ex %>%
  group_by(site) %>%
  summarise(N_sp = n()) %>%
  right_join(com_df_ex, by = "site") %>%
  mutate(Si = exp(-N_sp*log(2)*abund)) %>%
  select(-N_sp)

abund_com = abund_mat %>%
  matrix_to_stack(value_col = "abund", row_to_col = "site",
                  col_to_col = "species") %>%
  filter(abund > 0, site == "s3")
abund_com$Di = c(4/9, 4/9)



# Test for Distinctiveness ----------------------------------------------------

test_that("Invalid input types do not work", {

  expect_error(distinctiveness_com("a", "species", NULL, "d"))
  expect_error(distinctiveness_com(3, "species", NULL, "d"))

})


test_that("Correct Di computation with different comm. without abundance",{

  # Good messages and warnings
  expect_message(distinctiveness_stack(com_df, "species", "site",
                                       abund = NULL, dist_mat))

  expect_message(distinctiveness(valid_mat[-1, -1], dist_mat))

  expect_message(distinctiveness(valid_mat[2:3, 1:4], dist_mat[-1, -1]))

  # Conservation of dimensions names of indices matrix
  expect_identical(dimnames(distinctiveness(valid_mat, dist_mat)),
                   dimnames(valid_mat))

  # Good Distinctiveness computations without abundances
  c_dist = distinctiveness_stack(com_df, "species", "site", abund = NULL,
                                 dist_mat)

  expect_equivalent(correct_dist_mat,
                    as.table(distinctiveness(valid_mat, dist_mat)))

  expect_equivalent(as.data.frame(c_dist), as.data.frame(correct_dist) %>%
                      arrange(site))

  # Undefined distinctiveness for species alone in communities
  expect_equal(distinctiveness_com(com_df[1,], "species",
                                   dist_matrix = dist_mat)[1,3], NaN)


  # Distinctiveness with abundances
  expect_equal(distinctiveness_com(abund_com[, -4], "species", "abund",
                                        dist_mat), abund_com)

})


test_that("Di is undefined for a community with a single species", {



  expect_equivalent(t(undef_dist_mat), as.table(undef_test))

  # Check warning for NaN created in the matrix
  expect_warning(distinctiveness(small_mat, dist_mat))
})


test_that("Distinctiveness works with sparse matrices", {
  library(Matrix)
  sparse_mat = as(valid_mat, "sparseMatrix")

  dist_sparse_mat = as(correct_dist_mat, "sparseMatrix") %>%
    as("dgeMatrix")

  expect_silent(distinctiveness(sparse_mat, dist_mat))

  expect_equivalent(distinctiveness(sparse_mat, dist_mat), dist_sparse_mat)
})

# Test for Uniqueness ---------------------------------------------------------

test_that("Correct Uniqueness computation", {

  valid_ui = data.frame(species = c("a", "b"), Ui = c(1/9, 1/9))

  all_ui = data.frame(species = letters[1:4],
                      Ui = c(1/9, 1/9, 4/9, 4/9))

  expect_equivalent(uniqueness_stack(com_df[1:2, ], "species", dist_mat),
                    valid_ui)

  expect_error(uniqueness_stack(com_df[1:2, ], "NOT_IN_TABLE", dist_mat),
    regexp = "'NOT_IN_TABLE' column not in provided data.frame")

  expect_message(
    uniqueness_stack(com_df, "species", dist_mat[1:2,]),
    regexp = "^More species in community data.frame than in distance matrix.*"
  )

  expect_equivalent(uniqueness_stack(com_df, "species", dist_mat), all_ui)

  expect_equal(uniqueness(valid_mat, dist_mat), all_ui)
})



# Test for Scarcity ------------------------------------------------------------

test_that("Correct Scarcity computation", {

  # Single community scarcity correct computation
  expect_equal(filter(com_scarcity, site == "s1"),
               scarcity_com(com_df_ex %>%
                                 filter(site == "s1") %>%
                                 as.data.frame(),
                               "species", "abund"))

  # Scarcity correct computation over many communities
  expect_equal(com_scarcity, scarcity_stack(as.data.frame(com_df_ex),
                                            "species", "site", "abund"))

  # Correct Sparseness computation for a site-species matrix
  expect_equal(scarcity_mat, scarcity(abund_mat))
})


test_that("Scarcity errors with bad input", {
  expect_error(scarcity_stack(as.data.frame(com_df_ex),
                              "species", "SITE_NOT_IN_TABLE", "abund"),
               regexp = "'SITE_NOT_IN_TABLE' column not in provided data.frame")

  expect_error(scarcity_stack(as.data.frame(com_df_ex),
                              "SPECIES_NOT_IN_TABLE", "site", "abund"),
               regexp = paste0("'SPECIES_NOT_IN_TABLE' column not in ",
                               "provided data.frame"))

  expect_error(scarcity_stack(as.data.frame(com_df_ex), "species", "site",
                              NULL),
               regexp = "No relative abundance provided")

  com_df_ab = com_df_ex

  com_df_ab$abund = as.character(com_df_ex$abund)

  expect_error(scarcity_stack(as.data.frame(com_df_ab), "species", "site",
                              "abund"),
               regexp = "Provided abundances are not numeric")
})


# Tests for Restrictedness -----------------------------------------------------

test_that("Restrictedness computations work", {
  expect_equal(restrictedness_stack(com_df, "species", "site"),
               data.frame("species" = letters[1:4],
                          "Ri" = c(3/4, 1/4, 1/4, 1/2)))

  expect_equal(restrictedness(valid_mat),
               data.frame("species" = letters[1:4],
                          "Ri" = c(3/4, 1/4, 1/4, 1/2)))
})

test_that("Restrictedness works with sparse matrices", {
  library(Matrix)
  sparse_mat = as(valid_mat, "sparseMatrix")

  expect_silent(restrictedness(sparse_mat))

  expect_equivalent(restrictedness(sparse_mat),
                    data.frame("species" = letters[1:4],
                               "Ri" = c(3/4, 1/4, 1/4, 1/2)))
})

# Tests for Combined function --------------------------------------------------

test_that("Funrar runs smoothly", {
  expect_silent(funrar(valid_mat, dist_mat))
  expect_silent(funrar_stack(com_df_ex, "species", "site", "abund", dist_mat))

  expect_equal(length(funrar(valid_mat, dist_mat)), 3)
  expect_equal(length(funrar(abund_mat, dist_mat, rel_abund = TRUE)), 4)

  expect_equal(length(funrar_stack(com_df, "species", "site",
                                   dist_matrix = dist_mat)), 3)
  expect_equal(length(funrar_stack(com_df_ex, "species", "site", "abund",
                                   dist_mat)), 4)
})

test_that("funrar functions warns if object does not have relative abundances",
          {
            abs_mat = valid_mat
            abs_mat[[1]] = 4

            abs_df = matrix_to_stack(abs_mat)

            expect_warning(distinctiveness(abs_mat, dist_mat),
                           "^Provided object may not contain relative abund.*")

            expect_warning(distinctiveness_stack(abs_df, "species", "site",
                                                 "value", dist_mat),
                           "^Provided object may not contain relative abund.*")

            expect_warning(scarcity(abs_mat),
                           "^Provided object may not contain relative abund.*")
          })
