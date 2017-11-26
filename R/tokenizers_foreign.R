#' @import hunspell
#' @import tokenizers
#' @importFrom glue glue
#' @importFrom stringi stri_trans_tolower
#'
#' @include utils.R
#'
tokenize_words_foreign <- function (x, lowercase = TRUE, stopwords = NULL, simplify = FALSE, language, custom = NULL)
{
  tokenizers_check_input(x)
  named <- names(x)
  if (lowercase)
    x <- stringi::stri_trans_tolower(x)
  if (!is.null(custom)) {
    out <- hunspell::hunspell_parse(x, dict = custom)
  } else {
    out <- hunspell::hunspell_parse(x, dict = system.file(glue("extdata/{language}.aff"), package = "tidytext"))
  }
  if (!is.null(named))
    names(out) <- named
  if (!is.null(stopwords))
    out <- lapply(out, function(x){x[!x %in% stopwords]}, stopwords)
  tokenizers_simplify_list(out, simplify)
}


tokenize_ngrams_foreign <- function (x, lowercase = TRUE, n = 3L, n_min = n, stopwords = character(),
                                ngram_delim = " ", simplify = FALSE, language, custom = NULL)
{
  tokenizers_check_input(x)
  named <- names(x)
  if (n < n_min || n_min <= 0)
    stop("n and n_min must be integers, and n_min must be less than ",
         "n and greater than 1.")
  if (!is.null(custom)) {
    words <- hunspell::hunspell_parse(x, dict = custom)
  } else {
    words <- hunspell::hunspell_parse(x, dict = system.file(glue("extdata/{language}.aff"), package = "tidytext"))
  }
  words <- hunspell::hunspell_parse(x, dict = system.file(glue("extdata/{language}.aff"), package = "tidytext"))
  out <- tokenizers_generate_ngrams_batch(words, ngram_min = n_min, ngram_max = n,
                                            stopwords = stopwords, ngram_delim = ngram_delim)
  if (!is.null(named))
    names(out) <- named
  tokenizers:::simplify_list(out, simplify)
}

tokenize_skip_ngrams_foreign <- function (x, lowercase = TRUE, n = 3, k = 1, simplify = FALSE, language, custom = NULL)
{
  tokenizers_check_input(x)
  named <- names(x)
  if (!is.null(custom)) {
    words <- hunspell::hunspell_parse(x, dict = custom)
  } else {
    words <- hunspell::hunspell_parse(x, dict = system.file(glue("extdata/{language}.aff"), package = "tidytext"))
  }
  out <- lapply(words, tokenizers_skip_ngrams, n = n, k = k)
  if (!is.null(named))
    names(out) <- named
  tokenizers_simplify_list(out, simplify)
}


