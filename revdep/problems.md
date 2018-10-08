# crsra

Version: 0.2.3

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 500 marked UTF-8 strings
    ```

# fedregs

Version: 0.1.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      4: eval(quote(`_fseq`(`_lhs`)), env, env)
      5: eval(quote(`_fseq`(`_lhs`)), env, env)
      6: `_fseq`(`_lhs`)
      7: freduce(value, `_function_list`)
      8: function_list[[i]](value)
      9: tidyr::unnest(.)
      10: unnest.data.frame(.)
      11: abort(glue("Each column must either be a list of vectors or a list of ", "data frames [{probs}]"))
      
      ══ testthat results  ═══════════════════════════════════════════════════════════════════════════════════════════════════════════
      OK: 27 SKIPPED: 0 FAILED: 1
      1. Error: We can go all the way (@test-fedregs.R#145) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# fivethirtyeight

Version: 0.4.0

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.4Mb
      sub-directories of 1Mb or more:
        data   5.5Mb
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 1616 marked UTF-8 strings
    ```

# gutenbergr

Version: 0.1.4

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 13617 marked UTF-8 strings
    ```

# polmineR

Version: 0.7.10

## In both

*   checking examples ... ERROR
    ```
    ...
     6: 237     4
     7: 242     2
     8: 246     5
     9: 248     6
    10: 273     5
    11: 349     4
    12: 352     4
    13: 353     4
    14: 368     3
    15: 489     4
    16: 502     5
    17: 543     2
    18: 704     3
    19: 708     1
    > kwic("REUTERS", query = "oil")
    > cooccurrences("REUTERS", query = "oil")
    Warning in get("View", envir = .GlobalEnv)(.Object@stat) :
      unable to open display
    Error in .External2(C_dataviewer, x, title) : unable to start data viewer
    Calls: <Anonymous> ... <Anonymous> -> view -> view -> .local -> <Anonymous>
    Execution halted
    ```

# quanteda

Version: 1.3.4

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 71 marked UTF-8 strings
    ```

# rzeit2

Version: 0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘ggplot2’
      All declared Imports should be used.
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 841 marked UTF-8 strings
    ```

# statquotes

Version: 0.2.2

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘fortunes’
    ```

# tidymodels

Version: 0.0.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘broom’ ‘ggplot2’ ‘infer’ ‘pillar’ ‘recipes’ ‘rsample’
      ‘tidyposterior’ ‘tidypredict’ ‘tidytext’ ‘yardstick’
      All declared Imports should be used.
    ```

