<!-- README.md is generated from README.Rmd. Please edit that file -->

tidytext: Text mining using dplyr, ggplot2, and other tidy tools
---------------

In progress at ROpenSci Unconf 2016.



Jane Austen's novels can be so tidy.


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
)
```

Where are the chapters?


```r
library(stringr)
originalbooks <- originalbooks %>%
  group_by(book) %>%
  mutate(chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", 
                                                 ignore_case = TRUE)))) %>%
  ungroup()
```

Now we can use our new function for unnest and tokenizing. We can use the `tokenizers` package if installed, or else stick with `str_split`. The default tokenizing is for words, but other options include characters, sentences, lines, paragraphs, and a regex pattern. By default, `unnest_tokens` drops the original text.


```r
library(tokenizers)
books <- originalbooks %>%
  unnest_tokens(word, text)

books
#> Source: local data frame [724,971 x 3]
#> 
#>                   book chapter        word
#>                  (chr)   (int)       (chr)
#> 1  Sense & Sensibility       0       sense
#> 2  Sense & Sensibility       0         and
#> 3  Sense & Sensibility       0 sensibility
#> 4  Sense & Sensibility       0          by
#> 5  Sense & Sensibility       0        jane
#> 6  Sense & Sensibility       0      austen
#> 7  Sense & Sensibility       0        1811
#> 8  Sense & Sensibility       1     chapter
#> 9  Sense & Sensibility       1           1
#> 10 Sense & Sensibility       1         the
#> ..                 ...     ...         ...
```

We can remove stop words kept in a tidy data set in the `tidytext` package.


```r
books <- books %>%
  filter(!(word %in% stopwords$word))
```

Now, let's see what are the most common words in all the books as a whole.


```r
books %>% count(word, sort = TRUE) 
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

Sentiment analysis can be done as an inner join. Three sentiment lexicons are in the `tidytext` package in the `sentiment` dataset. Let's look at negative words from the Bing lexicon. What are the most common negative words in *Mansfield Park*?


```r
negativebing <- filter(sentiments, lexicon == "bing" & sentiment == "negative")
books %>% filter(book == "Mansfield Park") %>% 
  inner_join(negativebing) %>% count(word, sort = TRUE)
#> Joining by: "word"
#> Source: local data frame [978 x 2]
#> 
#>          word     n
#>         (chr) (int)
#> 1        miss   432
#> 2        poor    96
#> 3  impossible    57
#> 4      object    55
#> 5         bad    49
#> 6        evil    48
#> 7       doubt    46
#> 8     anxious    42
#> 9    scarcely    42
#> 10     temper    41
#> ..        ...   ...
```

Or instead we could examine how sentiment changes changes during the novel.






### Combining with a dictionary

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
