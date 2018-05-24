# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.5.0 (2018-04-23) |
|system   |x86_64, darwin15.6.0         |
|ui       |RStudio (1.1.447)            |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |America/Sao_Paulo            |
|date     |2018-05-24                   |

## Packages

|package  |*  |version |date       |source                         |
|:--------|:--|:-------|:----------|:------------------------------|
|dplyr    |*  |0.7.5   |2018-05-19 |cran (@0.7.5)                  |
|tidyr    |   |0.8.1   |2018-05-18 |cran (@0.8.1)                  |
|tidytext |*  |0.1.9   |2018-05-24 |local (juliasilge/tidytext@NA) |

# Check results

3 packages with problems

|package   |version | errors| warnings| notes|
|:---------|:-------|------:|--------:|-----:|
|available |1.0.0   |      0|        1|     1|
|polmineR  |0.7.8   |      1|        0|     0|
|widyr     |0.1.1   |      0|        1|     0|

## available (1.0.0)
Maintainer: Jim Hester <james.f.hester@gmail.com>  
Bug reports: https://github.com/ropenscilabs/available/issues

0 errors | 1 warning  | 1 note 

```
checking examples ... WARNING
Found the following significant warnings:

  Warning: 'glue::collapse' is deprecated.
Deprecated functions may be defunct as soon as of the next release of
R.
See ?Deprecated.

checking package dependencies ... NOTE
Package suggested but not available for checking: ‘BiocInstaller’
```

## polmineR (0.7.8)
Maintainer: Andreas Blaette <andreas.blaette@uni-due.de>  
Bug reports: https://github.com/PolMine/polmineR/issues

1 error  | 0 warnings | 0 notes

```
checking examples ... ERROR
Running examples in ‘polmineR-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: textstat-class
> ### Title: S4 textstat class
> ### Aliases: textstat-class as.data.frame,textstat-method
> ###   show,textstat-method dim,textstat-method colnames,textstat-method
> ###   rownames,textstat-method names,textstat-method
... 15 lines ...
... get encoding: latin1
... get cpos and strucs
... getting counts for p-attribute(s): word
... using RcppCWB
> y <- cooccurrences(P, query = "Arbeit")
> y[1:25]
Error in get("View", envir = .GlobalEnv)(.Object@stat) : 
  View() should not be used in examples etc
Calls: <Anonymous> ... <Anonymous> -> view -> view -> .local -> <Anonymous>
Execution halted
** found \donttest examples: check also with --run-donttest
```

## widyr (0.1.1)
Maintainer: David Robinson <admiral.david@gmail.com>  
Bug reports: http://github.com/dgrtwo/widyr/issues

0 errors | 1 warning  | 0 notes

```
checking examples ... WARNING
Found the following significant warnings:

  Warning: 'glue::collapse' is deprecated.
  Warning: 'glue::collapse' is deprecated.
  Warning: 'glue::collapse' is deprecated.
  Warning: 'glue::collapse' is deprecated.
  Warning: 'glue::collapse' is deprecated.
  Warning: 'glue::collapse' is deprecated.
  Warning: 'glue::collapse' is deprecated.
  Warning: 'glue::collapse' is deprecated.
  Warning: 'glue::collapse' is deprecated.
Deprecated functions may be defunct as soon as of the next release of
R.
See ?Deprecated.
```

