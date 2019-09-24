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

song_df <- data.frame(
  id = 1:8,
  txt = c("How many roads must a man walk down",
          "Before you call him a man?",
          "How many seas must a white dove sail",
          "Before she sleeps in the sand?",
          "How many times must the cannonballs fly",
          "Before they're forever banned?",
          "The answer, my friend, is blowin' in the wind.",
          "The answer is blowin' in the wind."),
  stringsAsFactors = FALSE
)

