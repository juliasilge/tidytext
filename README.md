<!-- README.md is generated from README.Rmd. Please edit that file -->

tidytext: Text mining using dplyr, ggplot2, and other tidy tools
---------------

In progress at ROpenSci Unconf 2016.



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
```

Now, let's see what are the most common words in all the books as a whole.


```r
books %>% count(word, sort = TRUE) 
#> Source: local data frame [13,625 x 2]
#> 
#>      word     n
#>     (chr) (int)
#> 1    miss  1856
#> 2    time  1339
#> 3   fanny   859
#> 4    dear   820
#> 5    lady   817
#> 6     sir   805
#> 7     day   797
#> 8    emma   786
#> 9  sister   727
#> 10  house   699
#> ..    ...   ...
```

Sentiment analysis can be done as an inner join. Three sentiment lexicons are in the `tidytext` package in the `sentiment` dataset. Let's look at the words with a sadness score from the NRC lexicon. What are the most common sadness words in *Mansfield Park*?


```r
nrcsadness <- filter(sentiments, lexicon == "nrc" & sentiment == "sadness")
books %>% filter(book == "Mansfield Park") %>% 
  inner_join(nrcsadness) %>% count(word, sort = TRUE)
#> Joining by: "word"
#> Source: local data frame [387 x 2]
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
  geom_bar(stat = "identity") +
  facet_wrap(~book, ncol = 2, scales = "free_x") +
  labs(title = "Sentiment in Jane Austen's Novels",
       subtitle = "Tidy text analysis makes handling text easier for many tasks",
       y = "Sentiment Score",
       caption = "Texts sourced from Project Gutenberg") +
  theme(axis.title.x=element_blank()) +
  theme(axis.text.x=element_blank()) +
  theme(axis.ticks.x=element_blank()) +
  theme(legend.position="none")
```

![plot of chunk unnamed-chunk-9](README-unnamed-chunk-9-1.png) 


### Combining With a Dictionary

Download a psych dictionary:


```r
RIDzipfile <- download.file("http://provalisresearch.com/Download/RID.ZIP", "RID.zip")
unzip("RID.zip")
RIDdict <- dictionary(file = "RID.CAT", format = "wordstat")
#> Error in eval(expr, envir, enclos): could not find function "dictionary"
file.remove("RID.zip", "RID.CAT", "RID.exc")
#> [1] TRUE TRUE TRUE
```

And tidy it:


```r
rid <- tidy(RIDdict, regex = TRUE) %>%
  rename(regex = word) %>%
  tbl_df()
#> Error in eval(expr, envir, enclos): could not find function "tidy"

rid
#> Error in eval(expr, envir, enclos): object 'rid' not found
```

For now let's focus on the "secondary needs" type:


```r
secondary <- rid %>%
  filter(str_detect(category, "SECONDARY"))
#> Error in eval(expr, envir, enclos): object 'rid' not found

secondary
#> Error in eval(expr, envir, enclos): object 'secondary' not found
```

Now we can use the [fuzzyjoin](TODO) package to join these with the Emma:


```r
library(fuzzyjoin)

secondary_emma <- emma_words %>%
  regex_inner_join(secondary, by = c(word = "regex"))
#> Error in eval(expr, envir, enclos): object 'emma_words' not found
```
