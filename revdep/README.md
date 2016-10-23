# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.3.1 (2016-06-21) |
|system   |x86_64, darwin13.4.0         |
|ui       |RStudio (0.99.1266)          |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |America/Denver               |
|date     |2016-10-22                   |

## Packages

|package  |*  |version |date       |source           |
|:--------|:--|:-------|:----------|:----------------|
|tidytext |   |0.1.2   |2016-10-23 |local (NA/NA@NA) |

# Check results
3 packages

## gutenbergr (0.1.2)
Maintainer: David Robinson <admiral.david@gmail.com>  
Bug reports: http://github.com/ropenscilabs/gutenbergr/issues

0 errors | 0 warnings | 0 notes

## monkeylearn (0.1.1)
Maintainer: Maëlle Salmon <maelle.salmon@yahoo.se>  
Bug reports: http://github.com/ropenscilabs/monkeylearn/issues

0 errors | 0 warnings | 0 notes

## statquotes (0.2)
Maintainer: Michael Friendly <friendly@yorku.ca>  
Bug reports: https://github.com/friendly/statquotes/issues

1 error  | 0 warnings | 1 note 

```
checking examples ... ERROR
Running examples in ‘statquotes-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: quote_cloud
> ### Title: Function to generate word cloud based upon quote database
> ### Aliases: quote_cloud
> 
> ### ** Examples
> 
> quote_cloud()
Error in ret[[output_col]] <- unlist(output_lst) : 
  more elements supplied than there are to replace
Calls: quote_cloud -> <Anonymous> -> unnest_tokens_
Execution halted

checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: ‘fortunes’
```

