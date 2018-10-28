context("Compute Functional Distance Matrix")

test_that("Returned object is a matrix", {

  trait_df = data.frame(1:5, letters[1:5])
  rownames(trait_df) = letters[1:5]

  # Object is matrix
  expect_is(compute_dist_matrix(trait_df), "matrix")
})


test_that("Names in distance matrix named after rownames", {
  trait = data.frame(sp = paste("sp", 1:5), trait_1 = 1:5,
                     trait_2 = as.factor(c("A", "A", "A", "B", "B")))


  # No rownames
  expect_warning(compute_dist_matrix(trait))

  # With defined rownames
  rownames(trait) = trait$sp

  dist_mat = compute_dist_matrix(trait)

  expect_identical(rownames(dist_mat), rownames(trait))
  expect_identical(colnames(dist_mat), rownames(trait))


})


test_that("Distance matrix contains good values", {

  trait = data.frame(sp = paste("sp", 1:5), trait_1 = 1:5,
                     trait_2 = as.factor(c("A", "A", "A", "B", "B")))

  rownames(trait) = trait$sp

  t_dist_mat = compute_dist_matrix(trait)

  other_mat = as.data.frame(matrix(1:16, nrow = 4))
  rownames(other_mat) = paste0("sp", 1:4)

  dist_mat = suppressWarnings(compute_dist_matrix(other_mat))

  # Null diagonal
  expect_equivalent(diag(dist_mat), rep(0, 4))
  expect_equivalent(diag(t_dist_mat), rep(0, 5))

  # Expected values
  expect_equivalent(dist_mat,
                    matrix(c(0, 1/3, 2/3, 1,
                             1/3, 0, 1/3, 2/3,
                             2/3, 1/3, 0, 1/3,
                             1, 2/3, 1/3, 0),
                           nrow = 4))
})

test_that("Different distances method give consistent results", {

  trait_df = data.frame(trait_1 = seq(from = -5, to = 5, 2.5),
                        trait_2 = 5:1)

  rownames(trait_df) = paste0("sp", 1:5)

  # Euclidean
  euc_mat = compute_dist_matrix(trait_df, metric = "euclidean")

  euc_dist = dist(trait_df, method = "euclidean")

  expect_equal(euc_mat, as.matrix(euc_dist))


  # Manhattan
  man_mat = suppressWarnings(compute_dist_matrix(trait_df, metric = "manhattan"))

  man_dist = dist(trait_df, method = "manhattan")

  expect_equal(man_mat, as.matrix(man_dist))


  # Gower
  def_mat = suppressWarnings(compute_dist_matrix(trait_df))

  gow_mat = suppressWarnings(compute_dist_matrix(trait_df, metric = "gower"))

  other_gow_dist = as.matrix(cluster::daisy(trait_df, "gower"))

  expect_equal(def_mat, gow_mat)
  expect_equal(gow_mat, other_gow_dist)
})

test_that("Scaling works with continuous traits", {

  trait_df = data.frame(trait1 = c(rep(1, 2), rep(2, 2)),
                        trait2 = c(rep(-1, 2), rep(-2, 2)))

  rownames(trait_df) = paste0("sp", 1:4)

  center_scale_dist = as.matrix(dist(scale(trait_df, TRUE, TRUE)))
  center_dist       = as.matrix(dist(scale(trait_df, TRUE, FALSE)))
  scale_dist        = as.matrix(dist(scale(trait_df, FALSE, TRUE)))

  expect_equivalent(compute_dist_matrix(trait_df, center = TRUE, scale = TRUE,
                                        metric = "euclidean"),
                    center_scale_dist)

  expect_equivalent(compute_dist_matrix(trait_df, center = TRUE, scale = FALSE,
                                        metric = "euclidean"),
                    center_dist)

  expect_equivalent(compute_dist_matrix(trait_df, center = TRUE, scale = TRUE,
                                        metric = "euclidean"),
                    center_scale_dist)

  trait_df2 = trait_df
  trait_df2$trait3 = letters[1:4]

  # Non-gower distance for centering and scaling
  expect_error(compute_dist_matrix(trait_df2, center = TRUE, scale = TRUE),
               "'gower' distance cannot be scaled nor centered", fixed = TRUE)

  expect_error(compute_dist_matrix(trait_df2, center = FALSE, scale = TRUE),
               "'gower' distance cannot be scaled nor centered", fixed = TRUE)

  expect_error(compute_dist_matrix(trait_df2, center = TRUE, scale = FALSE),
               "'gower' distance cannot be scaled nor centered", fixed = TRUE)

  # Non-numeric distance matrices scaled
  expect_error(compute_dist_matrix(trait_df2, center = TRUE, scale = TRUE,
                                   metric = "euclidean"),
               "Non-numeric traits provided. Cannot compute euclidean distance",
               fixed = TRUE)

  expect_error(compute_dist_matrix(trait_df2, center = FALSE, scale = TRUE,
                                   metric = "euclidean"),
               "Non-numeric traits provided. Cannot compute euclidean distance",
               fixed = TRUE)

  expect_error(compute_dist_matrix(trait_df2, center = TRUE, scale = FALSE,
                                   metric = "euclidean"),
               "Non-numeric traits provided. Cannot compute euclidean distance",
               fixed = TRUE)
})
