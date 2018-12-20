context("test-fedregs.R")

test_that("We get the best CFR URLs.", {

  good_year <- 2000
  good_title_number <- 15

  bad_year <- 1993
  bad_title_number <- 55

  na_year <- 1996
  na_title_number <- 1

  testthat::expect_error(cfr_urls(year = bad_year,
                          title_number = good_title_number,
                            check_url = TRUE), "Year must be between 1996 and 2017.\n")

  testthat::expect_error(cfr_urls(year = good_year,
                          title_number = bad_title_number,
                          check_url = TRUE), "Title must be a numeric value between 1 and 50.\n")

  testthat::expect_message(cfr_urls(year = na_year,
                            title_number = na_title_number,
                            verbose = TRUE,
                            check_url = FALSE), sprintf("There aren't any regulations for title %s in %s.",
                                                        na_title_number,
                                                        na_year))

  testthat::expect_true(is.na(cfr_urls(year = na_year,
                         title_number = na_title_number,
                         verbose = FALSE,
                         check_url = FALSE)))

    cfr <- cfr_urls(year = good_year,
                    title_number = good_title_number,
                    check_url = FALSE)

    testthat::expect_true(all(grepl("*..xml$", cfr)))
    testthat::expect_true(is.character(cfr))

})

test_that("We can parse some parts.", {

  good_year <- 2000
  good_title_number <- 15

  bad_year <- 1993
  bad_title_number <- 55

  na_year <- 1996
  na_title_number <- 1

  na_url <- cfr_urls(year = na_year, title_number = na_title_number)
  good_url <- cfr_urls(year = good_year, title_number = good_title_number)[1]
  bad_url <- sprintf("https://www.gpo.gov/fdsys/bulkdata/CFR/%s/title-%s/CFR-%s-title%s-vol1.xml",
                     bad_year,
                     bad_title_number,
                     bad_year,
                     bad_title_number)

  testthat::expect_error(cfr_part(bad_url), "The URL is not valid.")

  testthat::expect_error(cfr_part(na_url), "NA is not a valid url.")

  testthat::expect_message(cfr_part(good_url,
                          verbose = TRUE),
                 sprintf("Pulling the chapter, part, and volume information from:\n%s.\n",
                         good_url))

  good_part <- cfr_part(good_url)

  testthat::expect_true(is.data.frame(good_part))
  testthat::expect_true(good_url == unique(good_part$url))
  testthat::expect_true(good_year == unique(good_part$year))
  testthat::expect_true(good_title_number == unique(good_part$title))
  testthat::expect_true(all(grepl("*..xml$", good_part$url)))

})

test_that("We can extract some numbers.", {

  bad_part <- "800 to end"
  good_part <- "Part 800 to end"
  silly_part <- "Part no digits"

  testthat::expect_error(numextract(bad_part), "Make sure you are providing a valid 'part'.")
  testthat::expect_error(numextract(silly_part), "Make sure string is a numeric value.")

  testthat::expect_true(numextract("Part 100 to 200", return = "max") == 200)
  testthat::expect_true(numextract("Part 100 to 200", return = "min") == 100)
  testthat::expect_true(numextract("Part 100 to end", return = "max") == Inf)

  testthat::expect_true(is.numeric(numextract("Part 100 to 200", return = "max")))
  testthat::expect_true(is.numeric(numextract("Part 100 to 200", return = "min")))
  testthat::expect_true(is.numeric(numextract("Part 100 to end", return = "max")))

})


test_that("We can go all the way", {

  good_year <- 2012
  bad_year <- 1995
  na_year <- 1996
  good_title_number <- 50
  bad_title_number <- 1000
  na_title_number <- 1
  good_chapter <- 6
  bad_chapter <- "BB"
  good_part <- 648
  bad_part <- "DD"

  testthat::expect_error(cfr_text(bad_year,
                                  good_title_number,
                                  good_chapter,
                                  good_part),
                         "Year must be between 1996 and 2017.\n")

  testthat::expect_error(cfr_text(good_year,
                                  bad_title_number,
                                  good_chapter,
                                  good_part),
                         "Title must be a numeric value between 1 and 50.\n")

  testthat::expect_error(cfr_text(good_year,
                                  good_title_number,
                                  bad_chapter,
                                  good_part),
                         "Chapter must be a numeric value, not a Roman Numeral.\n")

  testthat::expect_error(cfr_text(good_year,
                                  good_title_number,
                                  good_chapter,
                                  bad_part),
                         "Part must be a numeric value.\n")

  testthat::expect_error(cfr_text(na_year,
                                  na_title_number,
                                  good_chapter,
                                  good_part),
                         sprintf("There aren't any regulations for title %s in %s.\n", na_title_number, na_year))


  good_text <- cfr_text(good_year, good_title_number, good_chapter, good_part)


  testthat::expect_true(all(class(good_text) %in% c("tbl", "tbl_df", "data.frame") == TRUE))

})
