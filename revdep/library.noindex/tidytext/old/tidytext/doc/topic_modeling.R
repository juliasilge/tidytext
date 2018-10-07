## ----echo = FALSE---------------------------------------------------------------------------------
library(knitr)
opts_chunk$set(message = FALSE, warning = FALSE,
               eval = requireNamespace("tm", quietly = TRUE))
options(width = 100, dplyr.width = 150)
library(ggplot2)
theme_set(theme_bw())

## ----packages-------------------------------------------------------------------------------------
library(dplyr)
library(gutenbergr)

## ----books_show, eval = FALSE---------------------------------------------------------------------
#  titles <- c("Twenty Thousand Leagues under the Sea", "The War of the Worlds",
#              "Pride and Prejudice", "Great Expectations")
#  books <- gutenberg_works(title %in% titles) %>%
#    gutenberg_download(meta_fields = "title")

## ----books, echo = FALSE--------------------------------------------------------------------------
# Downloading from Project Gutenberg can sometimes not work on automated servers
# such as Travis-CI: see
# https://github.com/ropenscilabs/gutenbergr/issues/6#issuecomment-231596903

# this is a workaround
load(system.file("extdata", "books.rda", package = "tidytext"))

## -------------------------------------------------------------------------------------------------
books

## ----word_counts----------------------------------------------------------------------------------
library(tidytext)
library(stringr)
library(tidyr)

by_chapter <- books %>%
  group_by(title) %>%
  mutate(chapter = cumsum(str_detect(text, regex("^chapter ", ignore_case = TRUE)))) %>%
  ungroup() %>%
  filter(chapter > 0)

by_chapter_word <- by_chapter %>%
  unite(title_chapter, title, chapter) %>%
  unnest_tokens(word, text)

word_counts <- by_chapter_word %>%
  anti_join(stop_words) %>%
  count(title_chapter, word, sort = TRUE)

word_counts

## ----chapters_dtm---------------------------------------------------------------------------------
chapters_dtm <- word_counts %>%
  cast_dtm(title_chapter, word, n)

chapters_dtm

## ----chapters_lda---------------------------------------------------------------------------------
library(topicmodels)
chapters_lda <- LDA(chapters_dtm, k = 4, control = list(seed = 1234))
chapters_lda

## ----chapters_lda_td------------------------------------------------------------------------------
chapters_lda_td <- tidy(chapters_lda)
chapters_lda_td

## ----top_terms------------------------------------------------------------------------------------
top_terms <- chapters_lda_td %>%
  group_by(topic) %>%
  top_n(5, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

top_terms

## ----top_terms_plot, fig.height=7, fig.width=7----------------------------------------------------
library(ggplot2)
theme_set(theme_bw())

top_terms %>%
  mutate(term = reorder(term, beta)) %>%
  ggplot(aes(term, beta)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ topic, scales = "free") +
  theme(axis.text.x = element_text(size = 15, angle = 90, hjust = 1))

## ----chapters_lda_gamma_raw-----------------------------------------------------------------------
chapters_lda_gamma <- tidy(chapters_lda, matrix = "gamma")
chapters_lda_gamma

## ----chapters_lda_gamma---------------------------------------------------------------------------
chapters_lda_gamma <- chapters_lda_gamma %>%
  separate(document, c("title", "chapter"), sep = "_", convert = TRUE)
chapters_lda_gamma

## ----chapters_lda_gamma_plot, fig.width=7, fig.height=6-------------------------------------------
ggplot(chapters_lda_gamma, aes(gamma, fill = factor(topic))) +
  geom_histogram() +
  facet_wrap(~ title, nrow = 2)

## ----chapter_classifications----------------------------------------------------------------------
chapter_classifications <- chapters_lda_gamma %>%
  group_by(title, chapter) %>%
  top_n(1, gamma) %>%
  ungroup() %>%
  arrange(gamma)

chapter_classifications

## ----book_topics----------------------------------------------------------------------------------
book_topics <- chapter_classifications %>%
  count(title, topic) %>%
  group_by(topic) %>%
  top_n(1, n) %>%
  ungroup() %>%
  transmute(consensus = title, topic)

book_topics

## -------------------------------------------------------------------------------------------------
chapter_classifications %>%
  inner_join(book_topics, by = "topic") %>%
  count(title, consensus)

## ----assignments----------------------------------------------------------------------------------
assignments <- augment(chapters_lda, data = chapters_dtm)

## -------------------------------------------------------------------------------------------------
assignments <- assignments %>%
  separate(document, c("title", "chapter"), sep = "_", convert = TRUE) %>%
  inner_join(book_topics, by = c(".topic" = "topic"))

assignments

## -------------------------------------------------------------------------------------------------
assignments %>%
  count(title, consensus, wt = count) %>%
  spread(consensus, n, fill = 0)

## -------------------------------------------------------------------------------------------------
wrong_words <- assignments %>%
  filter(title != consensus)

wrong_words

wrong_words %>%
  count(title, consensus, term, wt = count) %>%
  arrange(desc(n))

## -------------------------------------------------------------------------------------------------
word_counts %>%
  filter(word == "flopson")

