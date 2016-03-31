<!-- README.md is generated from README.Rmd. Please edit that file -->

tidytext: Text mining using dplyr, ggplot2, and other tidy tools
---------------

In progress at ROpenSci Unconf 2016.




```r
books <- bind_rows(
  data_frame(text = sensesensibility, book = "Sense & Sensibility"),
  data_frame(text = prideprejudice, book = "Pride & Prejudice"),
  data_frame(text = mansfieldpark, book = "Mansfield Park"),
  data_frame(text = emma, book = "Emma"),
  data_frame(text = northangerabbey, book = "Northanger Abbey"),
  data_frame(text = persuasion, book = "Persuasion")
)
#> Error in eval(expr, envir, enclos): could not find function "bind_rows"
```

Book analysis


```r
books <- books %>%
  group_by(book) %>%
  mutate(text = str_to_lower(text),
         line = row_number(),
         chapter = cumsum(str_detect(text, "^chapter [\\divxlc]"))) %>%
  ungroup()
#> Error in eval(expr, envir, enclos): could not find function "%>%"
```

Split by word:


```r
books %>%
  unnest(word = str_split(text, "[^a-z']")) %>%
  filter(word != "")
#> Error in eval(expr, envir, enclos): could not find function "%>%"
```

### Create word-per-row data frame


```r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> 
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> 
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
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
#> Error in eval(expr, envir, enclos): object 'stopwords' not found
```

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
#> Error in FUN(X[[i]], ...): object 'secondary' not found
```
