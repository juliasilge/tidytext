context("Date Conversion")
library(LexisNexisTools)

## Languages
# English
# German
# Spanish
# Dutch
# French
# Portuguese
# Italian
# Russian

test_that("English date gets converted", {
  expect_equal(lnt_asDate("January 11, 2010"), as.Date("2010-01-11"))
})

test_that("German date gets converted", {
  expect_equal(lnt_asDate("8. März 2001"), as.Date("2001-03-08"))
  expect_equal(lnt_asDate("8. Maerz 2001"), as.Date("2001-03-08"))
})

test_that("Spanish date gets converted", {
  expect_equal(lnt_asDate("3 julio 2018 martes"), as.Date("2018-07-03"))
  expect_equal(lnt_asDate("9 abril 2018 lunes"), as.Date("2018-04-09"))
})

test_that("Dutch date gets converted", {
  expect_equal(lnt_asDate("4 juillet 2018 mercredi"), as.Date("2018-07-04"))
})

test_that("French date gets converted", {
  expect_equal(lnt_asDate("mardi 3 juillet 2018 "), as.Date("2018-07-03"))
  expect_equal(lnt_asDate("4 juillet 2018 mercredi"), as.Date("2018-07-04"))
})

test_that("Portuguese date gets converted", {
  expect_equal(lnt_asDate("3 Julho 2018 Terça-feira 10:27 AM GMT "), as.Date("2018-07-03"))
  expect_equal(lnt_asDate("9 Maio 2018 Quarta-feira"), as.Date("2018-05-09"))
})

test_that("Italian date gets converted", {
  expect_equal(lnt_asDate("3 luglio 2018 martedì 4:07 PM GMT"), as.Date("2018-07-03"))
})

test_that("Attemp invalid date", {
  expect_error(lnt_asDate(""), "No valid dates found.", fixed = TRUE)
})
