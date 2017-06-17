# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.4.0 (2017-04-21) |
|system   |x86_64, darwin15.6.0         |
|ui       |RStudio (1.0.143)            |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |America/Denver               |
|date     |2017-06-17                   |

## Packages

|package  |*  |version   |date       |source                         |
|:--------|:--|:---------|:----------|:------------------------------|
|tidytext |*  |0.1.2.900 |2017-06-17 |local (juliasilge/tidytext@NA) |

# Check results

3 packages

|package         |version | errors| warnings| notes|
|:---------------|:-------|------:|--------:|-----:|
|fivethirtyeight |0.2.0   |      0|        0|     1|
|gutenbergr      |0.1.2   |      1|        0|     0|
|statquotes      |0.2     |      0|        0|     1|

## fivethirtyeight (0.2.0)
Maintainer: Albert Y. Kim <albert.ys.kim@gmail.com>  
Bug reports: https://github.com/rudeboybert/fivethirtyeight/issues

0 errors | 0 warnings | 1 note 

```
checking installed package size ... NOTE
  installed size is  6.3Mb
  sub-directories of 1Mb or more:
    data   3.1Mb
    doc    3.0Mb
```

## gutenbergr (0.1.2)
Maintainer: David Robinson <admiral.david@gmail.com>  
Bug reports: http://github.com/ropenscilabs/gutenbergr/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
  Running ‘testthat.R’
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  > library(testthat)
  > library(gutenbergr)
  > 
  > test_check("gutenbergr")
  1. Failure: read_zip_url can download and read a zip file (@test-utils.R#7) ----
  any(z == "Congress shall make no law respecting an establishment of religion,") isn't true.
  
  
  testthat results ================================================================
  OK: 46 SKIPPED: 0 FAILED: 1
  1. Failure: read_zip_url can download and read a zip file (@test-utils.R#7) 
  
  Error: testthat unit tests failed
  Execution halted
```

## statquotes (0.2)
Maintainer: Michael Friendly <friendly@yorku.ca>  
Bug reports: https://github.com/friendly/statquotes/issues

0 errors | 0 warnings | 1 note 

```
checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: ‘fortunes’
```

