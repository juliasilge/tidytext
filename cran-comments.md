## Release Summary

This is the 12th CRAN release of tidytext. The most important changes in this release is a change in how sentiment lexicons are accessed from package (remove NRC lexicon entirely, access AFINN and Loughran lexicons via textdata package so they are no longer included in this package). More minor changes include fixing bugs, lighter dependencies, helper functions for plotting, and documentation improvements. 

## Test environments

* Local OS X install, R 3.5.1
* Ubuntu 14.04 (on Travis-CI), R 3.5.1 and R 3.4.4
* Win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Downstream dependencies

I ran R CMD check on the 21 downstream dependencies (results at https://github.com/juliasilge/tidytext/tree/master/revdep) and sent updates to all maintainers who are impacted by the change in the sentiment lexicons (the only change in this release that impacted any downstream dependencies).

The following packages are impacted and have not yet updated:

- quanteda
- newsanchor
- ggpage
