# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.3.0 (2016-05-03) |
|system   |x86_64, darwin13.4.0         |
|ui       |RStudio (0.99.902)           |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |America/Denver               |
|date     |2016-06-21                   |

## Packages

|package  |*  |version    |date       |source        |
|:--------|:--|:----------|:----------|:-------------|
|tidytext |   |0.1.0.9000 |2016-06-21 |local (NA/NA) |

# Check results
1 packages with problems

## gutenbergr (0.1.1)
Maintainer: David Robinson <admiral.david@gmail.com>  
Bug reports: http://github.com/ropenscilabs/gutenbergr/issues

2 errors | 0 warnings | 0 notes

```
checking examples ... ERROR
Running examples in ‘gutenbergr-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: gutenberg_strip
> ### Title: Strip header and footer content from a Project Gutenberg book
> ### Aliases: gutenberg_strip
> 
> ### ** Examples
... 10 lines ...

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

> book <- gutenberg_works(title == "Pride and Prejudice") %>%
+   gutenberg_download(strip = FALSE)
Determining mirror for Project Gutenberg from http://www.gutenberg.org/robot/harvest
Using mirror http://www.gutenberg.lib.md.us
Error: Unknown column 'gutenberg_id'
Execution halted

checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  6: w_de$language
  7: `$.tbl_df`(w_de, language)
  8: stop("Unknown column '", i, "'", call. = FALSE)
  
  testthat results ================================================================
  OK: 31 SKIPPED: 0 FAILED: 4
  1. Error: Can download books from a data frame with gutenberg_id column (@test-download.R#40) 
  2. Error: gutenberg_works does appropriate filtering by default (@test-metadata.R#8) 
  3. Error: gutenberg_works takes filtering conditions (@test-metadata.R#17) 
  4. Error: gutenberg_works does appropriate filtering by language (@test-metadata.R#23) 
  
  Error: testthat unit tests failed
  Execution halted
```

