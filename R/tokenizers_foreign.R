#' @import hunspell
#' @import tokenizers
#' @importFrom glue glue
#'
tokenize_words_foreign <- function (x, lowercase = TRUE, stopwords = NULL, simplify = FALSE, language)
{
  tokenizers:::check_input(x)
  named <- names(x)
  if (lowercase)
    x <- stringi::stri_trans_tolower(x)
  out <- hunspell::hunspell_parse(x, dict = system.file(glue("extdata/{language}.dic"), package = "tidytext"))
  if (!is.null(named))
    names(out) <- named
  if (!is.null(stopwords))
    out <- lapply(out, function(x){x[!x %in% stopwords]}, stopwords)
  tokenizers:::simplify_list(out, simplify)
}


tokenize_ngrams_foreign <- function (x, lowercase = TRUE, n = 3L, n_min = n, stopwords = character(),
                                ngram_delim = " ", simplify = FALSE, language)
{
  tokenizers:::check_input(x)
  named <- names(x)
  if (n < n_min || n_min <= 0)
    stop("n and n_min must be integers, and n_min must be less than ",
         "n and greater than 1.")
  words <- hunspell::hunspell_parse(x, dict = system.file(glue("extdata/{language}.dic"), package = "tidytext"))
  out <- tokenizers:::generate_ngrams_batch(words, ngram_min = n_min, ngram_max = n,
                                            stopwords = stopwords, ngram_delim = ngram_delim)
  if (!is.null(named))
    names(out) <- named
  tokenizers:::simplify_list(out, simplify)
}

tokenize_skip_ngrams_foreign <- function (x, lowercase = TRUE, n = 3, k = 1, simplify = FALSE, language)
{
  tokenizers:::check_input(x)
  named <- names(x)
  words <- hunspell::hunspell_parse(x, dict = system.file(glue("extdata/{language}.dic"), package = "tidytext"))
  out <- lapply(words, tokenizers:::skip_ngrams, n = n, k = k)
  if (!is.null(named))
    names(out) <- named
  tokenizers:::simplify_list(out, simplify)
}

