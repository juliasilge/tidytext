## Release Summary

This is the 16th CRAN release of tidytext. This release improves argument handling in tokenizing functions and `reorder_within()`, moves the stopwords package to Suggests, and adds a `glance()` method for stm's estimated regressions. 

## Test environments

* local macOS install: release
* macOS 10.15.5 (on GitHub actions): release, devel
* ubuntu 16.04 (on GitHub actions): oldrel, release
* windows server 2019 10.0.17763 (on GitHub actions): release, devel
* win-builder: release, devel

## R CMD check results

0 errors | 0 warnings | 1 notes

I found the following note about a possibly invalid URL in the documentation, but the URL seems to be working fine:

  Found the following (possibly) invalid URLs:
    URL: https://www.cs.uic.edu/~liub/FBS/sentiment-analysis.html
      From: man/sentiments.Rd
      Status: Error
      Message: libcurl error code 60:
        	SSL certificate problem: certificate has expired
        	(Status without verification: OK)


## revdepcheck results

I checked 31 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * I saw 0 new problems
 * I failed to check 0 packages
