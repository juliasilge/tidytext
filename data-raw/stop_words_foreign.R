# From https://github.com/stopwords-iso/stopwords-iso
# Licence MIT https://github.com/stopwords-iso/stopwords-iso/blob/master/LICENSE 
stop_words_foreign <- jsonlite::read_json("https://raw.githubusercontent.com/stopwords-iso/stopwords-iso/master/stopwords-iso.json")

library(tidyverse)

turn_to_df <- function(list_element, name){
  tibble(word = list_element) %>%
    unnest()
}

stop_words_foreign <- purrr::modify(stop_words_foreign, turn_to_df)

# Remove the english stop word df 

stop_words_foreign$en <- NULL

# Test for use with french 
library(proustr)
sample <- proust_books()[1:3,]
library(tidytext)
unnest_tokens(sample, word, text) %>%
  anti_join(stop_words_foreign$en)

# Test for use with spanish
df <- tibble(text = c("Cumpliendo con mi oficio", "piedra con piedra, pluma a pluma", 
                      "pasa el invierno y deja", "sitios abandonados", "habitaciones muertas"))
unnest_tokens(df, word, text) %>%
  anti_join(stop_words_foreign$es)

# save data 
usethis::use_data(stop_words_foreign, overwrite = TRUE)

# Get matching list of name 

library(rvest)

page_1 <- read_html('https://github.com/stopwords-iso?page=1')
names <- page_1 %>% html_nodes('h3') %>% 
  html_nodes('a') %>% html_text() %>% gsub("\n        stopwords-(..)", "\\1", .)
full_names <- page_1 %>% html_nodes('.pr-4') %>% html_text() %>% 
  gsub("\n          ([a-zA-Z]*) stopwords collection\n        ", "\\1", .)

page_2 <- read_html('https://github.com/stopwords-iso?page=2')
names2 <- page_2 %>% html_nodes('h3') %>% 
  html_nodes('a') %>% html_text() %>% gsub("\n        stopwords-(..)", "\\1", .)
full_names2 <- page_2 %>% html_nodes('.pr-4') %>% html_text() %>% 
  gsub("\n          ([a-zA-Z]*) stopwords collection\n        ", "\\1", .)
