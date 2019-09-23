expect_nrow <- function(tbl, n){
  expect_is(tbl, "data.frame")
  expect_equal(nrow(tbl), n)
}

expect_first_row <- function(tbl, col, text){
  ct <- tbl %>%
    pull(!!enquo(col)) %>%
    purrr::pluck(1)
  expect_match(ct, text)
}

skspr <- data.frame(
  id = 1:4,
  txt = c(
    "Now is the winter of our discontent",
    "Made glorious summer by this sun of York;",
    "And all the clouds that lour'd upon our house",
    "In the deep bosom of the ocean buried."
  ),
  stringsAsFactors = FALSE
)
