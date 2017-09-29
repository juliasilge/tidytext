# tidytext 0.1.4

* Fix tidier for quanteda dictionary for correct class (#71).
* Add a [pkgdown site](https://juliasilge.github.io/tidytext).
* Convert NSE from underscored function to tidyeval (`unnest_tokens`, `bind_tf_idf`, all sparse casters) (#67, #74).
* Added tidiers for topic models from the `stm` package (#51).

# tidytext 0.1.3

* `get_sentiments` now works regardless of whether `tidytext` has been loaded or not (#50).
* `unnest_tokens` now supports data.table objects (#37).
* Fixed `to_lower` parameter in `unnest_tokens` to work properly for all tokenizing options.
* Updated `tidy.corpus`, `glance.corpus`, tests, and vignette for changes to quanteda API 
* Removed the deprecated `pair_count` function, which is now in the in-development widyr package
* Added tidiers for LDA models from the `mallet` package
* Added the Loughran and McDonald dictionary of sentiment words specific to financial reports
* `unnest_tokens` preserves custom attributes of data frames and data.tables

# tidytext 0.1.2

* Updated DESCRIPTION to require purrr >= 0.1.1.
* Fixed `cast_sparse`, `cast_dtm`, and other sparse casters to ignore groups in the input (#19)
* Changed `unnest_tokens` so that it no longer uses tidyr's unnest, but rather a custom version that removes some overhead. In some experiments, this sped up unnest_tokens on large inputs by about 40%. This also moves tidyr from Imports to Suggests for now.
* `unnest_tokens` now checks that there are no list columns in the input, and raises an error if present (since those cannot be unnested).
* Added a `format` argument to unnest_tokens so that it can process html, xml, latex or man pages using the hunspell package, though only when `token = "words"`.
* Added a `get_sentiments` function that takes the name of a lexicon ("nrc", "bing", or "sentiment") and returns just that sentiment data frame (#25)

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



