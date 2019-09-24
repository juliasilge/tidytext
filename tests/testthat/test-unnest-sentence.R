test_that("unnest_sentences works", {
  orig <- tibble(txt = c(
    "I'm Nobody! Who are you?",
    "Are you - Nobody - too?",
    "Then there’s a pair of us!",
    "Don’t tell! they’d advertise - you know!"
  ))
  d <- orig %>% unnest_tokens(sentence, txt, token = "sentences")
  r <- orig %>% unnest_sentences(sentence, txt)
  expect_equal(d, r)
  d <- orig %>% unnest_tokens(sentence, txt, token = "sentences", strip_punct = TRUE)
  r <- orig %>% unnest_sentences(sentence, txt, strip_punct = TRUE)
  expect_equal(d, r)
})

test_that("unnest_lines works", {
  orig <- tibble(txt = c(
    "I'm Nobody! Who are you?",
    "Are you - Nobody - too?",
    "Then there’s a pair of us!",
    "Don’t tell! they’d advertise - you know!"
  ))
  d <- orig %>% unnest_tokens(sentence, txt, token = "lines")
  r <- orig %>% unnest_lines(sentence, txt)
  expect_equal(d, r)
})

test_that("unnest_paragraphs works", {
  orig <- tibble(txt = c(
    "I'm Nobody! \n\nWho are you?",
    "Are you - \n\nNobody - too?",
    "Then there’s \n\na pair of us!",
    "Don’t tell! \n\nthey’d advertise - you know!"
  ))
  d <- orig %>% unnest_tokens(sentence, txt, token = "paragraphs")
  r <- orig %>% unnest_paragraphs(sentence, txt)
  expect_equal(d, r)
})
