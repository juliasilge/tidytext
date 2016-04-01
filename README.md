<!-- README.md is generated from README.Rmd. Please edit that file -->

tidytext: Text mining using dplyr, ggplot2, and other tidy tools
---------------

In progress at ROpenSci Unconf 2016.



Jane Austen's novels can be so tidy.


```r
library(janeaustenr)
books <- bind_rows(
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
books <- books %>%
  group_by(book) %>%
  mutate(chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", 
                                                 ignore_case = TRUE)))) %>%
  ungroup()
```

Now we can use our new function for unnest and tokenizing. We can use the `tokenizers` package if installed, or else stick with `str_split`. The default tokenizing is for words, but other options include characters, sentences, lines, paragraphs, and a regex pattern. By default, `unnest_tokens` drops the original text.


```r
library(tokenizers)
books <- books %>%
  unnest_tokens(word, text)
#> Error in get(method, as.environment("package:tokenizers")): object 'tokenize_' not found

books
#> Source: local data frame [62,271 x 3]
#> 
#>                                                                     text
#>                                                                    (chr)
#> 1                                                  SENSE AND SENSIBILITY
#> 2                                                         by Jane Austen
#> 3                                                                 (1811)
#> 4                                                              CHAPTER 1
#> 5  The family of Dashwood had long been settled in Sussex.  Their estate
#> 6   was large, and their residence was at Norland Park, in the centre of
#> 7      their property, where, for many generations, they had lived in so
#> 8    respectable a manner as to engage the general good opinion of their
#> 9  surrounding acquaintance.  The late owner of this estate was a single
#> 10  man, who lived to a very advanced age, and who for many years of his
#> ..                                                                   ...
#> Variables not shown: book (chr), chapter (int)
```

### Create word-per-row data frame


```r
library(dplyr)
library(tidyr)
library(stringr)
library(janeaustenr)

emma_words <- data_frame(word = emma) %>%
  mutate(line = row_number()) %>%
  unnest(word = str_split(str_to_lower(emma), "[^a-z']")) %>%
  filter(word != "")
```

We can remove stop words:


```r
emma_words <- emma_words %>%
  filter(!(word %in% stopwords$word))
#> Error in eval(expr, envir, enclos): object of type 'closure' is not subsettable
```

### Combining with a dictionary

Download a psych dictionary:


```r
RIDzipfile <- download.file("http://provalisresearch.com/Download/RID.ZIP", "RID.zip")
unzip("RID.zip")
RIDdict <- dictionary(file = "RID.CAT", format = "wordstat")
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
#> Error in FUN(X[[i]], ...): object 'secondary' not found
```
