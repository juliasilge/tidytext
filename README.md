<!-- README.md is generated from README.Rmd. Please edit that file -->

tidytext: Text mining using dplyr, ggplot2, and other tidy tools
---------------

In progress at ROpenSci Unconf 2016.



Jane Austen's novels can be so tidy.


```r
library(janeaustenr)
originalbooks <- bind_rows(
  data_frame(text = sensesensibility, book = "Sense & Sensibility"),
  data_frame(text = prideprejudice, book = "Pride & Prejudice"),
  data_frame(text = mansfieldpark, book = "Mansfield Park"),
  data_frame(text = emma, book = "Emma"),
  data_frame(text = northangerabbey, book = "Northanger Abbey"),
  data_frame(text = persuasion, book = "Persuasion")
)
#> Error in eval(expr, envir, enclos): could not find function "bind_rows"
```

Where are the chapters?


```r
library(stringr)
originalbooks <- originalbooks %>%
  group_by(book) %>%
  mutate(chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", 
                                                 ignore_case = TRUE)))) %>%
  ungroup()
#> Error in eval(expr, envir, enclos): object 'originalbooks' not found
```

Now we can use our new function for unnest and tokenizing. We can use the `tokenizers` package if installed, or else stick with `str_split`. The default tokenizing is for words, but other options include characters, sentences, lines, paragraphs, and a regex pattern. By default, `unnest_tokens` drops the original text.


```r
library(tokenizers)
books <- originalbooks %>%
  unnest_tokens(word, text)
#> Error in eval(expr, envir, enclos): object 'originalbooks' not found

books
#> Error in eval(expr, envir, enclos): object 'books' not found
```

We can remove stop words kept in a tidy data set in the `tidytext` package.


```r
books <- books %>%
  filter(!(word %in% stopwords$word))
#> Error in eval(expr, envir, enclos): object 'books' not found
```

Now, let's see what are the most common words in all the books as a whole.


```r
books %>% count(word, sort = TRUE) 
#> Error in eval(expr, envir, enclos): object 'books' not found
```

Sentiment analysis can be done as an inner join. Three sentiment lexicons are in the `tidytext` package in the `sentiment` dataset. Let's look at negative words from the Bing lexicon. What are the most common negative words in *Mansfield Park*?


```r
negativebing <- filter(sentiments, lexicon == "bing" & sentiment == "negative")
#> Warning in data.matrix(data): NAs introduced by coercion

#> Warning in data.matrix(data): NAs introduced by coercion

#> Warning in data.matrix(data): NAs introduced by coercion
#> Error in filter(sentiments, lexicon == "bing" & sentiment == "negative"): object 'lexicon' not found
books %>% filter(book == "Mansfield Park") %>% 
  inner_join(negativebing) %>% count(word, sort = TRUE)
#> Error in eval(expr, envir, enclos): object 'books' not found
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
