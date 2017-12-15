context("stem")

test_that("stemming works", {
  words <- data.frame(word = c("copper", "explain", "ill-fated","truck", "neat",
"united","branches","educated","tenuous","hum","decisive","notice"))
  stem <- stem_words(words, col = word)
  expect_equal(stem$word, c("copper","explain", "ill-fat", "truck", "neat","unit",
                            "branch", "educ", "tenuous", "hum", "decis","notic"))
})
