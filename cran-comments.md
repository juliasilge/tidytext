## Release Summary

This is the 18th CRAN release of tidytext. This release uses vdiffr conditionally in tests, as requested due to M1 macOS issues. This release also fixes a long-standing bug and provides more consistent behavior with the `collapse` argument to `unnest_tokens()`.

## Test environments

* local macOS install: release
* macOS 10.15.7 (on GitHub actions): release
* windows server 2019 10.0.17763 (on GitHub actions): release
* ubuntu 20.04 (on GitHub actions): oldrel, release, devel
* win-builder: release, devel

## R CMD check results

0 errors | 0 warnings | 0 notes


## revdepcheck results

I checked 31 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * I saw 0 new problems
 * I failed to check 0 packages
