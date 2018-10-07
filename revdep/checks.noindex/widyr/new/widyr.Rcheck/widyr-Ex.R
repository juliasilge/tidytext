pkgname <- "widyr"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('widyr')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("pairwise_cor")
### * pairwise_cor

flush(stderr()); flush(stdout())

### Name: pairwise_cor
### Title: Correlations of pairs of items
### Aliases: pairwise_cor pairwise_cor_

### ** Examples


library(dplyr)
library(gapminder)

gapminder %>%
  pairwise_cor(country, year, lifeExp)

gapminder %>%
  pairwise_cor(country, year, lifeExp, sort = TRUE)

# United Nations voting data
library(unvotes)

country_cors <- un_votes %>%
  mutate(vote = as.numeric(vote)) %>%
  pairwise_cor(country, rcid, vote, sort = TRUE)

country_cors




cleanEx()
nameEx("pairwise_count")
### * pairwise_count

flush(stderr()); flush(stdout())

### Name: pairwise_count
### Title: Count pairs of items within a group
### Aliases: pairwise_count pairwise_count_

### ** Examples


library(dplyr)
dat <- data_frame(group = rep(1:5, each = 2),
                  letter = c("a", "b",
                             "a", "c",
                             "a", "c",
                             "b", "e",
                             "b", "f"))

# count the number of times two letters appear together
pairwise_count(dat, letter, group)
pairwise_count(dat, letter, group, sort = TRUE)
pairwise_count(dat, letter, group, sort = TRUE, diag = TRUE)




cleanEx()
nameEx("pairwise_delta")
### * pairwise_delta

flush(stderr()); flush(stdout())

### Name: pairwise_delta
### Title: Delta measure of pairs of documents
### Aliases: pairwise_delta pairwise_delta_

### ** Examples


library(janeaustenr)
library(dplyr)
library(tidytext)

# closest documents in terms of 1000 most frequent words
closest <- austen_books() %>%
  unnest_tokens(word, text) %>%
  count(book, word) %>%
  top_n(1000, n) %>%
  pairwise_delta(book, word, n, method = "burrows") %>%
  arrange(delta)

closest

closest %>%
  filter(item1 == "Pride & Prejudice")

# to remove duplicates, use upper = FALSE
closest <- austen_books() %>%
  unnest_tokens(word, text) %>%
  count(book, word) %>%
  top_n(1000, n) %>%
  pairwise_delta(book, word, n, method = "burrows", upper = FALSE) %>%
  arrange(delta)

# Can also use Argamon's Linear Delta
closest <- austen_books() %>%
  unnest_tokens(word, text) %>%
  count(book, word) %>%
  top_n(1000, n) %>%
  pairwise_delta(book, word, n, method = "argamon", upper = FALSE) %>%
  arrange(delta)




cleanEx()
nameEx("pairwise_dist")
### * pairwise_dist

flush(stderr()); flush(stdout())

### Name: pairwise_dist
### Title: Distances of pairs of items
### Aliases: pairwise_dist pairwise_dist_

### ** Examples


library(gapminder)
library(dplyr)

# closest countries in terms of life expectancy over time
closest <- gapminder %>%
  pairwise_dist(country, year, lifeExp) %>%
  arrange(distance)

closest

closest %>%
  filter(item1 == "United States")

# to remove duplicates, use upper = FALSE
gapminder %>%
  pairwise_dist(country, year, lifeExp, upper = FALSE) %>%
  arrange(distance)

# Can also use Manhattan distance
gapminder %>%
  pairwise_dist(country, year, lifeExp, method = "manhattan", upper = FALSE) %>%
  arrange(distance)




cleanEx()
nameEx("pairwise_pmi")
### * pairwise_pmi

flush(stderr()); flush(stdout())

### Name: pairwise_pmi
### Title: Pointwise mutual information of pairs of items
### Aliases: pairwise_pmi pairwise_pmi_

### ** Examples


library(dplyr)

dat <- data_frame(group = rep(1:5, each = 2),
                  letter = c("a", "b",
                             "a", "c",
                             "a", "c",
                             "b", "e",
                             "b", "f"))

# how informative is each letter about each other letter
pairwise_pmi(dat, letter, group)
pairwise_pmi(dat, letter, group, sort = TRUE)




cleanEx()
nameEx("pairwise_similarity")
### * pairwise_similarity

flush(stderr()); flush(stdout())

### Name: pairwise_similarity
### Title: Cosine similarity of pairs of items
### Aliases: pairwise_similarity pairwise_similarity_

### ** Examples


library(janeaustenr)
library(dplyr)
library(tidytext)

# Comparing Jane Austen novels
austen_words <- austen_books() %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words, by = "word") %>%
  count(book, word) %>%
  ungroup()

# closest books to each other
closest <- austen_words %>%
  pairwise_similarity(book, word, n) %>%
  arrange(desc(similarity))

closest

closest %>%
  filter(item1 == "Emma")




cleanEx()
nameEx("squarely")
### * squarely

flush(stderr()); flush(stdout())

### Name: squarely
### Title: A special case of the widely adverb for creating tidy square
###   matrices
### Aliases: squarely squarely_

### ** Examples


library(dplyr)
library(gapminder)

closest_continent <- gapminder %>%
  group_by(continent) %>%
  squarely(dist)(country, year, lifeExp)




cleanEx()
nameEx("widely")
### * widely

flush(stderr()); flush(stdout())

### Name: widely
### Title: Adverb for functions that operate on matrices in "wide" format
### Aliases: widely widely_

### ** Examples


library(dplyr)
library(gapminder)

gapminder

gapminder %>%
  widely(dist)(country, year, lifeExp)

# can perform within groups
closest_continent <- gapminder %>%
  group_by(continent) %>%
  widely(dist)(country, year, lifeExp)
closest_continent

# for example, find the closest pair in each
closest_continent %>%
  top_n(1, -value)




cleanEx()
nameEx("widely_svd")
### * widely_svd

flush(stderr()); flush(stdout())

### Name: widely_svd
### Title: Turn into a wide matrix, perform SVD, return to tidy form
### Aliases: widely_svd widely_svd_

### ** Examples


library(dplyr)
library(gapminder)

# principal components driving change
gapminder_svd <- gapminder %>%
  widely_svd(country, year, lifeExp)

gapminder_svd

# compare SVDs, join with other data
library(ggplot2)
library(tidyr)

gapminder_svd %>%
  spread(dimension, value) %>%
  inner_join(distinct(gapminder, country, continent), by = "country") %>%
  ggplot(aes(`1`, `2`, label = country)) +
  geom_point(aes(color = continent)) +
  geom_text(vjust = 1, hjust = 1)




### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
