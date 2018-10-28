context("Gutenberg metadata")

library(stringr)

test_that("gutenberg_works does appropriate filtering by default", {
  w <- gutenberg_works()

  expect_true(all(w$language == "en"))
  expect_false(any(grepl("Copyright", w$rights)))
  expect_gt(nrow(w), 40000)
})


test_that("gutenberg_works takes filtering conditions", {
  w2 <- gutenberg_works(author == "Shakespeare, William")
  expect_gt(nrow(w2), 30)
  expect_true(all(w2$author == "Shakespeare, William"))
})


test_that("gutenberg_works does appropriate filtering by language", {
  w_de <- gutenberg_works(languages = "de")
  expect_true(all(w_de$language == "de"))

  w_lang <- gutenberg_works(languages = NULL)
  expect_gt(length(unique(w_lang$language)), 50)

  w_de_not_only <- gutenberg_works(languages = "de", only_languages = FALSE)
  expect_false(all(w_de_not_only$language == "de"))
  expect_true(all(str_detect(w_de_not_only$language, "de")))

  w_en_fr_all <- gutenberg_works(languages = c("en", "fr"),
                                 all_languages = TRUE)
  expect_true(all(w_en_fr_all$language == "en/fr"))

  w_en_fr_all_not_only <- gutenberg_works(languages = c("en", "fr"),
                                 all_languages = TRUE,
                                 only_languages = FALSE,
                                 rights = NULL)
  expect_false(all(w_en_fr_all_not_only$language == "en/fr"))
  expect_true(any(w_en_fr_all_not_only$language == "en/fr"))
  expect_true(any(w_en_fr_all_not_only$language == "en/es/fr"))

  en_es <- gutenberg_works(languages = c("en", "es"))
  expect_equal(sort(unique(en_es$language)), c("en", "en/es", "es"))
})


test_that("gutenberg_works gives error messages with named arguments", {
  expect_error(gutenberg_works(author = "Dickens, Charles"),
               "named arguments")
})


test_that("All three datasets have a date-updated", {
  d1 <- attr(gutenberg_metadata, "date_updated")
  d2 <- attr(gutenberg_subjects, "date_updated")
  d3 <- attr(gutenberg_authors, "date_updated")

  expect_is(d1, "Date")
  expect_is(d2, "Date")
  expect_is(d3, "Date")
})
