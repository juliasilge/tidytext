# funrar

<details>

* Version: 1.4.0
* Source code: https://github.com/cran/funrar
* URL: https://rekyt.github.io/funrar/
* BugReports: https://github.com/Rekyt/funrar/issues
* Date/Publication: 2020-03-05 14:50:02 UTC
* Number of recursive dependencies: 89

Run `revdep_details(,"funrar")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      [31m──[39m [31m1. Error: Conversion from tidy data.frame to sparse & dense matrices (@test-t[39m
      assignment of an object of class "numeric" is not valid for @'Dim' in an object of class "dgTMatrix"; is(value, "integer") is not TRUE
      [1mBacktrace:[22m
      [90m 1. [39mtestthat::expect_equal(...)
      [90m 4. [39mfunrar::stack_to_matrix(com_df, "species", "site", sparse = TRUE)
      [90m 5. [39mtidytext::cast_sparse_(my_df, col_to_row, col_to_col)
      [90m 6. [39mtidytext::cast_sparse(...)
      [90m 7. [39mMatrix::sparseMatrix(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 276 | SKIPPED: 0 | WARNINGS: 3 | FAILED: 1 ]
      1. Error: Conversion from tidy data.frame to sparse & dense matrices (@test-tidy_matrix.R#156) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

