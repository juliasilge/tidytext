# tidytext 0.1.1

* Added documentation for n-grams, skip n-grams, and regex
* Added codecov and appveyor
* Added tidiers for LDA objects from topicmodels and a vignette on topic modeling
* Added function to calculate tf-idf of a tidy text dataset and a tf-idf vignette 
* Fixed a bug when tidying by line/sentence/paragraph/regex and there are multiple non-text columns
* Fixed a bug when unnesting using n-grams and skip n-grams (entire text was not being collapsed)
* Added ability to pass a (custom tokenizing) function to token. Also added a collapse argument that makes the choice whether to combine lines before tokenizing explicit.
* Changed tidy.dictionary to return a tbl_df rather than a data.frame
* Updated `cast_sparse` to work with dplyr 0.5.0
* Deprecated the `pair_count` function, which has been moved to `pairwise_count` in the [widyr package](https://github.com/dgrtwo/widyr). This will be removed entirely in a future version.

# tidytext 0.1.0

* Initial release for text mining using tidy tools



