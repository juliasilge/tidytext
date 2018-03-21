## Release Summary

This is the 9th CRAN release of tidytext. This release contains updates to documentation, a new option for tokenization (character shingles), and an update to tests based on the recent release of [tokenizers](https://cran.r-project.org/package=tokenizers). 

## Test environments

* Local OS X install, R 3.4.4
* Ubuntu 14.04 (on Travis-CI), R 3.4.4 and R 3.3.3
* Win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 notes

On Travis and win-builder, there *are* currently failures due to the very fresh submission of tokenizers to CRAN; binaries have not been built yet. The only failures are those I expect to see because of the difference between the old and new versions of tokenizers.

## Downstream dependencies

I ran R CMD check on the 7 downstream dependencies (results at https://github.com/juliasilge/tidytext/tree/master/revdep) and there were no problems.
