<!-- README.md is generated from README.Rmd. Please edit that file -->

tidytext: Text mining using dplyr, ggplot2, and other tidy tools
---------------

In progress at ROpenSci Unconf 2016.




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

Book analysis


```r
library(stringr)
books <- books %>%
  group_by(book) %>%
  mutate(line = row_number(),
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", ignore_case = TRUE)))) %>%
  ungroup()
```

Split by word:


```r
books %>%
  unnest(word = str_split(text, "[^a-z']")) %>%
  filter(word != "")
#> Source: local data frame [711,883 x 5]
#> 
#>                                                                     text
#>                                                                    (chr)
#> 1                                                         by Jane Austen
#> 2                                                         by Jane Austen
#> 3                                                         by Jane Austen
#> 4  The family of Dashwood had long been settled in Sussex.  Their estate
#> 5  The family of Dashwood had long been settled in Sussex.  Their estate
#> 6  The family of Dashwood had long been settled in Sussex.  Their estate
#> 7  The family of Dashwood had long been settled in Sussex.  Their estate
#> 8  The family of Dashwood had long been settled in Sussex.  Their estate
#> 9  The family of Dashwood had long been settled in Sussex.  Their estate
#> 10 The family of Dashwood had long been settled in Sussex.  Their estate
#> ..                                                                   ...
#> Variables not shown: book (chr), line (int), chapter (int), word (chr)
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

We can remove stop words using `anti_join`:


```r
emma_words <- emma_words %>%
  filter(!(word %in% stopwords$word))
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
