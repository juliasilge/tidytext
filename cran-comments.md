## Release Summary

This is the 19th CRAN release of tidytext. This release updates tidytext for the recent quanteda release, as requested by CRAN. This release also checks for the installation of the stopwords package more gracefully.

## Test environments

* local macOS install: release
* macOS 10.15.7 (on GitHub actions): release
* windows server 2019 10.0.17763 (on GitHub actions): release
* ubuntu 20.04 (on GitHub actions): oldrel, release, devel
* win-builder: release, devel

## R CMD check results

0 errors | 0 warnings | 0 notes


## revdepcheck results

I checked 40 reverse dependencies (39 from CRAN + 1 from BioConductor), comparing R CMD check results across CRAN and dev versions of this package.

 * I saw 0 new problems
 * I failed to check 4 packages

Issues with CRAN packages are summarized below.

### Failed to check

* kdtools (no longer on CRAN)
* mvrsquared
* quanteda
* textmineR
