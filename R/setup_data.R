#' Set up dataset in the data/ folder
#'
#' This is run by package authors to set up all the datasets in data/.
setup_data <- function() {
  nrc_lexicon <- readr::read_tsv(system.file("extdata",
                                             "NRC-emotion-lexicon-wordlevel-alphabetized-v0.92.txt",
                                             package = "tidytext"),
                                 col_names = FALSE, skip = 46)
  nrc_lexicon <- nrc_lexicon %>% filter(X3 == 1) %>%
    select(word = X1, sentiment = X2) %>%
    mutate(lexicon = "nrc")

  bing_lexicon1 <- readr::read_lines(system.file("extdata",
                                                 "positive-words.txt",
                                                 package = "tidytext"),
                                     skip = 35)
  bing_lexicon2 <- readr::read_lines(system.file("extdata",
                                                 "negative-words.txt",
                                                 package = "tidytext"),
                                      skip = 35)
  bing_lexicon1 <- data_frame(word = bing_lexicon1) %>%
    mutate(sentiment = "positive", lexicon = "bing")
  bing_lexicon2 <- data_frame(word = bing_lexicon2) %>%
    mutate(sentiment = "negative", lexicon = "bing")
  bing_lexicon <- bind_rows(bing_lexicon1, bing_lexicon2) %>% arrange(word)

  AFINN_lexicon <- readr::read_tsv(system.file("extdata",
                                               "AFINN-111.txt",
                                               package = "tidytext"),
                                   col_names = FALSE)
  AFINN_lexicon <- AFINN_lexicon %>%
    transmute(word = X1, sentiment = NA, score = X2, lexicon = "AFINN")

  sentiments <- bind_rows(nrc_lexicon, bing_lexicon, AFINN_lexicon)

  SMART <- data_frame(word = tm::stopwords("SMART"), lexicon = "SMART")
  snowball <- data_frame(word = tm::stopwords("en"), lexicon = "snowball")
  onix <- data_frame(word = qdapDictionaries::OnixTxtRetToolkitSWL1, lexicon = "onix")

  stopwords <- bind_rows(SMART, snowball, onix)

  devtools::use_data(stopwords, overwrite = TRUE)

  # parts of speech
  moby_file <- system.file("extdata", "mobyposi.i", package = "tidytext")
  mobypos <- readr::read_delim(moby_file, delim = "\xd7", ) %>%
    tidyr::unnest(pos = str_split(AN, ""))
}
