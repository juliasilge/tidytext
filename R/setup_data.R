#' Set up dataset in the data/ folder
#'
#' This is run by package authors to set up all the datasets in data/.
setup_data <- function() {
  nrc_lexicon <- readr::read_tsv(system.file("extdata",
                                             "NRC-emotion-lexicon-wordlevel-alphabetized-v0.92.txt.zip",
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
  devtools::use_data(sentiments, overwrite = TRUE)

  SMART <- data_frame(word = tm::stopwords("SMART"), lexicon = "SMART")
  snowball <- data_frame(word = tm::stopwords("en"), lexicon = "snowball")
  onix <- data_frame(word = qdapDictionaries::OnixTxtRetToolkitSWL1, lexicon = "onix")

  stopwords <- bind_rows(SMART, snowball, onix)

  devtools::use_data(stopwords, overwrite = TRUE)

  parts_of_speech <- readr::read_csv("Noun,N
Plural,p
Noun Phrase,h
Verb (usu participle),V
Verb (transitive),t
Verb (intransitive),i
Adjective,A
Adverb,v
Conjunction,C
Preposition,P
Interjection,!
Pronoun,r
Definite Article,D
Indefinite Article,I
Nominative,o
", col_names = c("pos", "code"))

  # parts of speech
  moby_file <- system.file("extdata", "mobyposi.i.zip", package = "tidytext")
  partsofspeech <- readr::read_delim(moby_file, delim = "\xd7",
                               col_names = c("word", "code")) %>%
    tidyr::unnest(code = stringr::str_split(code, "")) %>%
    inner_join(parts_of_speech, by = "code") %>%
    filter(!stringr::str_detect(word, " ")) %>%
    mutate(word = stringr::str_to_lower(word)) %>%
    select(-code) %>%
    distinct()

  devtools::use_data(partsofspeech, overwrite = TRUE)
}
