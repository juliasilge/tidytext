## ----echo = FALSE--------------------------------------------------------
knitr::opts_chunk$set(fig.width = 7, fig.height = 7, message = FALSE, warning = FALSE,
                      eval = requireNamespace("tm", quietly = TRUE) && requireNamespace("quanteda", quietly = TRUE) && requireNamespace("topicmodels", quietly = TRUE))
library(ggplot2)
theme_set(theme_bw())

## ------------------------------------------------------------------------
library(tm)
data("AssociatedPress", package = "topicmodels")
AssociatedPress

## ------------------------------------------------------------------------
library(dplyr)
library(tidytext)

ap_td <- tidy(AssociatedPress)

## ------------------------------------------------------------------------
ap_sentiments <- ap_td %>%
  inner_join(get_sentiments("bing"), by = c(term = "word"))

ap_sentiments

## ------------------------------------------------------------------------
library(tidyr)

ap_sentiments %>%
  count(document, sentiment, wt = count) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative) %>%
  arrange(sentiment)

## ----fig.width = 7, fig.height = 5---------------------------------------
library(ggplot2)

ap_sentiments %>%
  count(sentiment, term, wt = count) %>%
  filter(n >= 150) %>%
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>%
  mutate(term = reorder(term, n)) %>%
  ggplot(aes(term, n, fill = sentiment)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ylab("Contribution to sentiment")

## ------------------------------------------------------------------------
library(methods)

data("data_corpus_inaugural", package = "quanteda")
d <- quanteda::dfm(data_corpus_inaugural, verbose = FALSE)

d

tidy(d)

## ------------------------------------------------------------------------
ap_td

# cast into a Document-Term Matrix
ap_td %>%
  cast_dtm(document, term, count)

# cast into a Term-Document Matrix
ap_td %>%
  cast_tdm(term, document, count)

# cast into quanteda's dfm
ap_td %>%
  cast_dfm(term, document, count)


# cast into a Matrix object
m <- ap_td %>%
  cast_sparse(document, term, count)
class(m)
dim(m)

## ------------------------------------------------------------------------
reut21578 <- system.file("texts", "crude", package = "tm")
reuters <- VCorpus(DirSource(reut21578),
                   readerControl = list(reader = readReut21578XMLasPlain))

reuters

## ------------------------------------------------------------------------
reuters_td <- tidy(reuters)
reuters_td

## ------------------------------------------------------------------------
library(quanteda)

data("data_corpus_inaugural")

data_corpus_inaugural

inaug_td <- tidy(data_corpus_inaugural)
inaug_td

## ------------------------------------------------------------------------
inaug_words <- inaug_td %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

inaug_words

## ------------------------------------------------------------------------
inaug_freq <- inaug_words %>%
  count(Year, word) %>%
  complete(Year, word, fill = list(n = 0)) %>%
  group_by(Year) %>%
  mutate(year_total = sum(n),
         percent = n / year_total) %>%
  ungroup()

inaug_freq

## ------------------------------------------------------------------------
models <- inaug_freq %>%
  group_by(word) %>%
  filter(sum(n) > 50) %>%
  do(tidy(glm(cbind(n, year_total - n) ~ Year, .,
              family = "binomial"))) %>%
  ungroup() %>%
  filter(term == "Year")

models

models %>%
  filter(term == "Year") %>%
  arrange(desc(abs(estimate)))

## ------------------------------------------------------------------------
library(ggplot2)

models %>%
  mutate(adjusted.p.value = p.adjust(p.value)) %>%
  ggplot(aes(estimate, adjusted.p.value)) +
  geom_point() +
  scale_y_log10() +
  geom_text(aes(label = word), vjust = 1, hjust = 1,
            check_overlap = TRUE) +
  xlab("Estimated change over time") +
  ylab("Adjusted p-value")

## ------------------------------------------------------------------------
library(scales)

models %>%
  top_n(6, abs(estimate)) %>%
  inner_join(inaug_freq) %>%
  ggplot(aes(Year, percent)) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~ word) +
  scale_y_continuous(labels = percent_format()) +
  ylab("Frequency of word in speech")

