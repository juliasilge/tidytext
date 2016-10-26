## Release Summary

This is the third CRAN release of tidytext. In this release, we fixed a bug in `cast_sparse`, `cast_dtm`, and other sparse casters relating to groups, changed `unnest_tokens` so that it no longer uses tidyr's unnest (for increased speed), added a check in `unnest_tokens` for list columns in the input, and added a `format` argument to unnest_tokens so that it can process html, xml, latex or man pages.

## Test environments
* Local OS X install, R 3.3.1
* Ubuntu 12.04 (on Travis-CI), R 3.3.1
* Win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Downstream dependencies

I ran R CMD check on the 3 downstream dependencies (results at https://github.com/juliasilge/tidytext/tree/master/revdep) and there were no problems.
