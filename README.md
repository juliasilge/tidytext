<!-- README.md is generated from README.Rmd. Please edit that file -->

tidytext: Text mining using dplyr, ggplot2, and other tidy tools
---------------

**Authors:** [David Robinson](http://varianceexplained.org/), [Julia Silge](http://juliasilge.com/)<br>
**License:** [MIT](https://opensource.org/licenses/MIT)<br>

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/tidytext)](https://cran.r-project.org/package=tidytext)
[![Build Status](https://travis-ci.org/juliasilge/tidytext.svg?branch=master)](https://travis-ci.org/juliasilge/tidytext)



Using [tidy data principles](https://www.jstatsoft.org/article/view/v059i10) can make many text mining tasks easier, more effective, and  consistent with tools already in wide use. Much of the infrastructure needed for text mining with tidy data frames already exists in packages like `dplyr`, `broom`, and `ggplot2`; in this package, we go the rest of the way and provide tidying functions and supporting data sets to make analyzing text tidy.

### Installation

To install this package from Github, use `devtools`:


```r
library(devtools)
install_github("juliasilge/tidytext")
```

### Tidy text mining examples

The novels of Jane Austen can be so tidy! Let's use the text of Jane Austen's 6 completed, published novels from the `janeaustenr` package and our function to unnest and tokenize. We can use the `tokenizers` package if installed, or else stick with `str_split`. The default tokenizing is for words, but other options include characters, sentences, lines, paragraphs, and a regex pattern. By default, `unnest_tokens` drops the original text.


```r
library(tidytext)
library(janeaustenr)
library(dplyr)
books <- austen_books() %>%
  unnest_tokens(word, text)

books
#> Source: local data frame [724,971 x 2]
#> 
#>                   book        word
#>                 (fctr)       (chr)
#> 1  Sense & Sensibility       sense
#> 2  Sense & Sensibility         and
#> 3  Sense & Sensibility sensibility
#> 4  Sense & Sensibility          by
#> 5  Sense & Sensibility        jane
#> 6  Sense & Sensibility      austen
#> 7  Sense & Sensibility        1811
#> 8  Sense & Sensibility     chapter
#> 9  Sense & Sensibility           1
#> 10 Sense & Sensibility         the
#> ..                 ...         ...
```

We can remove stop words kept in a tidy data set in the `tidytext` package with an antijoin.


```r
data("stopwords")
books <- books %>%
  anti_join(stopwords)
#> Joining by: "word"
```

Now, let's see what are the most common words in all the books as a whole.


```r
books %>%
  count(word, sort = TRUE) 
#> Source: local data frame [13,896 x 2]
#> 
#>      word     n
#>     (chr) (int)
#> 1    miss  1854
#> 2    time  1337
#> 3   fanny   862
#> 4    dear   822
#> 5    lady   817
#> 6     sir   806
#> 7     day   797
#> 8    emma   787
#> 9  sister   727
#> 10  house   699
#> ..    ...   ...
```

Sentiment analysis can be done as an inner join. Three sentiment lexicons are in the `tidytext` package in the `sentiment` dataset. Let's examine how sentiment changes changes during each novel. Let's find a sentiment score for each word using the Bing lexicon, then count the number of positive and negative words in defined sections of each novel.


```r
library(tidyr)
bing <- sentiments %>%
  filter(lexicon == "bing") %>%
  select(-score)

janeaustensentiment <- books %>%
  inner_join(bing) %>% 
  count(book, index = row_number() %/% 80, sentiment) %>% 
  spread(sentiment, n, fill = 0) %>% 
  mutate(sentiment = positive - negative)
#> Joining by: "word"
```

Now we can plot these sentiment scores across the plot trajectory of each novel.


```r
library(ggplot2)

ggplot(janeaustensentiment, aes(index, sentiment, fill = book)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  facet_wrap(~book, ncol = 2, scales = "free_x")
```

![plot of chunk unnamed-chunk-7](README-unnamed-chunk-7-1.png)

For more examples of text mining using tidy data frames, see the tidytext vignette.

### Tidying document term matrices

Many existing text mining datasets are in the form of a DocumentTermMatrix class (from the `tm` package). For example, consider the corpus of 2246 Associated Press articles from the topicmodels dataset.


```r
data("AssociatedPress", package = "topicmodels")
#> Error in find.package(package, lib.loc, verbose = verbose): there is no package called 'topicmodels'
AssociatedPress
#> Error in eval(expr, envir, enclos): object 'AssociatedPress' not found
```

If we want to analyze this with tidy tools, we need to transform it into a one-row-per-term data frame first. The `broom` package provides a `tidy` function to do this. (For more on the tidy verb, [see the `broom` package](https://github.com/dgrtwo/broom)).


```r
library(broom)
tidy(AssociatedPress)
#> Error in tidy(AssociatedPress): object 'AssociatedPress' not found
```

We can perform sentiment analysis on these newspaper articles.


```r
ap_sentiments <- tidy(AssociatedPress) %>%
  inner_join(bing, by = c(term = "word"))
#> Error in tidy(AssociatedPress): object 'AssociatedPress' not found

ap_sentiments
#> Error in eval(expr, envir, enclos): object 'ap_sentiments' not found
```

We could find the most negative documents:


```r
ap_sentiments %>%
  count(document, sentiment, wt = count) %>%
  ungroup() %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative) %>%
  arrange(sentiment)
#> Error in eval(expr, envir, enclos): object 'ap_sentiments' not found
```

Or see which words contributed to positivity/negativity:


```r
ap_sentiments %>%
  count(sentiment, term, wt = count) %>%
  ungroup() %>%
  filter(n >= 150) %>%
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>%
  mutate(term = reorder(term, n)) %>%
  ggplot(aes(term, n, fill = sentiment)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ylab("Contribution to positivity/negativity")
#> Error in eval(expr, envir, enclos): object 'ap_sentiments' not found
```

We can join the Austen and AP datasets and compare the frequencies of each word:


```r
comparison <- tidy(AssociatedPress) %>%
  count(word = term) %>%
  rename(AP = n) %>%
  inner_join(count(books, word)) %>%
  rename(Austen = n) %>%
  mutate(AP = AP / sum(AP),
         Austen = Austen / sum(Austen))
#> Error in tidy(AssociatedPress): object 'AssociatedPress' not found

comparison
#> Error in eval(expr, envir, enclos): object 'comparison' not found

library(scales)
ggplot(comparison, aes(AP, Austen)) +
  geom_point() +
  geom_text(aes(label = word), check_overlap = TRUE,
            vjust = 1, hjust = 1) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  geom_abline(color = "red")
#> Error in ggplot(comparison, aes(AP, Austen)): object 'comparison' not found
```

For more examples of working with document term matrices from other packages using tidy data principles, see the TODO vignette.

### Code of Conduct

This project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
