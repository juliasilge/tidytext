## Resubmission

This is a resubmission. I have changed back to the CRAN template for the MIT license.

## Release Summary

This is the second CRAN release of tidytext. In this release, we fixed some bugs, added more documentation and better testing/CI, added a tidier for LDA objects, added an implementation of tf-idf, changed `unnest_tokens` so that the user can pass a custom tokenizing function to `token`, and deprecated the `pair_count` function (which has been moved to the widyr package at https://github.com/dgrtwo/widyr).

## Test environments
* Local OS X install, R 3.3.0
* Ubuntu 12.04 (on Travis-CI), R 3.3.0
* Win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 notes
