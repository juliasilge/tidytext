## Release Summary

This is the 15th CRAN release of tidytext. This release fixes a test (related to the new version of tibble), improves error handling throughout, and finally deprecates some functions that have been soft-deprecated for a very long time. 

## Test environments

* local OS X install: release
* travis-ci ubuntu 14.04: devel, release, oldrel
* win-builder: devel, release

## R CMD check results

0 errors | 0 warnings | 0 notes

## revdepcheck results

I checked 26 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

* I saw 1 new problem
* I failed to check 1 package

Issues with CRAN packages are summarised below.

### New problems

* [funrar](https://cran.r-project.org/package=funrar) is impacted by this release; I sent a [patch to them in this PR](https://github.com/Rekyt/funrar/pull/42) that fixes the problem but have not heard back yet

### Failed to check

* kdtools (NA)
