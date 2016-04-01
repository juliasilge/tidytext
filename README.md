<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/juliasilge/tidytext.svg?branch=master)](https://travis-ci.org/juliasilge/tidytext)

tidytext: Text mining using dplyr, ggplot2, and other tidy tools
---------------



### Jane Austen's Novels Can Be So Tidy


```r
library(janeaustenr)
library(dplyr)
originalbooks <- bind_rows(
  data_frame(text = sensesensibility, book = "Sense & Sensibility"),
  data_frame(text = prideprejudice, book = "Pride & Prejudice"),
  data_frame(text = mansfieldpark, book = "Mansfield Park"),
  data_frame(text = emma, book = "Emma"),
  data_frame(text = northangerabbey, book = "Northanger Abbey"),
  data_frame(text = persuasion, book = "Persuasion")
) %>% mutate(book = factor(book, levels = unique(book)))
```

Where are the chapters?


```r
library(stringr)
originalbooks <- originalbooks %>%
  group_by(book) %>%
  mutate(linenumber = row_number(),
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", 
                                                 ignore_case = TRUE)))) %>%
  ungroup()
```

Now we can use our new function for unnest and tokenizing. We can use the `tokenizers` package if installed, or else stick with `str_split`. The default tokenizing is for words, but other options include characters, sentences, lines, paragraphs, and a regex pattern. By default, `unnest_tokens` drops the original text.


```r
library(tidytext)
library(tokenizers)
#> Error in library(tokenizers): there is no package called 'tokenizers'
books <- originalbooks %>%
  unnest_tokens(word, text)
#> Tokenizer package not installed; using str_split instead.

books
#> Source: local data frame [725,008 x 4]
#> 
#>                   book linenumber chapter        word
#>                 (fctr)      (int)   (int)       (chr)
#> 1  Sense & Sensibility          1       0       sense
#> 2  Sense & Sensibility          1       0         and
#> 3  Sense & Sensibility          1       0 sensibility
#> 4  Sense & Sensibility          2       0          by
#> 5  Sense & Sensibility          2       0        jane
#> 6  Sense & Sensibility          2       0      austen
#> 7  Sense & Sensibility          4       1     chapter
#> 8  Sense & Sensibility          5       1         the
#> 9  Sense & Sensibility          5       1      family
#> 10 Sense & Sensibility          5       1          of
#> ..                 ...        ...     ...         ...
```

We can remove stop words kept in a tidy data set in the `tidytext` package.


```r
books <- books %>%
  filter(!(word %in% stopwords$word))
#> Error in eval(expr, envir, enclos): object of type 'closure' is not subsettable
```

Now, let's see what are the most common words in all the books as a whole.


```r
books %>% count(word, sort = TRUE) 
#> Source: local data frame [14,233 x 2]
#> 
#>     word     n
#>    (chr) (int)
#> 1    the 26344
#> 2     to 24041
#> 3    and 22512
#> 4     of 21181
#> 5      a 13404
#> 6    her 13144
#> 7      i 12016
#> 8     in 11216
#> 9    was 11214
#> 10    it 10227
#> ..   ...   ...
```

Sentiment analysis can be done as an inner join. Three sentiment lexicons are in the `tidytext` package in the `sentiment` dataset. Let's look at the words with a sadness score from the NRC lexicon. What are the most common sadness words in *Mansfield Park*?


```r
nrcsadness <- filter(sentiments, lexicon == "nrc" & sentiment == "sadness")
books %>% filter(book == "Mansfield Park") %>% 
  inner_join(nrcsadness) %>% count(word, sort = TRUE)
#> Joining by: "word"
#> Source: local data frame [392 x 2]
#> 
#>          word     n
#>         (chr) (int)
#> 1      mother    89
#> 2     feeling    75
#> 3         ill    63
#> 4  impossible    57
#> 5       leave    56
#> 6         bad    49
#> 7        evil    48
#> 8       doubt    46
#> 9    scarcely    42
#> 10      worse    40
#> ..        ...   ...
```

Or instead we could examine how sentiment changes changes during each novel. Let's find a sentiment score for each word using the Bing lexicon, then count the number of positive and negative words in defined sections of each novel.


```r
library(tidyr)
bing <- filter(sentiments, lexicon == "bing")
janeaustensentiment <- books %>% inner_join(bing) %>% 
  count(book, index = linenumber %/% 80, sentiment) %>% 
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

![plot of chunk unnamed-chunk-9](README-unnamed-chunk-9-1.png) 

### Most common positive and negative words

One advantage of having 


```r
bing_word_counts <- books %>%
  inner_join(bing) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()
#> Joining by: "word"

bing_word_counts
#> Source: local data frame [2,586 x 3]
#> 
#>          word sentiment     n
#>         (chr)     (chr) (int)
#> 1  abominable  negative    17
#> 2  abominably  negative     7
#> 3   abominate  negative     3
#> 4      abound  positive     1
#> 5      abrupt  negative     5
#> 6    abruptly  negative    12
#> 7     absence  negative   111
#> 8      absurd  negative    19
#> 9   absurdity  negative    12
#> 10  abundance  positive    14
#> ..        ...       ...   ...
```


```r
bing_word_counts %>%
  filter(n > 150) %>%
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ylab("Contribution to positivity/negativity")
#> Warning: Stacking not well defined when ymin != 0
```

![plot of chunk unnamed-chunk-11](README-unnamed-chunk-11-1.png) 

This lets us spot an anomaly in the sentiment analysis- that the word "miss" is coded as negative.

### Wordclouds

We've seen that this works well with ggplot2. But having the words in a tidy format is useful for other plots as well.

For example, consider the wordcloud package.


```r
library(wordcloud)

books %>%
  count(word) %>%
  with(wordcloud(word, n, max.words = 50))
```

![plot of chunk unnamed-chunk-12](README-unnamed-chunk-12-1.png) 

In other functions, such as `comparison.cloud`, you may need to turn it into a matrix with reshape2's acast:


```r
library(reshape2)

books %>%
  inner_join(bing) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>% 
  comparison.cloud(colors = c("#F8766D", "#00BFC4"),
                   max.words = 75)
#> Joining by: "word"
```

![plot of chunk wordcloud](README-wordcloud-1.png) 

### Combining With a Dictionary

Download a psych dictionary:


```r
RIDzipfile <- download.file("http://provalisresearch.com/Download/RID.ZIP", "RID.zip")
unzip("RID.zip")
RIDdict <- quanteda::dictionary(file = "RID.CAT", format = "wordstat")
file.remove("RID.zip", "RID.CAT", "RID.exc")
#> [1] TRUE TRUE TRUE
```

And tidy it:


```r
rid <- tidy(RIDdict, regex = TRUE) %>%
  rename(regex = word) %>%
  tbl_df()

rid
#> Source: local data frame [3,151 x 2]
#> 
#>                category        regex
#>                   (chr)        (chr)
#> 1  PRIMARY.NEED.ORALITY     ^absinth
#> 2  PRIMARY.NEED.ORALITY        ^ale$
#> 3  PRIMARY.NEED.ORALITY       ^ales$
#> 4  PRIMARY.NEED.ORALITY ^alimentary$
#> 5  PRIMARY.NEED.ORALITY    ^ambrosia
#> 6  PRIMARY.NEED.ORALITY   ^ambrosial
#> 7  PRIMARY.NEED.ORALITY     ^appetit
#> 8  PRIMARY.NEED.ORALITY       ^apple
#> 9  PRIMARY.NEED.ORALITY    ^artichok
#> 10 PRIMARY.NEED.ORALITY    ^asparagu
#> ..                  ...          ...
```

For now let's focus on the "secondary needs" type:


```r
secondary <- rid %>%
  filter(str_detect(category, "SECONDARY"))

secondary
#> Source: local data frame [714 x 2]
#> 
#>                       category             regex
#>                          (chr)             (chr)
#> 1  SECONDARY.ABSTRACT_TOUGHT._         ^diverse$
#> 2  SECONDARY.ABSTRACT_TOUGHT._ ^diversification$
#> 3  SECONDARY.ABSTRACT_TOUGHT._     ^diversified$
#> 4  SECONDARY.ABSTRACT_TOUGHT._       ^diversity$
#> 5  SECONDARY.ABSTRACT_TOUGHT._         ^evident$
#> 6  SECONDARY.ABSTRACT_TOUGHT._      ^evidential$
#> 7  SECONDARY.ABSTRACT_TOUGHT._            ^guess
#> 8  SECONDARY.ABSTRACT_TOUGHT._        ^logistic$
#> 9  SECONDARY.ABSTRACT_TOUGHT._         ^abstract
#> 10 SECONDARY.ABSTRACT_TOUGHT._           ^almost
#> ..                         ...               ...
```

Now we can use the [fuzzyjoin](http://github.com/dgrtwo/fuzzyjoin) package to join these with the Emma:


```r
library(fuzzyjoin)

secondary_emma <- emma_words %>%
  regex_inner_join(secondary, by = c(word = "regex"))
#> Error in eval(expr, envir, enclos): object 'emma_words' not found
```
