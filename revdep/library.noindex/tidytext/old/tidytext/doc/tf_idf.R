## ----setup, echo=FALSE---------------------------------------------------
library(knitr)
opts_chunk$set(warning = FALSE, message = FALSE)
library(ggplot2)
theme_set(theme_light())

## ------------------------------------------------------------------------
library(dplyr)
library(janeaustenr)
library(tidytext)
book_words <- austen_books() %>%
  unnest_tokens(word, text) %>%
  count(book, word, sort = TRUE)

total_words <- book_words %>% group_by(book) %>% summarize(total = sum(n))
book_words <- left_join(book_words, total_words)
book_words

## ---- fig.height=7, fig.width=7------------------------------------------
library(ggplot2)
ggplot(book_words, aes(n/total, fill = book)) +
  geom_histogram(show.legend = FALSE) +
  xlim(NA, 0.0009) +
  facet_wrap(~book, ncol = 2, scales = "free_y")

## ------------------------------------------------------------------------
book_words <- book_words %>%
  bind_tf_idf(word, book, n)
book_words

## ------------------------------------------------------------------------
book_words %>%
  select(-total) %>%
  arrange(desc(tf_idf))

## ------------------------------------------------------------------------
book_words %>%
  filter(book == "Pride & Prejudice") %>%
  select(-total) %>%
  arrange(desc(tf_idf))

