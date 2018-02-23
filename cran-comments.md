## Release Summary

This is the 8th CRAN release of tidytext. In this release, I updated various docs/tests so tidytext can build on R-oldrel. This is my 2nd attempt to get this to work, and a recent release of [quanteda](https://cran.r-project.org/package=quanteda) (in tidytext's Suggests) should allow tidytext to build on R-oldrel. I *am* testing/passing on Travis on R 3.3.3.

## Test environments

* Local OS X install, R 3.4.3
* Ubuntu 14.04 (on Travis-CI), R 3.4.3 and R 3.3.3
* Win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Downstream dependencies

I ran R CMD check on the 6 downstream dependencies (results at https://github.com/juliasilge/tidytext/tree/master/revdep) and there were no problems.
