pkgname <- "gutenbergr"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('gutenbergr')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("gutenberg_authors")
### * gutenberg_authors

flush(stderr()); flush(stdout())

### Name: gutenberg_authors
### Title: Metadata about Project Gutenberg authors
### Aliases: gutenberg_authors
### Keywords: datasets

### ** Examples


# date last updated
attr(gutenberg_authors, "date_updated")




cleanEx()
nameEx("gutenberg_download")
### * gutenberg_download

flush(stderr()); flush(stdout())

### Name: gutenberg_download
### Title: Download one or more works using a Project Gutenberg ID
### Aliases: gutenberg_download

### ** Examples


## Not run: 
##D library(dplyr)
##D 
##D # download The Count of Monte Cristo
##D gutenberg_download(1184)
##D 
##D # download two books: Wuthering Heights and Jane Eyre
##D books <- gutenberg_download(c(768, 1260), meta_fields = "title")
##D books
##D books %>% count(title)
##D 
##D # download all books from Jane Austen
##D austen <- gutenberg_works(author == "Austen, Jane") %>%
##D   gutenberg_download(meta_fields = "title")
##D 
##D austen
##D austen %>%
##D  count(title)
## End(Not run)




cleanEx()
nameEx("gutenberg_metadata")
### * gutenberg_metadata

flush(stderr()); flush(stdout())

### Name: gutenberg_metadata
### Title: Gutenberg metadata about each work
### Aliases: gutenberg_metadata
### Keywords: datasets

### ** Examples


library(dplyr)
library(stringr)

gutenberg_metadata

gutenberg_metadata %>%
  count(author, sort = TRUE)

# look for Shakespeare, excluding collections (containing "Works") and translations
shakespeare_metadata <- gutenberg_metadata %>%
  filter(author == "Shakespeare, William",
         language == "en",
         !str_detect(title, "Works"),
         has_text,
         !str_detect(rights, "Copyright")) %>%
         distinct(title)

## Not run: 
##D shakespeare_works <- gutenberg_download(shakespeare_metadata$gutenberg_id)
## End(Not run)

# note that the gutenberg_works() function filters for English
# non-copyrighted works and does de-duplication by default:

shakespeare_metadata2 <- gutenberg_works(author == "Shakespeare, William",
                                         !str_detect(title, "Works"))

# date last updated
attr(gutenberg_metadata, "date_updated")




cleanEx()
nameEx("gutenberg_strip")
### * gutenberg_strip

flush(stderr()); flush(stdout())

### Name: gutenberg_strip
### Title: Strip header and footer content from a Project Gutenberg book
### Aliases: gutenberg_strip

### ** Examples


library(dplyr)
book <- gutenberg_works(title == "Pride and Prejudice") %>%
  gutenberg_download(strip = FALSE)

head(book$text, 10)
tail(book$text, 10)

text_stripped <- gutenberg_strip(book$text)

head(text_stripped, 10)
tail(text_stripped, 10)




cleanEx()
nameEx("gutenberg_subjects")
### * gutenberg_subjects

flush(stderr()); flush(stdout())

### Name: gutenberg_subjects
### Title: Gutenberg metadata about the subject of each work
### Aliases: gutenberg_subjects
### Keywords: datasets

### ** Examples


library(dplyr)
library(stringr)

gutenberg_subjects %>%
  filter(subject_type == "lcsh") %>%
  count(subject, sort = TRUE)

sherlock_holmes_subjects <- gutenberg_subjects %>%
  filter(str_detect(subject, "Holmes, Sherlock"))

sherlock_holmes_subjects

sherlock_holmes_metadata <- gutenberg_works() %>%
  filter(author == "Doyle, Arthur Conan") %>%
  semi_join(sherlock_holmes_subjects, by = "gutenberg_id")

sherlock_holmes_metadata

## Not run: 
##D holmes_books <- gutenberg_download(sherlock_holmes_metadata$gutenberg_id)
##D 
##D holmes_books
## End(Not run)

# date last updated
attr(gutenberg_subjects, "date_updated")




cleanEx()
nameEx("gutenberg_works")
### * gutenberg_works

flush(stderr()); flush(stdout())

### Name: gutenberg_works
### Title: Get a filtered table of Gutenberg work metadata
### Aliases: gutenberg_works

### ** Examples


library(dplyr)

gutenberg_works()

# filter conditions
gutenberg_works(author == "Shakespeare, William")

# language specifications

gutenberg_works(languages = "es") %>%
  count(language, sort = TRUE)

gutenberg_works(languages = c("en", "es")) %>%
  count(language, sort = TRUE)

gutenberg_works(languages = c("en", "es"), all_languages = TRUE) %>%
  count(language, sort = TRUE)

gutenberg_works(languages = c("en", "es"), only_languages = FALSE) %>%
  count(language, sort = TRUE)




### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
