pkgname <- "quanteda"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('quanteda')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("View")
### * View

flush(stderr()); flush(stdout())

### Name: View
### Title: View methods for quanteda
### Aliases: View View.default View.kwic View.dfm
### Keywords: View internal

### ** Examples

## Not run: 
##D ## for kwic
##D View(kwic(data_char_ukimmig2010, "illeg*"))
##D 
##D ## for data.frame
##D View(dfm(data_char_ukimmig2010))
## End(Not run)



cleanEx()
nameEx("affinity")
### * affinity

flush(stderr()); flush(stdout())

### Name: affinity
### Title: Internal function to fit the likelihood scaling mixture model.
### Aliases: affinity
### Keywords: internal textmodel

### ** Examples

p <- matrix(c(c(5/6, 0, 1/6), c(0, 4/5, 1/5)), nrow = 3,
            dimnames = list(c("A", "B", "C"), NULL))
theta <- c(.2, .8)
q <- drop(p %*% theta)
x <- 2 * q
(fit <- affinity(p, x))



cleanEx()
nameEx("as.dictionary")
### * as.dictionary

flush(stderr()); flush(stdout())

### Name: as.dictionary
### Title: Coercion and checking functions for dictionary objects
### Aliases: as.dictionary is.dictionary

### ** Examples

## Not run: 
##D data(sentiments, package = "tidytext")
##D as.dictionary(subset(sentiments, lexicon == "nrc"))
##D as.dictionary(subset(sentiments, lexicon == "bing"))
##D # to convert AFINN into polarities - adjust thresholds if desired
##D afinn <- subset(sentiments, lexicon == "AFINN")
##D afinn[["sentiment"]] <-
##D     with(afinn,
##D          sentiment <- ifelse(score < 0, "negative",
##D                              ifelse(score > 0, "positive", "netural"))
##D     )
##D with(afinn, table(score, sentiment))
##D as.dictionary(afinn)
## End(Not run)

is.dictionary(dictionary(list(key1 = c("val1", "val2"), key2 = "val3")))
## [1] TRUE
is.dictionary(list(key1 = c("val1", "val2"), key2 = "val3"))
## [1] FALSE



cleanEx()
nameEx("as.list.dist")
### * as.list.dist

flush(stderr()); flush(stdout())

### Name: as.list.dist
### Title: Coerce a dist object into a list
### Aliases: as.list.dist

### ** Examples

## Not run: 
##D ## compare to tm
##D 
##D # tm version
##D require(tm)
##D data("crude")
##D crude <- tm_map(crude, content_transformer(tolower))
##D crude <- tm_map(crude, remove_punctuation)
##D crude <- tm_map(crude, remove_numbers)
##D crude <- tm_map(crude, stemDocument)
##D tdm <- TermDocumentMatrix(crude)
##D findAssocs(tdm, c("oil", "opec", "xyz"), c(0.75, 0.82, 0.1))
##D 
##D # in quanteda
##D quantedaDfm <- as.dfm(t(as.matrix(tdm)))
##D as.list(textstat_dist(quantedaDfm, c("oil", "opec", "xyz"), margin = "features"), n = 14)
##D 
##D # in base R
##D corMat <- as.matrix(proxy::simil(as.matrix(quantedaDfm), by_rows = FALSE))
##D round(head(sort(corMat[, "oil"], decreasing = TRUE), 14), 2)
##D round(head(sort(corMat[, "opec"], decreasing = TRUE), 9), 2)
## End(Not run) 



cleanEx()
nameEx("as.matrix.dfm")
### * as.matrix.dfm

flush(stderr()); flush(stdout())

### Name: as.matrix.dfm
### Title: Coerce a dfm to a matrix or data.frame
### Aliases: as.matrix.dfm
### Keywords: dfm

### ** Examples

# coercion to matrix
as.matrix(data_dfm_lbgexample[, 1:10])




cleanEx()
nameEx("as.tokens")
### * as.tokens

flush(stderr()); flush(stdout())

### Name: as.tokens
### Title: Coercion, checking, and combining functions for tokens objects
### Aliases: as.tokens as.tokens.list as.tokens.spacyr_parsed
###   as.list.tokens unlist.tokens as.character.tokens is.tokens +.tokens
###   c.tokens

### ** Examples


# create tokens object from list of characters with custom concatenator
dict <- dictionary(list(country = "United States", 
                   sea = c("Atlantic Ocean", "Pacific Ocean")))
lis <- list(c("The", "United-States", "has", "the", "Atlantic-Ocean", 
              "and", "the", "Pacific-Ocean", "."))
toks <- as.tokens(lis, concatenator = "-")
tokens_lookup(toks, dict)

# combining tokens
toks1 <- tokens(c(doc1 = "a b c d e", doc2 = "f g h"))
toks2 <- tokens(c(doc3 = "1 2 3"))
toks1 + toks2
c(toks1, toks2)




cleanEx()
nameEx("as.yaml")
### * as.yaml

flush(stderr()); flush(stdout())

### Name: as.yaml
### Title: Convert quanteda dictionary objects to the YAML format
### Aliases: as.yaml

### ** Examples

## Not run: 
##D dict <- dictionary(list(one = c("a b", "c*"), two = c("x", "y", "z??")))
##D cat(yaml <- as.yaml(dict))
##D cat(yaml, file = (yamlfile <- paste0(tempfile(), ".yml")))
##D dictionary(file = yamlfile)
## End(Not run)



cleanEx()
nameEx("bootstrap_dfm")
### * bootstrap_dfm

flush(stderr()); flush(stdout())

### Name: bootstrap_dfm
### Title: Bootstrap a dfm
### Aliases: bootstrap_dfm
### Keywords: bootstrap dfm experimental

### ** Examples

# bootstrapping from the original text
txt <- c(textone = "This is a sentence.  Another sentence.  Yet another.", 
         texttwo = "Premiere phrase.  Deuxieme phrase.")
bootstrap_dfm(txt, n = 3)
         



cleanEx()
nameEx("cbind.dfm")
### * cbind.dfm

flush(stderr()); flush(stdout())

### Name: cbind.dfm
### Title: Combine dfm objects by Rows or Columns
### Aliases: cbind.dfm rbind.dfm
### Keywords: dfm internal

### ** Examples

# cbind() for dfm objects
(dfm1 <- dfm(c("a b c d", "c d e f")))
(dfm2 <- dfm(c("a b", "x y z")))
cbind(dfm1, dfm2)
cbind(dfm1, 100)
cbind(100, dfm1)
cbind(dfm1, matrix(c(101, 102), ncol = 1))
cbind(matrix(c(101, 102), ncol = 1), dfm1)


# rbind() for dfm objects
(dfm1 <- dfm(c(doc1 = "This is one sample text sample."), verbose = FALSE))
(dfm2 <- dfm(c(doc2 = "One two three text text."), verbose = FALSE))
(dfm3 <- dfm(c(doc3 = "This is the fourth sample text."), verbose = FALSE))
rbind(dfm1, dfm2)
rbind(dfm1, dfm2, dfm3)



cleanEx()
nameEx("char_tolower")
### * char_tolower

flush(stderr()); flush(stdout())

### Name: char_tolower
### Title: Convert the case of character objects
### Aliases: char_tolower char_toupper

### ** Examples

txt <- c(txt1 = "b A A", txt2 = "C C a b B")
char_tolower(txt) 
char_toupper(txt)

# with acronym preservation
txt2 <- c(text1 = "England and France are members of NATO and UNESCO", 
          text2 = "NASA sent a rocket into space.")
char_tolower(txt2)
char_tolower(txt2, keep_acronyms = TRUE)
char_toupper(txt2)



cleanEx()
nameEx("convert-wrappers")
### * convert-wrappers

flush(stderr()); flush(stdout())

### Name: convert-wrappers
### Title: Convenience wrappers for dfm convert
### Aliases: convert-wrappers as.wfm as.DocumentTermMatrix dfm2lda
### Keywords: internal

### ** Examples

mycorpus <- corpus_subset(data_corpus_inaugural, Year > 1970)
quantdfm <- dfm(mycorpus, verbose = FALSE)

# shortcut conversion to austin package's wfm format
identical(as.wfm(quantdfm), convert(quantdfm, to = "austin"))

## Not run: 
##D # shortcut conversion to tm package's DocumentTermMatrix format
##D identical(as.DocumentTermMatrix(quantdfm), convert(quantdfm, to = "tm"))
## End(Not run)

## Not run: 
##D # shortcut conversion to lda package list format
##D identical(dfm2lda(quantdfm), convert(quantdfm, to = "lda")) 
## End(Not run)




cleanEx()
nameEx("convert")
### * convert

flush(stderr()); flush(stdout())

### Name: convert
### Title: Convert a dfm to a non-quanteda format
### Aliases: convert

### ** Examples

mycorpus <- corpus_subset(data_corpus_inaugural, Year > 1970)
quantdfm <- dfm(mycorpus, verbose = FALSE)

# austin's wfm format
identical(dim(quantdfm), dim(convert(quantdfm, to = "austin")))

# stm package format
stmdfm <- convert(quantdfm, to = "stm")
str(stmdfm)

#' # triplet
triplet <- convert(quantdfm, to = "tripletlist")
str(triplet)

# illustrate what happens with zero-length documents
quantdfm2 <- dfm(c(punctOnly = "!!!", mycorpus[-1]), verbose = FALSE)
rowSums(quantdfm2)
stmdfm2 <- convert(quantdfm2, to = "stm", docvars = docvars(mycorpus))
str(stmdfm2)

## Not run: 
##D # tm's DocumentTermMatrix format
##D tmdfm <- convert(quantdfm, to = "tm")
##D str(tmdfm)
##D 
##D # topicmodels package format
##D str(convert(quantdfm, to = "topicmodels"))
##D 
##D # lda package format
##D ldadfm <- convert(quantdfm, to = "lda")
##D str(ldadfm)
##D 
## End(Not run)



cleanEx()
nameEx("corpus-class")
### * corpus-class

flush(stderr()); flush(stdout())

### Name: corpus-class
### Title: Base method extensions for corpus objects
### Aliases: corpus-class print.corpus is.corpus is.corpuszip
###   print.summary.corpus +.corpus c.corpus [.corpus [[.corpus [[<-.corpus
###   str.corpus
### Keywords: corpus internal

### ** Examples


# concatenate corpus objects
corpus1 <- corpus(data_char_ukimmig2010[1:2])
corpus2 <- corpus(data_char_ukimmig2010[3:4])
corpus3 <- corpus(data_char_ukimmig2010[5:6])
summary(c(corpus1, corpus2, corpus3))

# ways to index corpus elements
data_corpus_inaugural["1793-Washington"]    # 2nd Washington inaugural speech
data_corpus_inaugural[2]                    # same
# access the docvars from data_corpus_irishbudget2010
data_corpus_irishbudget2010[, "year"]
# same
data_corpus_irishbudget2010[["year"]]            

# create a new document variable
data_corpus_irishbudget2010[["govtopp"]] <- 
    ifelse(data_corpus_irishbudget2010[["party"]] %in% c("FF", "Greens"), 
           "Government", "Opposition")
docvars(data_corpus_irishbudget2010)



cleanEx()
nameEx("corpus")
### * corpus

flush(stderr()); flush(stdout())

### Name: corpus
### Title: Construct a corpus object
### Aliases: corpus corpus.corpus corpus.character corpus.data.frame
###   corpus.kwic corpus.Corpus
### Keywords: corpus

### ** Examples

# create a corpus from texts
corpus(data_char_ukimmig2010)

# create a corpus from texts and assign meta-data and document variables
summary(corpus(data_char_ukimmig2010,
               docvars = data.frame(party = names(data_char_ukimmig2010))), 5)

corpus(texts(data_corpus_irishbudget2010))

# import a tm VCorpus
if (requireNamespace("tm", quietly = TRUE)) {
    data(crude, package = "tm")    # load in a tm example VCorpus
    mytmCorpus <- corpus(crude)
    summary(mytmCorpus, showmeta=TRUE)

    data(acq, package = "tm")
    summary(corpus(acq), 5, showmeta=TRUE)

    tmCorp <- tm::VCorpus(tm::VectorSource(data_char_ukimmig2010))
    quantCorp <- corpus(tmCorp)
    summary(quantCorp)
}

# construct a corpus from a data.frame
mydf <- data.frame(letter_factor = factor(rep(letters[1:3], each = 2)),
                  some_ints = 1L:6L,
                  some_text = paste0("This is text number ", 1:6, "."),
                  stringsAsFactors = FALSE,
                  row.names = paste0("fromDf_", 1:6))
mydf
summary(corpus(mydf, text_field = "some_text",
               metacorpus = list(source = "From a data.frame called mydf.")))

# construct a corpus from a kwic object
mykwic <- kwic(data_corpus_inaugural, "southern")
summary(corpus(mykwic))
# from a kwic
kw <- kwic(data_char_sampletext, "econom*")
summary(corpus(kw))
summary(corpus(kw, split_context = FALSE))
texts(corpus(kw, split_context = FALSE))




cleanEx()
nameEx("corpus_reshape")
### * corpus_reshape

flush(stderr()); flush(stdout())

### Name: corpus_reshape
### Title: Recast the document units of a corpus
### Aliases: corpus_reshape
### Keywords: corpus

### ** Examples

# simple example
corp <- corpus(c(textone = "This is a sentence.  Another sentence.  Yet another.", 
                 textwo = "Premiere phrase.  Deuxieme phrase."), 
                 docvars = data.frame(country=c("UK", "USA"), year=c(1990, 2000)),
                 metacorpus = list(notes = "Example showing how corpus_reshape() works."))
summary(corp)
summary(corpus_reshape(corp, to = "sentences"), showmeta = TRUE)

# example with inaugural corpus speeches
(corp2 <- corpus_subset(data_corpus_inaugural, Year>2004))
corp2_para <- corpus_reshape(corp2, to="paragraphs")
corp2_para
summary(corp2_para, 100, showmeta = TRUE)
## Note that Bush 2005 is recorded as a single paragraph because that text 
## used a single \n to mark the end of a paragraph.



cleanEx()
nameEx("corpus_sample")
### * corpus_sample

flush(stderr()); flush(stdout())

### Name: corpus_sample
### Title: Randomly sample documents from a corpus
### Aliases: corpus_sample
### Keywords: corpus

### ** Examples

# sampling from a corpus
summary(corpus_sample(data_corpus_inaugural, 5)) 
summary(corpus_sample(data_corpus_inaugural, 10, replace = TRUE))

# sampling sentences within document
doccorpus <- corpus(c(one = "Sentence one.  Sentence two.  Third sentence.",
                      two = "First sentence, doc2.  Second sentence, doc2."))
sentcorpus <- corpus_reshape(doccorpus, to = "sentences")
texts(sentcorpus)
texts(corpus_sample(sentcorpus, replace = TRUE, by = "document"))



cleanEx()
nameEx("corpus_segment")
### * corpus_segment

flush(stderr()); flush(stdout())

### Name: corpus_segment
### Title: Segment texts on a pattern match
### Aliases: corpus_segment char_segment
### Keywords: character corpus

### ** Examples

## segmenting a corpus

# segmenting a corpus using tags
corp <- corpus(c("##INTRO This is the introduction.
                  ##DOC1 This is the first document.  Second sentence in Doc 1.
                  ##DOC3 Third document starts here.  End of third document.",
                 "##INTRO Document ##NUMBER Two starts before ##NUMBER Three."))
corp_seg <- corpus_segment(corp, "##*")
cbind(texts(corp_seg), docvars(corp_seg), metadoc(corp_seg))

# segmenting a transcript based on speaker identifiers
corp2 <- corpus("Mr. Smith: Text.\nMrs. Jones: More text.\nMr. Smith: I'm speaking, again.")
corp_seg2 <- corpus_segment(corp2, pattern = "\\b[A-Z].+\\s[A-Z][a-z]+:",
                            valuetype = "regex")
cbind(texts(corp_seg2), docvars(corp_seg2), metadoc(corp_seg2))

# segmenting a corpus using crude end-of-sentence segmentation
corp_seg3 <- corpus_segment(corp, pattern = ".", valuetype = "fixed", 
                            pattern_position = "after", extract_pattern = FALSE)
cbind(texts(corp_seg3), docvars(corp_seg3), metadoc(corp_seg3))

## segmenting a character vector

# segment into paragraphs and removing the "- " bullet points
cat(data_char_ukimmig2010[4])
char_segment(data_char_ukimmig2010[4], 
             pattern = "\\n\\n(\\-\\s){0,1}", valuetype = "regex", 
             remove_pattern = TRUE)

# segment a text into clauses
txt <- c(d1 = "This, is a sentence?  You: come here.", d2 = "Yes, yes okay.")
char_segment(txt, pattern = "\\p{P}", valuetype = "regex", 
             pattern_position = "after", remove_pattern = FALSE)



cleanEx()
nameEx("corpus_subset")
### * corpus_subset

flush(stderr()); flush(stdout())

### Name: corpus_subset
### Title: Extract a subset of a corpus
### Aliases: corpus_subset
### Keywords: corpus

### ** Examples

summary(corpus_subset(data_corpus_inaugural, Year > 1980))
summary(corpus_subset(data_corpus_inaugural, Year > 1930 & President == "Roosevelt", 
                      select = Year))



cleanEx()
nameEx("corpus_trim")
### * corpus_trim

flush(stderr()); flush(stdout())

### Name: corpus_trim
### Title: Remove sentences based on their token lengths or a pattern match
### Aliases: corpus_trim char_trim
### Keywords: character corpus internal

### ** Examples

txt <- c("PAGE 1. This is a single sentence.  Short sentence. Three word sentence.",
         "PAGE 2. Very short! Shorter.",
         "Very long sentence, with multiple parts, separated by commas.  PAGE 3.")
mycorp <- corpus(txt, docvars = data.frame(serial = 1:3))
texts(mycorp)

# exclude sentences shorter than 3 tokens
texts(corpus_trim(mycorp, min_ntoken = 3))
# exclude sentences that start with "PAGE <digit(s)>"
texts(corpus_trim(mycorp, exclude_pattern = "^PAGE \\d+"))

# trimming character objects
char_trim(txt, "sentences", min_ntoken = 3)
char_trim(txt, "sentences", exclude_pattern = "sentence\\.")



cleanEx()
nameEx("corpus_trimsentences")
### * corpus_trimsentences

flush(stderr()); flush(stdout())

### Name: corpus_trimsentences
### Title: Remove sentences based on their token lengths or a pattern match
### Aliases: corpus_trimsentences char_trimsentences
### Keywords: deprecated internal

### ** Examples

txt <- c("PAGE 1. A single sentence.  Short sentence. Three word sentence.",
         "PAGE 2. Very short! Shorter.",
         "Very long sentence, with three parts, separated by commas.  PAGE 3.")
mycorp <- corpus(txt, docvars = data.frame(serial = 1:3))
texts(mycorp)

# exclude sentences shorter than 3 tokens
texts(corpus_trimsentences(mycorp, min_length = 3))
# exclude sentences that start with "PAGE <digit(s)>"
texts(corpus_trimsentences(mycorp, exclude_pattern = "^PAGE \\d+"))

# on a character
char_trimsentences(txt, min_length = 3)
char_trimsentences(txt, min_length = 3)
char_trimsentences(txt, exclude_pattern = "sentence\\.")



cleanEx()
nameEx("data_char_sampletext")
### * data_char_sampletext

flush(stderr()); flush(stdout())

### Name: data_char_sampletext
### Title: A paragraph of text for testing various text-based functions
### Aliases: data_char_sampletext
### Keywords: data

### ** Examples

tokens(data_char_sampletext, remove_punct = TRUE)



cleanEx()
nameEx("data_char_ukimmig2010")
### * data_char_ukimmig2010

flush(stderr()); flush(stdout())

### Name: data_char_ukimmig2010
### Title: Immigration-related sections of 2010 UK party manifestos
### Aliases: data_char_ukimmig2010
### Keywords: data

### ** Examples

data_corpus_ukimmig2010 <- 
    corpus(data_char_ukimmig2010, 
           docvars = data.frame(party = names(data_char_ukimmig2010)))
metadoc(data_corpus_ukimmig2010, "language") <- "english"
summary(data_corpus_ukimmig2010, showmeta = TRUE)



cleanEx()
nameEx("data_corpus_dailnoconf1991")
### * data_corpus_dailnoconf1991

flush(stderr()); flush(stdout())

### Name: data_corpus_dailnoconf1991
### Title: Confidence debate from 1991 Irish Parliament
### Aliases: data_corpus_dailnoconf1991
### Keywords: data

### ** Examples

## Not run: 
##D data_dfm_dailnoconf1991 <- dfm(data_corpus_dailnoconf1991, removePunct = TRUE)
##D fitted <- textmodel_mixfit(data_dfm_dailnoconf1991, 
##D                            c("Govt", "Opp", "Opp", rep(NA, 55)))
##D (pred <- predict(fitted))
##D tmpdf <- 
##D     data.frame(party = as.character(docvars(data_corpus_dailnoconf1991, "party")),
##D                govt = coef(pred)[,"Govt"],
##D                position = as.character(docvars(data_corpus_dailnoconf1991, "position")),
##D                stringsAsFactors = FALSE)
##D bymedian <- with(tmpdf, reorder(paste(party, position), govt, median))
##D par(mar = c(5, 6, 4, 2)+.1)
##D boxplot(govt ~ bymedian, data = tmpdf,
##D         horizontal = TRUE, las = 1,
##D         xlab = "Degree of support for government")
##D abline(h = 7.5, col = "red", lty = "dashed")
##D text(c(0.9, 0.9), c(8.5, 6.5), c("Goverment", "Opposition"))
## End(Not run)



cleanEx()
nameEx("data_corpus_inaugural")
### * data_corpus_inaugural

flush(stderr()); flush(stdout())

### Name: data_corpus_inaugural
### Title: US presidential inaugural address texts
### Aliases: data_corpus_inaugural
### Keywords: data

### ** Examples

# some operations on the inaugural corpus
summary(data_corpus_inaugural)
head(docvars(data_corpus_inaugural), 10)



cleanEx()
nameEx("data_corpus_irishbudget2010")
### * data_corpus_irishbudget2010

flush(stderr()); flush(stdout())

### Name: data_corpus_irishbudget2010
### Title: Irish budget speeches from 2010
### Aliases: data_corpus_irishbudget2010
### Keywords: data

### ** Examples

summary(data_corpus_irishbudget2010)



cleanEx()
nameEx("data_dictionary_LSD2015")
### * data_dictionary_LSD2015

flush(stderr()); flush(stdout())

### Name: data_dictionary_LSD2015
### Title: Lexicoder Sentiment Dictionary (2015)
### Aliases: data_dictionary_LSD2015
### Keywords: data

### ** Examples

# simple example
txt <- "This aggressive policy will not win friends."
tokens_lookup(tokens(txt), dictionary = data_dictionary_LSD2015, exclusive = FALSE)
## tokens from 1 document.
## text1 :
## [1] "This"   "NEGATIVE"   "policy"   "will"   "NEG_POSITIVE" "POSITIVE" "."

# on larger examples - notice that few negations are used
dfm(data_char_ukimmig2010, dictionary = data_dictionary_LSD2015)
kwic(data_char_ukimmig2010, "not")

# compound neg_negative and neg_positive tokens before creating a dfm object
toks <- tokens_compound(tokens(txt), data_dictionary_LSD2015)

dfm_lookup(dfm(toks), data_dictionary_LSD2015)



cleanEx()
nameEx("dfm-class")
### * dfm-class

flush(stderr()); flush(stdout())

### Name: dfm-class
### Title: Virtual class "dfm" for a document-feature matrix
### Aliases: dfm-class dfmSparse-class t,dfm-method colSums,dfm-method
###   rowSums,dfm-method colMeans,dfm-method rowMeans,dfm-method
###   Arith,dfm,numeric-method Arith,numeric,dfm-method
###   [,dfm,index,index,missing-method [,dfm,index,index,logical-method
###   [,dfm,missing,missing,missing-method
###   [,dfm,missing,missing,logical-method
###   [,dfm,index,missing,missing-method [,dfm,index,missing,logical-method
###   [,dfm,missing,index,missing-method [,dfm,missing,index,logical-method
### Keywords: dfm internal

### ** Examples

# dfm subsetting
x <- dfm(tokens(c("this contains lots of stopwords",
                  "no if, and, or but about it: lots",
                  "and a third document is it"),
                remove_punct = TRUE))
x[1:2, ]
x[1:2, 1:5]



cleanEx()
nameEx("dfm")
### * dfm

flush(stderr()); flush(stdout())

### Name: dfm
### Title: Create a document-feature matrix
### Aliases: dfm
### Keywords: dfm

### ** Examples

## for a corpus
corpus_post80inaug <- corpus_subset(data_corpus_inaugural, Year > 1980)
dfm(corpus_post80inaug)
dfm(corpus_post80inaug, tolower = FALSE)

# grouping documents by docvars in a corpus
dfm(corpus_post80inaug, groups = "President", verbose = TRUE)

# with English stopwords and stemming
dfm(corpus_post80inaug, remove = stopwords("english"), stem = TRUE, verbose = TRUE)
# works for both words in ngrams too
dfm("Banking industry", stem = TRUE, ngrams = 2, verbose = FALSE)

# with dictionaries
corpus_post1900inaug <- corpus_subset(data_corpus_inaugural, Year > 1900)
mydict <- dictionary(list(christmas = c("Christmas", "Santa", "holiday"),
               opposition = c("Opposition", "reject", "notincorpus"),
               taxing = "taxing",
               taxation = "taxation",
               taxregex = "tax*",
               country = "states"))
dfm(corpus_post1900inaug, dictionary = mydict)


# removing stopwords
test_text <- "The quick brown fox named Seamus jumps over the lazy dog also named Seamus, with
             the newspaper from a boy named Seamus, in his mouth."
test_corpus <- corpus(test_text)
# note: "also" is not in the default stopwords("english")
featnames(dfm(test_corpus, select = stopwords("english")))
# for ngrams
featnames(dfm(test_corpus, ngrams = 2, select = stopwords("english"), remove_punct = TRUE))
featnames(dfm(test_corpus, ngrams = 1:2, select = stopwords("english"), remove_punct = TRUE))

# removing stopwords before constructing ngrams
tokens_all <- tokens(char_tolower(test_text), remove_punct = TRUE)
tokens_no_stopwords <- tokens_remove(tokens_all, stopwords("english"))
tokens_ngrams_no_stopwords <- tokens_ngrams(tokens_no_stopwords, 2)
featnames(dfm(tokens_ngrams_no_stopwords, verbose = FALSE))

# keep only certain words
dfm(test_corpus, select = "*s", verbose = FALSE)  # keep only words ending in "s"
dfm(test_corpus, select = "s$", valuetype = "regex", verbose = FALSE)

# testing Twitter functions
test_tweets <- c("My homie @justinbieber #justinbieber shopping in #LA yesterday #beliebers",
                "2all the ha8ers including my bro #justinbieber #emabiggestfansjustinbieber",
                "Justin Bieber #justinbieber #belieber #fetusjustin #EMABiggestFansJustinBieber")
dfm(test_tweets, select = "#*", remove_twitter = FALSE)  # keep only hashtags
dfm(test_tweets, select = "^#.*$", valuetype = "regex", remove_twitter = FALSE)

# for a dfm
dfm1 <- dfm(data_corpus_irishbudget2010)
dfm2 <- dfm(dfm1, 
            groups = ifelse(docvars(data_corpus_irishbudget2010, "party") %in% c("FF", "Green"),
                            "Govt", "Opposition"), 
            tolower = FALSE, verbose = TRUE)




cleanEx()
nameEx("dfm2lsa")
### * dfm2lsa

flush(stderr()); flush(stdout())

### Name: dfm2lsa
### Title: Convert a dfm to an lsa "textmatrix"
### Aliases: dfm2lsa
### Keywords: internal

### ** Examples

## Not run: 
##D (mydfm <- dfm(c(d1 = "this is a first matrix", 
##D                 d2 = "this is second matrix as example")))
##D lsa::lsa(convert(mydfm, to = "lsa"))
## End(Not run)



cleanEx()
nameEx("dfm_compress")
### * dfm_compress

flush(stderr()); flush(stdout())

### Name: dfm_compress
### Title: Recombine a dfm or fcm by combining identical dimension elements
### Aliases: dfm_compress fcm_compress

### ** Examples

# dfm_compress examples
mat <- rbind(dfm(c("b A A", "C C a b B"), tolower = FALSE),
             dfm("A C C C C C", tolower = FALSE))
colnames(mat) <- char_tolower(featnames(mat))
mat
dfm_compress(mat, margin = "documents")
dfm_compress(mat, margin = "features")
dfm_compress(mat)

# no effect if no compression needed
compactdfm <- dfm(data_corpus_inaugural[1:5])
dim(compactdfm)
dim(dfm_compress(compactdfm))

# compress an fcm
myfcm <- fcm(tokens("A D a C E a d F e B A C E D"), 
             context = "window", window = 3)
## this will produce an error:
# fcm_compress(myfcm)

txt <- c("The fox JUMPED over the dog.",
         "The dog jumped over the fox.")
toks <- tokens(txt, remove_punct = TRUE)
myfcm <- fcm(toks, context = "document")
colnames(myfcm) <- rownames(myfcm) <- tolower(colnames(myfcm))
colnames(myfcm)[5] <- rownames(myfcm)[5] <- "fox"
myfcm
fcm_compress(myfcm)



cleanEx()
nameEx("dfm_group")
### * dfm_group

flush(stderr()); flush(stdout())

### Name: dfm_group
### Title: Combine documents in a dfm by a grouping variable
### Aliases: dfm_group

### ** Examples

mycorpus <- corpus(c("a a b", "a b c c", "a c d d", "a c c d"),
                   docvars = data.frame(grp = c("grp1", "grp1", "grp2", "grp2")))
mydfm <- dfm(mycorpus)
dfm_group(mydfm, groups = "grp")
dfm_group(mydfm, groups = c(1, 1, 2, 2))

# equivalent
dfm(mydfm, groups = "grp")
dfm(mydfm, groups = c(1, 1, 2, 2))



cleanEx()
nameEx("dfm_lookup")
### * dfm_lookup

flush(stderr()); flush(stdout())

### Name: dfm_lookup
### Title: Apply a dictionary to a dfm
### Aliases: dfm_lookup
### Keywords: dfm

### ** Examples

my_dict <- dictionary(list(christmas = c("Christmas", "Santa", "holiday"),
                          opposition = c("Opposition", "reject", "notincorpus"),
                          taxglob = "tax*",
                          taxregex = "tax.+$",
                          country = c("United_States", "Sweden")))
my_dfm <- dfm(c("My Christmas was ruined by your opposition tax plan.", 
               "Does the United_States or Sweden have more progressive taxation?"),
             remove = stopwords("english"), verbose = FALSE)
my_dfm

# glob format
dfm_lookup(my_dfm, my_dict, valuetype = "glob")
dfm_lookup(my_dfm, my_dict, valuetype = "glob", case_insensitive = FALSE)

# regex v. glob format: note that "united_states" is a regex match for "tax*"
dfm_lookup(my_dfm, my_dict, valuetype = "glob")
dfm_lookup(my_dfm, my_dict, valuetype = "regex", case_insensitive = TRUE)

# fixed format: no pattern matching
dfm_lookup(my_dfm, my_dict, valuetype = "fixed")
dfm_lookup(my_dfm, my_dict, valuetype = "fixed", case_insensitive = FALSE)

# show unmatched tokens
dfm_lookup(my_dfm, my_dict, nomatch = "_UNMATCHED")




cleanEx()
nameEx("dfm_replace")
### * dfm_replace

flush(stderr()); flush(stdout())

### Name: dfm_replace
### Title: Replace features in dfm
### Aliases: dfm_replace

### ** Examples

mydfm <- dfm(data_corpus_irishbudget2010)

# lemmatization
infle <- c("foci", "focus", "focused", "focuses", "focusing", "focussed", "focusses")
lemma <- rep("focus", length(infle))
mydfm2 <- dfm_replace(mydfm, infle, lemma)
featnames(dfm_select(mydfm2, infle))

# stemming
feat <- featnames(mydfm)
stem <- char_wordstem(feat, "porter")
mydfm3 <- dfm_replace(mydfm, feat, stem, case_insensitive = FALSE)
identical(mydfm3, dfm_wordstem(mydfm, "porter"))



cleanEx()
nameEx("dfm_sample")
### * dfm_sample

flush(stderr()); flush(stdout())

### Name: dfm_sample
### Title: Randomly sample documents or features from a dfm
### Aliases: dfm_sample

### ** Examples

set.seed(10)
myDfm <- dfm(data_corpus_inaugural[1:10])
head(myDfm)
head(dfm_sample(myDfm))
head(dfm_sample(myDfm, replace = TRUE))
head(dfm_sample(myDfm, margin = "features"))



cleanEx()
nameEx("dfm_select")
### * dfm_select

flush(stderr()); flush(stdout())

### Name: dfm_select
### Title: Select features from a dfm or fcm
### Aliases: dfm_select dfm_remove dfm_keep fcm_select fcm_remove fcm_keep
### Keywords: dfm

### ** Examples

my_dfm <- dfm(c("My Christmas was ruined by your opposition tax plan.",
               "Does the United_States or Sweden have more progressive taxation?"),
             tolower = FALSE, verbose = FALSE)
my_dict <- dictionary(list(countries = c("United_States", "Sweden", "France"),
                          wordsEndingInY = c("by", "my"),
                          notintext = "blahblah"))
dfm_select(my_dfm, my_dict)
dfm_select(my_dfm, my_dict, case_insensitive = FALSE)
dfm_select(my_dfm, c("s$", ".y"), selection = "keep", valuetype = "regex")
dfm_select(my_dfm, c("s$", ".y"), selection = "remove", valuetype = "regex")
dfm_select(my_dfm, stopwords("english"), selection = "keep", valuetype = "fixed")
dfm_select(my_dfm, stopwords("english"), selection = "remove", valuetype = "fixed")

# select based on character length
dfm_select(my_dfm, min_nchar = 5)

# selecting on a dfm
txts <- c("This is text one", "The second text", "This is text three")
(dfm1 <- dfm(txts[1:2]))
(dfm2 <- dfm(txts[2:3]))
(dfm3 <- dfm_select(dfm1, dfm2, valuetype = "fixed", verbose = TRUE))
setequal(featnames(dfm2), featnames(dfm3))

tmpdfm <- dfm(c("This is a document with lots of stopwords.",
                "No if, and, or but about it: lots of stopwords."),
              verbose = FALSE)
tmpdfm
dfm_remove(tmpdfm, stopwords("english"))
toks <- tokens(c("this contains lots of stopwords",
                 "no if, and, or but about it: lots"),
               remove_punct = TRUE)
tmpfcm <- fcm(toks)
tmpfcm
fcm_remove(tmpfcm, stopwords("english"))



cleanEx()
nameEx("dfm_sort")
### * dfm_sort

flush(stderr()); flush(stdout())

### Name: dfm_sort
### Title: Sort a dfm by frequency of one or more margins
### Aliases: dfm_sort

### ** Examples

dtm <- dfm(data_corpus_inaugural)
head(dtm)
head(dfm_sort(dtm))
head(dfm_sort(dtm, decreasing = FALSE, "both"))



cleanEx()
nameEx("dfm_subset")
### * dfm_subset

flush(stderr()); flush(stdout())

### Name: dfm_subset
### Title: Extract a subset of a dfm
### Aliases: dfm_subset
### Keywords: dfm

### ** Examples

testcorp <- corpus(c(d1 = "a b c d", d2 = "a a b e",
                     d3 = "b b c e", d4 = "e e f a b"),
                   docvars = data.frame(grp = c(1, 1, 2, 3)))
testdfm <- dfm(testcorp)
# selecting on a docvars condition
dfm_subset(testdfm, grp > 1)
# selecting on a supplied vector
dfm_subset(testdfm, c(TRUE, FALSE, TRUE, FALSE))

# selecting on a dfm
dfm1 <- dfm(c(d1 = "a b b c", d2 = "b b c d"))
dfm2 <- dfm(c(d1 = "x y z", d2 = "a b c c d", d3 = "x x x"))
dfm_subset(dfm1, subset = dfm2)
dfm_subset(dfm1, subset = dfm2[c(3,1,2), ])



cleanEx()
nameEx("dfm_tfidf")
### * dfm_tfidf

flush(stderr()); flush(stdout())

### Name: dfm_tfidf
### Title: Weight a dfm by _tf-idf_
### Aliases: dfm_tfidf
### Keywords: dfm weighting

### ** Examples

mydfm <- as.dfm(data_dfm_lbgexample)
head(mydfm[, 5:10])
head(dfm_tfidf(mydfm)[, 5:10])
docfreq(mydfm)[5:15]
head(dfm_weight(mydfm)[, 5:10])

# replication of worked example from
# https://en.wikipedia.org/wiki/Tf-idf#Example_of_tf.E2.80.93idf
wiki_dfm <- 
    matrix(c(1,1,2,1,0,0, 1,1,0,0,2,3),
           byrow = TRUE, nrow = 2,
           dimnames = list(docs = c("document1", "document2"),
                           features = c("this", "is", "a", "sample", 
                                        "another", "example"))) %>%
    as.dfm()
wiki_dfm    
docfreq(wiki_dfm)
dfm_tfidf(wiki_dfm, scheme_tf = "prop") %>% round(digits = 2)

## Not run: 
##D # comparison with tm
##D if (requireNamespace("tm")) {
##D     convert(wiki_dfm, to = "tm") %>% weightTfIdf() %>% as.matrix()
##D     # same as:
##D     dfm_tfidf(wiki_dfm, base = 2, scheme_tf = "prop")
##D }
## End(Not run)



cleanEx()
nameEx("dfm_tolower")
### * dfm_tolower

flush(stderr()); flush(stdout())

### Name: dfm_tolower
### Title: Convert the case of the features of a dfm and combine
### Aliases: dfm_tolower dfm_toupper fcm_tolower fcm_toupper

### ** Examples

# for a document-feature matrix
mydfm <- dfm(c("b A A", "C C a b B"), 
             toLower = FALSE, verbose = FALSE)
mydfm
dfm_tolower(mydfm) 
dfm_toupper(mydfm)
   
# for a feature co-occurrence matrix
myfcm <- fcm(tokens(c("b A A d", "C C a b B e")), 
             context = "document")
myfcm
fcm_tolower(myfcm) 
fcm_toupper(myfcm)   



cleanEx()
nameEx("dfm_trim")
### * dfm_trim

flush(stderr()); flush(stdout())

### Name: dfm_trim
### Title: Trim a dfm using frequency threshold-based feature selection
### Aliases: dfm_trim

### ** Examples

(mydfm <- dfm(data_corpus_inaugural[1:5]))

# keep only words occurring >= 10 times and in >= 2 documents
dfm_trim(mydfm, min_termfreq = 10, min_docfreq = 2)

# keep only words occurring >= 10 times and in at least 0.4 of the documents
dfm_trim(mydfm, min_termfreq = 10, min_docfreq = 0.4)

# keep only words occurring <= 10 times and in <=2 documents
dfm_trim(mydfm, max_termfreq = 10, max_docfreq = 2)

# keep only words occurring <= 10 times and in at most 3/4 of the documents
dfm_trim(mydfm, max_termfreq = 10, max_docfreq = 0.75)

# keep only words occurring 5 times in 1000, and in 2 of 5 of documents
dfm_trim(mydfm, min_docfreq = 0.4, min_termfreq = 0.005, termfreq_type = "prop")

# keep only words occurring frequently (top 20%) and in <=2 documents
dfm_trim(mydfm, min_termfreq = 0.2, max_docfreq = 2, termfreq_type = "quantile")

## Not run: 
##D # compare to removeSparseTerms from the tm package
##D (mydfm_tm <- convert(mydfm, "tm"))
##D tm::removeSparseTerms(mydfm_tm, 0.7)
##D dfm_trim(mydfm, min_docfreq = 0.3)
##D dfm_trim(mydfm, sparsity = 0.7)
## End(Not run)




cleanEx()
nameEx("dfm_weight")
### * dfm_weight

flush(stderr()); flush(stdout())

### Name: dfm_weight
### Title: Weight the feature frequencies in a dfm
### Aliases: dfm_weight dfm_smooth
### Keywords: dfm

### ** Examples

my_dfm <- dfm(data_corpus_inaugural)

x <- apply(my_dfm, 1, function(tf) tf/max(tf))
topfeatures(my_dfm)
norm_dfm <- dfm_weight(my_dfm, "prop")
topfeatures(norm_dfm)
max_tf_dfm <- dfm_weight(my_dfm)
topfeatures(max_tf_dfm)
log_tf_dfm <- dfm_weight(my_dfm, scheme = "logcount")
topfeatures(log_tf_dfm)
log_ave_dfm <- dfm_weight(my_dfm, scheme = "logave")
topfeatures(log_ave_dfm)

# combine these methods for more complex dfm_weightings, e.g. as in Section 6.4
# of Introduction to Information Retrieval
head(dfm_tfidf(my_dfm, scheme_tf = "logcount"))

# apply numeric weights
str <- c("apple is better than banana", "banana banana apple much better")
(my_dfm <- dfm(str, remove = stopwords("english")))
dfm_weight(my_dfm, weights = c(apple = 5, banana = 3, much = 0.5))

## Don't show: 
testdfm <- dfm(data_corpus_inaugural[1:5])
for (w in  c("count", "prop", "propmax", "logcount", "boolean", "augmented", "logave")) {
    testw <- dfm_weight(testdfm, w)
    cat("\n\n=== weight() TEST for:", w, "; class:", class(testw), "\n")
    head(testw)
}
## End(Don't show)
# smooth the dfm
dfm_smooth(my_dfm, 0.5)



cleanEx()
nameEx("dictionary")
### * dictionary

flush(stderr()); flush(stdout())

### Name: dictionary
### Title: Create a dictionary
### Aliases: dictionary

### ** Examples

mycorpus <- corpus_subset(data_corpus_inaugural, Year>1900)
mydict <- dictionary(list(christmas = c("Christmas", "Santa", "holiday"),
                          opposition = c("Opposition", "reject", "notincorpus"),
                          taxing = "taxing",
                          taxation = "taxation",
                          taxregex = "tax*",
                          country = "america"))
head(dfm(mycorpus, dictionary = mydict))

# subset a dictionary
mydict[1:2]
mydict[c("christmas", "opposition")]
mydict[["opposition"]]

# combine dictionaries
c(mydict["christmas"], mydict["country"])

## Not run: 
##D # import the Laver-Garry dictionary from Provalis Research
##D dictfile <- tempfile()
##D download.file("https://provalisresearch.com/Download/LaverGarry.zip", 
##D               dictfile, mode = "wb")
##D unzip(dictfile, exdir = (td <- tempdir()))
##D lgdict <- dictionary(file = paste(td, "LaverGarry.cat", sep = "/"))
##D head(dfm(data_corpus_inaugural, dictionary = lgdict))
##D 
##D # import a LIWC formatted dictionary from http://www.moralfoundations.org
##D download.file("https://goo.gl/5gmwXq", tf <- tempfile())
##D mfdict <- dictionary(file = tf, format = "LIWC")
##D head(dfm(data_corpus_inaugural, dictionary = mfdict))
## End(Not run)



cleanEx()
nameEx("docfreq")
### * docfreq

flush(stderr()); flush(stdout())

### Name: docfreq
### Title: Compute the (weighted) document frequency of a feature
### Aliases: docfreq
### Keywords: dfm weighting

### ** Examples

mydfm <- dfm(data_corpus_inaugural[1:2])
docfreq(mydfm[, 1:20])

# replication of worked example from
# https://en.wikipedia.org/wiki/Tf-idf#Example_of_tf.E2.80.93idf
wiki_dfm <- 
    matrix(c(1,1,2,1,0,0, 1,1,0,0,2,3),
           byrow = TRUE, nrow = 2,
           dimnames = list(docs = c("document1", "document2"),
                           features = c("this", "is", "a", "sample",
                                        "another", "example"))) %>%
    as.dfm()
wiki_dfm
docfreq(wiki_dfm)
docfreq(wiki_dfm, scheme = "inverse")
docfreq(wiki_dfm, scheme = "inverse", k = 1, smoothing = 1)
docfreq(wiki_dfm, scheme = "unary")
docfreq(wiki_dfm, scheme = "inversemax")
docfreq(wiki_dfm, scheme = "inverseprob")



cleanEx()
nameEx("docnames")
### * docnames

flush(stderr()); flush(stdout())

### Name: docnames
### Title: Get or set document names
### Aliases: docnames docnames<-
### Keywords: corpus dfm

### ** Examples

# get and set doument names to a corpus
mycorp <- data_corpus_inaugural
docnames(mycorp) <- char_tolower(docnames(mycorp))

# get and set doument names to a tokens
mytoks <- tokens(data_corpus_inaugural)
docnames(mytoks) <- char_tolower(docnames(mytoks))

# get and set doument names to a dfm
mydfm <- dfm(data_corpus_inaugural[1:5])
docnames(mydfm) <- char_tolower(docnames(mydfm))

# reassign the document names of the inaugural speech corpus
docnames(data_corpus_inaugural) <- paste("Speech", 1:ndoc(data_corpus_inaugural), sep="")




cleanEx()
nameEx("docvars")
### * docvars

flush(stderr()); flush(stdout())

### Name: docvars
### Title: Get or set document-level variables
### Aliases: docvars docvars<-
### Keywords: corpus

### ** Examples

# retrieving docvars from a corpus
head(docvars(data_corpus_inaugural))
tail(docvars(data_corpus_inaugural, "President"), 10)

# assigning document variables to a corpus
corp <- data_corpus_inaugural
docvars(corp, "President") <- paste("prez", 1:ndoc(corp), sep = "")
head(docvars(corp))

# alternative using indexing
head(corp[, "Year"])
corp[["President2"]] <- paste("prezTwo", 1:ndoc(corp), sep = "")
head(docvars(corp))




cleanEx()
nameEx("expand")
### * expand

flush(stderr()); flush(stdout())

### Name: expand
### Title: Simpler and faster version of expand.grid() in base package
### Aliases: expand
### Keywords: internal

### ** Examples

quanteda:::expand(list(c("a", "b", "c"), c("x", "y")))



cleanEx()
nameEx("fcm-class")
### * fcm-class

flush(stderr()); flush(stdout())

### Name: fcm-class
### Title: Virtual class "fcm" for a feature co-occurrence matrix The fcm
###   class of object is a special type of fcm object with additional
###   slots, described below.
### Aliases: fcm-class t,fcm-method Arith,fcm,numeric-method
###   Arith,numeric,fcm-method [,fcm,index,index,missing-method
###   [,fcm,index,index,logical-method [,fcm,missing,missing,missing-method
###   [,fcm,missing,missing,logical-method
###   [,fcm,index,missing,missing-method [,fcm,index,missing,logical-method
###   [,fcm,missing,index,missing-method [,fcm,missing,index,logical-method
### Keywords: internal

### ** Examples

# fcm subsetting
y <- fcm(tokens(c("this contains lots of stopwords",
                  "no if, and, or but about it: lots"),
                remove_punct = TRUE))
y[1:3, ]
y[4:5, 1:5]





cleanEx()
nameEx("fcm")
### * fcm

flush(stderr()); flush(stdout())

### Name: fcm
### Title: Create a feature co-occurrence matrix
### Aliases: fcm is.fcm

### ** Examples

# see http://bit.ly/29b2zOA
txt <- "A D A C E A D F E B A C E D"
fcm(txt, context = "window", window = 2)
fcm(txt, context = "window", count = "weighted", window = 3)
fcm(txt, context = "window", count = "weighted", window = 3, 
             weights = c(3, 2, 1), ordered = TRUE, tri = FALSE)

# with multiple documents
txts <- c("a a a b b c", "a a c e", "a c e f g")
fcm(txts, context = "document", count = "frequency")
fcm(txts, context = "document", count = "boolean")
fcm(txts, context = "window", window = 2)


# from tokens
txt <- c("The quick brown fox jumped over the lazy dog.",
         "The dog jumped and ate the fox.")
toks <- tokens(char_tolower(txt), remove_punct = TRUE)
fcm(toks, context = "document")
fcm(toks, context = "window", window = 3)



cleanEx()
nameEx("fcm_sort")
### * fcm_sort

flush(stderr()); flush(stdout())

### Name: fcm_sort
### Title: Sort an fcm in alphabetical order of the features
### Aliases: fcm_sort

### ** Examples

# with tri = FALSE
myfcm <- fcm(tokens(c("A X Y C B A", "X Y C A B B")), tri = FALSE)
rownames(myfcm)[3] <- colnames(myfcm)[3] <- "Z"
myfcm
fcm_sort(myfcm)

# with tri = TRUE
myfcm <- fcm(tokens(c("A X Y C B A", "X Y C A B B")), tri = TRUE)
rownames(myfcm)[3] <- colnames(myfcm)[3] <- "Z"
myfcm
fcm_sort(myfcm)



cleanEx()
nameEx("featnames")
### * featnames

flush(stderr()); flush(stdout())

### Name: featnames
### Title: Get the feature labels from a dfm
### Aliases: featnames

### ** Examples

inaugDfm <- dfm(data_corpus_inaugural, verbose = FALSE)

# first 50 features (in original text order)
head(featnames(inaugDfm), 50)

# first 50 features alphabetically
head(sort(featnames(inaugDfm)), 50)

# contrast with descending total frequency order from topfeatures()
names(topfeatures(inaugDfm, 50))



cleanEx()
nameEx("friendly_class_undefined_message")
### * friendly_class_undefined_message

flush(stderr()); flush(stdout())

### Name: friendly_class_undefined_message
### Title: Print friendly object class not defined message
### Aliases: friendly_class_undefined_message
### Keywords: internal

### ** Examples

# as.tokens.default <- function(x, concatenator = "", ...) {
#     stop(quanteda:::friendly_class_undefined_message(class(x), "as.tokens"))
# }



cleanEx()
nameEx("head.corpus")
### * head.corpus

flush(stderr()); flush(stdout())

### Name: head.corpus
### Title: Return the first or last part of a corpus
### Aliases: head.corpus tail.corpus
### Keywords: corpus

### ** Examples

head(data_corpus_irishbudget2010, 3) %>% summary()

tail(data_corpus_irishbudget2010, 3) %>% summary()



cleanEx()
nameEx("head.dfm")
### * head.dfm

flush(stderr()); flush(stdout())

### Name: head.dfm
### Title: Return the first or last part of a dfm
### Aliases: head.dfm tail.dfm
### Keywords: dfm

### ** Examples

head(data_dfm_lbgexample, 3, nf = 5)
head(data_dfm_lbgexample, -4)

tail(data_dfm_lbgexample)
tail(data_dfm_lbgexample, n = 3, nf = 4)



cleanEx()
nameEx("influence.predict.textmodel_affinity")
### * influence.predict.textmodel_affinity

flush(stderr()); flush(stdout())

### Name: influence.predict.textmodel_affinity
### Title: Compute feature influence from a predicted textmodel_affinity
###   object
### Aliases: influence.predict.textmodel_affinity
### Keywords: internal textmodel

### ** Examples

af <- textmodel_affinity(data_dfm_lbgexample, y = c("L", NA, NA, NA, "R", NA))
afpred <- predict(af) 
influence(afpred)



cleanEx()
nameEx("keyness")
### * keyness

flush(stderr()); flush(stdout())

### Name: keyness
### Title: Compute keyness (internal functions)
### Aliases: keyness keyness_chi2_dt keyness_chi2_stats keyness
###   keyness_exact keyness_lr keyness_pmi
### Keywords: internal textstat

### ** Examples

mydfm <- dfm(c(d1 = "a a a b b c c c c c c d e f g h h",
               d2 = "a a b c c d d d d e f h"))
quanteda:::keyness_chi2_dt(mydfm)
quanteda:::keyness_chi2_stats(mydfm)
quanteda:::keyness_exact(mydfm)
quanteda:::keyness_lr(mydfm)
quanteda:::keyness_pmi(mydfm)



cleanEx()
nameEx("kwic")
### * kwic

flush(stderr()); flush(stdout())

### Name: kwic
### Title: Locate keywords-in-context
### Aliases: kwic is.kwic

### ** Examples

head(kwic(data_corpus_inaugural, "secure*", window = 3, valuetype = "glob"))
head(kwic(data_corpus_inaugural, "secur", window = 3, valuetype = "regex"))
head(kwic(data_corpus_inaugural, "security", window = 3, valuetype = "fixed"))

toks <- tokens(data_corpus_inaugural)
kwic(data_corpus_inaugural, phrase("war against"))
kwic(data_corpus_inaugural, phrase("war against"), valuetype = "regex")

mykwic <- kwic(data_corpus_inaugural, "provident*")
is.kwic(mykwic)
is.kwic("Not a kwic")



cleanEx()
nameEx("merge_dictionary_values")
### * merge_dictionary_values

flush(stderr()); flush(stdout())

### Name: merge_dictionary_values
### Title: Internal function to merge values of duplicated keys
### Aliases: merge_dictionary_values
### Keywords: internal

### ** Examples

dict <- list('A' = list(AA = list('aaaaa'), 'a'), 
             'B' = list('b'),
             'C' = list('c'),
             'A' = list('aa'))
quanteda:::merge_dictionary_values(dict)



cleanEx()
nameEx("metacorpus")
### * metacorpus

flush(stderr()); flush(stdout())

### Name: metacorpus
### Title: Get or set corpus metadata
### Aliases: metacorpus metacorpus<-
### Keywords: corpus

### ** Examples

metacorpus(data_corpus_inaugural)
metacorpus(data_corpus_inaugural, "source")
metacorpus(data_corpus_inaugural, "citation") <- "Presidential Speeches Online Project (2014)."
metacorpus(data_corpus_inaugural, "citation")



cleanEx()
nameEx("metadoc")
### * metadoc

flush(stderr()); flush(stdout())

### Name: metadoc
### Title: Get or set document-level meta-data
### Aliases: metadoc metadoc<-
### Keywords: corpus

### ** Examples

mycorp <- corpus_subset(data_corpus_inaugural, Year > 1990)
summary(mycorp, showmeta = TRUE)
metadoc(mycorp, "encoding") <- "UTF-8"
metadoc(mycorp)
metadoc(mycorp, "language") <- "english"
summary(mycorp, showmeta = TRUE)



cleanEx()
nameEx("ndoc")
### * ndoc

flush(stderr()); flush(stdout())

### Name: ndoc
### Title: Count the number of documents or features
### Aliases: ndoc nfeat nfeature

### ** Examples

# number of documents
ndoc(data_corpus_inaugural)
ndoc(corpus_subset(data_corpus_inaugural, Year > 1980))
ndoc(tokens(data_corpus_inaugural))
ndoc(dfm(corpus_subset(data_corpus_inaugural, Year > 1980)))

# number of features
nfeat(dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove_punct = FALSE))
nfeat(dfm(corpus_subset(data_corpus_inaugural, Year > 1980), remove_punct = TRUE))



cleanEx()
nameEx("nest_dictionary")
### * nest_dictionary

flush(stderr()); flush(stdout())

### Name: nest_dictionary
### Title: Utility function to generate a nested list
### Aliases: nest_dictionary
### Keywords: internal

### ** Examples

list_flat <- list('A' = c('a', 'aa', 'aaa'), 'B' = c('b', 'bb'), 'C' = c('c', 'cc'), 'D' = c('ddd'))
dict_flat <- quanteda:::list2dictionary(list_flat)
quanteda:::nest_dictionary(dict_flat, c(1, 1, 2, 2))
quanteda:::nest_dictionary(dict_flat, c(1, 2, 1, 2))




cleanEx()
nameEx("nscrabble")
### * nscrabble

flush(stderr()); flush(stdout())

### Name: nscrabble
### Title: Count the Scrabble letter values of text
### Aliases: nscrabble

### ** Examples

nscrabble(c("muzjiks", "excellency"))
nscrabble(data_corpus_inaugural[1:5], mean)



cleanEx()
nameEx("nsentence")
### * nsentence

flush(stderr()); flush(stdout())

### Name: nsentence
### Title: Count the number of sentences
### Aliases: nsentence

### ** Examples

# simple example
txt <- c(text1 = "This is a sentence: second part of first sentence.",
         text2 = "A word. Repeated repeated.",
         text3 = "Mr. Jones has a PhD from the LSE.  Second sentence.")
nsentence(txt)



cleanEx()
nameEx("nsyllable")
### * nsyllable

flush(stderr()); flush(stdout())

### Name: nsyllable
### Title: Count syllables in a text
### Aliases: nsyllable

### ** Examples

# character
nsyllable(c("cat", "syllable", "supercalifragilisticexpialidocious", 
            "Brexit", "Administration"), use.names = TRUE)

# tokens
txt <- c(doc1 = "This is an example sentence.",
         doc2 = "Another of two sample sentences.")
nsyllable(tokens(txt, remove_punct = TRUE))
# punctuation is not counted
nsyllable(tokens(txt), use.names = TRUE)



cleanEx()
nameEx("ntoken")
### * ntoken

flush(stderr()); flush(stdout())

### Name: ntoken
### Title: Count the number of tokens or types
### Aliases: ntoken ntype

### ** Examples

# simple example
txt <- c(text1 = "This is a sentence, this.", text2 = "A word. Repeated repeated.")
ntoken(txt)
ntype(txt)
ntoken(char_tolower(txt))  # same
ntype(char_tolower(txt))   # fewer types
ntoken(char_tolower(txt), remove_punct = TRUE)
ntype(char_tolower(txt), remove_punct = TRUE)

# with some real texts
ntoken(corpus_subset(data_corpus_inaugural, Year<1806), remove_punct = TRUE)
ntype(corpus_subset(data_corpus_inaugural, Year<1806), remove_punct = TRUE)
ntoken(dfm(corpus_subset(data_corpus_inaugural, Year<1800)))
ntype(dfm(corpus_subset(data_corpus_inaugural, Year<1800)))



cleanEx()
nameEx("pattern")
### * pattern

flush(stderr()); flush(stdout())

### Name: pattern
### Title: Pattern for feature, token and keyword matching
### Aliases: pattern
### Keywords: internal

### ** Examples

# these are interpreted literally
(patt1 <- c('president', 'white house', 'house of representatives'))
# as multi-word sequences
phrase(patt1)

# three single-word patterns
(patt2 <- c('president', 'white_house', 'house_of_representatives'))
phrase(patt2)

# this is equivalent to phrase(patt1)
(patt3 <- list(c('president'), c('white', 'house'), c('house', 'of', 'representatives')))

# glob expression can be used 
phrase(patt4 <- c('president?', 'white house', 'house * representatives'))

# this is equivalent to phrase(patt4)
(patt5 <- list(c('president?'), c('white', 'house'), c('house', '*', 'representatives')))

# dictionary with multi-word matches
(dict1 <- dictionary(list(us = c('president', 'white house', 'house of representatives'))))
phrase(dict1)



cleanEx()
nameEx("pattern2id")
### * pattern2id

flush(stderr()); flush(stdout())

### Name: pattern2id
### Title: Convert regex and glob patterns to type IDs or fixed patterns
### Aliases: pattern2id pattern2fixed index_types
### Keywords: internal

### ** Examples

types <- c("A", "AA", "B", "BB", "BBB", "C", "CC")

pats_regex <- list(c("^a$", "^b"), c("c"), c("d"))
pattern2id(pats_regex, types, "regex", case_insensitive = TRUE)

pats_glob <- list(c("a*", "b*"), c("c"), c("d"))
pattern2id(pats_glob, types, "glob", case_insensitive = TRUE)

pattern <- list(c("^a$", "^b"), c("c"), c("d"))
types <- c("A", "AA", "B", "BB", "BBB", "C", "CC")
pattern2fixed(pattern, types, "regex", case_insensitive = TRUE)
index <- index_types(types, "regex", case_insensitive = TRUE)
pattern2fixed(pattern, index = index)
index <- index_types(c("xxx", "yyyy", "ZZZ"), "glob", FALSE, 3)
quanteda:::search_glob("yy*", attr(index, "type_search"), index)



cleanEx()
nameEx("phrase")
### * phrase

flush(stderr()); flush(stdout())

### Name: phrase
### Title: Declare a compound character to be a sequence of separate
###   pattern matches
### Aliases: phrase is.phrase

### ** Examples

# make phrases from characters
phrase(c("a b", "c d e", "f"))

# from a dictionary
phrase(dictionary(list(catone = c("a b"), cattwo = "c d e", catthree = "f")))

# from a collocations object
(coll <- textstat_collocations(tokens("a b c a b d e b d a b")))
phrase(coll)



cleanEx()
nameEx("predict.textmodel_nb")
### * predict.textmodel_nb

flush(stderr()); flush(stdout())

### Name: predict.textmodel_nb
### Title: Prediction from a fitted textmodel_nb object
### Aliases: predict.textmodel_nb
### Keywords: internal textmodel

### ** Examples

# application to LBG (2003) example data
(nb <- textmodel_nb(data_dfm_lbgexample, c("A", "A", "B", "C", "C", NA)))
predict(nb)
predict(nb, type = "logposterior")



cleanEx()
nameEx("predict.textmodel_wordscores")
### * predict.textmodel_wordscores

flush(stderr()); flush(stdout())

### Name: predict.textmodel_wordscores
### Title: Predict textmodel_wordscores
### Aliases: predict.textmodel_wordscores
### Keywords: internal textmodel

### ** Examples

ws <- textmodel_wordscores(data_dfm_lbgexample, c(seq(-1.5, 1.5, .75), NA))
predict(ws)
predict(ws, rescaling = "mv")
predict(ws, rescaling = "lbg")
predict(ws, se.fit = TRUE)
predict(ws, se.fit = TRUE, interval = "confidence")
predict(ws, se.fit = TRUE, interval = "confidence", rescaling = "lbg")



cleanEx()
nameEx("quanteda_options")
### * quanteda_options

flush(stderr()); flush(stdout())

### Name: quanteda_options
### Title: Get or set package options for quanteda
### Aliases: quanteda_options

### ** Examples

(opt <- quanteda_options())



cleanEx()
nameEx("read_dict_liwc")
### * read_dict_liwc

flush(stderr()); flush(stdout())

### Name: read_dict_liwc
### Title: Import a LIWC-formatted dictionary
### Aliases: read_dict_liwc
### Keywords: internal

### ** Examples

## Not run: 
##D quanteda:::read_dict_liwc('/home/kohei/Documents/Dictionary/LIWC/LIWC2007_English.dic')
##D quanteda:::read_dict_liwc('/home/kohei/Documents/Dictionary/LIWC/LIWC2015_English.dic')
##D 
##D dictionary(file = "~/Dropbox/QUANTESS/dictionaries/LIWC/LIWC2007_English.dic")      # WORKS
##D dictionary(file = "/home/kohei/Documents/Dictionary/LIWC/LIWC2015_English.dic") # WORKS
##D dictionary(file = "~/Dropbox/QUANTESS/dictionaries/LIWC/LIWC2015_English_Flat.dic") # WORKS
##D dictionary(file = "~/Dropbox/QUANTESS/dictionaries/LIWC/LIWC2001_English.dic")       # FAILS
##D dictionary(file = "~/Dropbox/QUANTESS/dictionaries/LIWC/LIWC2007_English080730.dic") # FAILS
## End(Not run)



cleanEx()
nameEx("replace_dictionary_values")
### * replace_dictionary_values

flush(stderr()); flush(stdout())

### Name: replace_dictionary_values
### Title: Internal function to replace dictionary values
### Aliases: replace_dictionary_values
### Keywords: internal

### ** Examples

dict <- list(KEY1 = list(SUBKEY1 = list("A_B"),
                          SUBKEY2 = list("C_D")),
              KEY2 = list(SUBKEY3 = list("E_F"),
                          SUBKEY4 = list("G_F_I")),
              KEY3 = list(SUBKEY5 = list(SUBKEY7 = list("J_K")),
                          SUBKEY6 = list(SUBKEY8 = list("L"))))
quanteda:::replace_dictionary_values(dict, '_', ' ')



cleanEx()
nameEx("settings")
### * settings

flush(stderr()); flush(stdout())

### Name: settings
### Title: Get or set the corpus settings
### Aliases: settings settings.default settings.corpus settings<-
###   settings.dfm
### Keywords: internal settings

### ** Examples

settings(data_corpus_inaugural, "stopwords")
(tempdfm <- dfm(corpus_subset(data_corpus_inaugural, Year>1980), verbose=FALSE))
(tempdfmSW <- dfm(corpus_subset(data_corpus_inaugural, Year>1980),
                 remove = stopwords("english"), verbose=FALSE))
settings(data_corpus_inaugural, "stopwords") <- TRUE
tempdfm <- dfm(data_corpus_inaugural, stem=TRUE, verbose=FALSE)
settings(tempdfm)



cleanEx()
nameEx("spacyr-methods")
### * spacyr-methods

flush(stderr()); flush(stdout())

### Name: spacyr-methods
### Title: Extensions for and from spacy_parse objects
### Aliases: spacyr-methods spacy_parse.corpus

### ** Examples

## Not run: 
##D library("spacyr")
##D spacy_initialize()
##D 
##D txt <- c(doc1 = "And now, now, now for something completely different.",
##D          doc2 = "Jack and Jill are children.")
##D parsed <- spacy_parse(txt)
##D ntype(parsed)
##D ntoken(parsed)
##D ndoc(parsed)
##D docnames(parsed)
##D 
##D corpus_subset(data_corpus_inaugural, Year <= 1793) %>% spacy_parse()
## End(Not run)



cleanEx()
nameEx("sparsity")
### * sparsity

flush(stderr()); flush(stdout())

### Name: sparsity
### Title: Compute the sparsity of a document-feature matrix
### Aliases: sparsity

### ** Examples

inaug_dfm <- dfm(data_corpus_inaugural, verbose = FALSE)
sparsity(inaug_dfm)
sparsity(dfm_trim(inaug_dfm, min_termfreq = 5))



cleanEx()
nameEx("summary.corpus")
### * summary.corpus

flush(stderr()); flush(stdout())

### Name: summary.corpus
### Title: Summarize a corpus
### Aliases: summary.corpus
### Keywords: corpus internal

### ** Examples

summary(data_corpus_inaugural)
summary(data_corpus_inaugural, n = 10)
mycorpus <- corpus(data_char_ukimmig2010, 
                   docvars = data.frame(party=names(data_char_ukimmig2010))) 
summary(mycorpus, showmeta=TRUE) # show the meta-data
mysummary <- summary(mycorpus) # (quietly) assign the results
mysummary$Types / mysummary$Tokens # crude type-token ratio



cleanEx()
nameEx("summary_character")
### * summary_character

flush(stderr()); flush(stdout())

### Name: summary_character
### Title: Summary statistics on a character vector
### Aliases: summary_character
### Keywords: char internal

### ** Examples

# summarize texts
quanteda:::summary_character(c("Testing this text. Second sentence.", "And this one."))
quanteda:::summary_character(data_char_ukimmig2010)
mysummary_ukimmig2010 <- quanteda:::summary_character(data_char_ukimmig2010)
head(mysummary_ukimmig2010)



cleanEx()
nameEx("textmodel_affinity")
### * textmodel_affinity

flush(stderr()); flush(stdout())

### Name: textmodel_affinity
### Title: Class affinity maximum likelihood text scaling model
### Aliases: textmodel_affinity
### Keywords: experimental textmodel

### ** Examples

(af <- textmodel_affinity(data_dfm_lbgexample, y = c("L", NA, NA, NA, "R", NA)))
predict(af)
predict(af, newdata = data_dfm_lbgexample[6, ])

## Not run: 
##D # compute bootstrapped SEs
##D bs_dfm <- bootstrap_dfm(data_corpus_dailnoconf1991, n = 10, remove_punct = TRUE)
##D textmodel_affinity(bs_dfm, y = c("Govt", "Opp", "Opp", rep(NA, 55)))
## End(Not run)



cleanEx()
nameEx("textmodel_ca")
### * textmodel_ca

flush(stderr()); flush(stdout())

### Name: textmodel_ca
### Title: Correspondence analysis of a document-feature matrix
### Aliases: textmodel_ca

### ** Examples

ieDfm <- dfm(data_corpus_irishbudget2010)
wca <- textmodel_ca(ieDfm)
summary(wca)



cleanEx()
nameEx("textmodel_lsa")
### * textmodel_lsa

flush(stderr()); flush(stdout())

### Name: textmodel_lsa
### Title: Latent Semantic Analysis
### Aliases: textmodel_lsa
### Keywords: experimental textmodel

### ** Examples

ie_dfm <- dfm(data_corpus_irishbudget2010)
# create an LSA space and return its truncated representation in the low-rank space
ie_lsa <- textmodel_lsa(ie_dfm[1:10, ])
head(ie_lsa$docs)

# matrix in low_rank LSA space
ie_lsa$matrix_low_rank[,1:5]

# fold queries into the space generated by ie_dfm[1:10,]
# and return its truncated versions of its representation in the new low-rank space
new_lsa <- predict(ie_lsa, ie_dfm[11:14, ])
new_lsa$docs_newspace




cleanEx()
nameEx("textmodel_nb")
### * textmodel_nb

flush(stderr()); flush(stdout())

### Name: textmodel_nb
### Title: Naive Bayes classifier for texts
### Aliases: textmodel_nb

### ** Examples

## Example from 13.1 of _An Introduction to Information Retrieval_
txt <- c(d1 = "Chinese Beijing Chinese",
         d2 = "Chinese Chinese Shanghai",
         d3 = "Chinese Macao",
         d4 = "Tokyo Japan Chinese",
         d5 = "Chinese Chinese Chinese Tokyo Japan")
trainingset <- dfm(txt, tolower = FALSE)
trainingclass <- factor(c("Y", "Y", "Y", "N", NA), ordered = TRUE)
 
## replicate IIR p261 prediction for test set (document 5)
(nb <- textmodel_nb(trainingset, trainingclass, prior = "docfreq"))
summary(nb)
coef(nb)
predict(nb)

# contrast with other priors
predict(textmodel_nb(trainingset, trainingclass, prior = "uniform"))
predict(textmodel_nb(trainingset, trainingclass, prior = "termfreq"))

## replicate IIR p264 Bernoulli Naive Bayes
nb_bern <- textmodel_nb(trainingset, trainingclass, distribution = "Bernoulli", 
                        prior = "docfreq")
predict(nb_bern, newdata = trainingset[5, ])



cleanEx()
nameEx("textmodel_wordfish")
### * textmodel_wordfish

flush(stderr()); flush(stdout())

### Name: textmodel_wordfish
### Title: Wordfish text model
### Aliases: textmodel_wordfish

### ** Examples

(wf <- textmodel_wordfish(data_dfm_lbgexample, dir = c(1,5)))
summary(wf, n = 10)
coef(wf)
predict(wf)
predict(wf, se.fit = TRUE)
predict(wf, interval = "confidence")

## Not run: 
##D ie2010dwf <- dfm(data_corpus_irishbudget2010, verbose = FALSE)
##D (wf1 <- textmodel_wordfish(ie2010dfm, dir = c(6,5)))
##D (wf2a <- textmodel_wordfish(ie2010dfm, dir = c(6,5), 
##D                              dispersion = "quasipoisson", dispersion_floor = 0))
##D (wf2b <- textmodel_wordfish(ie2010dfm, dir = c(6,5), 
##D                              dispersion = "quasipoisson", dispersion_floor = .5))
##D plot(wf2a$phi, wf2b$phi, xlab = "Min underdispersion = 0", ylab = "Min underdispersion = .5",
##D      xlim = c(0, 1.0), ylim = c(0, 1.0))
##D plot(wf2a$phi, wf2b$phi, xlab = "Min underdispersion = 0", ylab = "Min underdispersion = .5",
##D      xlim = c(0, 1.0), ylim = c(0, 1.0), type = "n")
##D underdispersedTerms <- sample(which(wf2a$phi < 1.0), 5)
##D which(featnames(ie2010dfm) %in% names(topfeatures(ie2010dfm, 20)))
##D text(wf2a$phi, wf2b$phi, wf2a$features, 
##D      cex = .8, xlim = c(0, 1.0), ylim = c(0, 1.0), col = "grey90")
##D text(wf2a$phi['underdispersedTerms'], wf2b$phi['underdispersedTerms'], 
##D      wf2a$features['underdispersedTerms'], 
##D      cex = .8, xlim = c(0, 1.0), ylim = c(0, 1.0), col = "black")
##D if (require(austin)) {
##D     wf_austin <- austin::wordfish(quanteda::as.wfm(ie2010dfm), dir = c(6,5))
##D     cor(wf1$theta, wf_austin$theta)
##D }
## End(Not run)



cleanEx()
nameEx("textmodel_wordscores")
### * textmodel_wordscores

flush(stderr()); flush(stdout())

### Name: textmodel_wordscores
### Title: Wordscores text model
### Aliases: textmodel_wordscores

### ** Examples

(ws <- textmodel_wordscores(data_dfm_lbgexample, c(seq(-1.5, 1.5, .75), NA)))
summary(ws)
coef(ws)
predict(ws)
predict(ws, rescaling = "lbg")
predict(ws, se.fit = TRUE, interval = "confidence", rescaling = "mv")



cleanEx()
nameEx("textplot_influence")
### * textplot_influence

flush(stderr()); flush(stdout())

### Name: textplot_influence
### Title: Influence plot for text scaling models
### Aliases: textplot_influence
### Keywords: textplot

### ** Examples

af <- textmodel_affinity(data_dfm_lbgexample, y = c("L", NA, NA, NA, "R", NA))
afpred <- predict(af) 
textplot_influence(influence(afpred))



cleanEx()
nameEx("textplot_keyness")
### * textplot_keyness

flush(stderr()); flush(stdout())

### Name: textplot_keyness
### Title: Plot word keyness
### Aliases: textplot_keyness
### Keywords: textplot

### ** Examples

# compare Trump speeches to other Presidents by chi^2
dem_dfm <- data_corpus_inaugural %>%
     corpus_subset(Year > 1980) %>%
     dfm(groups = "President", remove = stopwords("english"), remove_punct = TRUE)
dem_key <- textstat_keyness(dem_dfm, target = "Trump")
textplot_keyness(dem_key, margin = 0.2, n = 10)

# compare contemporary Democrats v. Republicans
pres_corp <- data_corpus_inaugural %>%
    corpus_subset(Year > 1960)
docvars(pres_corp, "party") <-
    ifelse(docvars(pres_corp, "President") %in% c("Nixon", "Reagan", "Bush", "Trump"),
           "Republican", "Democrat")
pres_dfm <- dfm(pres_corp, groups = "party", remove = stopwords("english"),
                remove_punct = TRUE)
pres_key <- textstat_keyness(pres_dfm, target = "Democrat", measure = "lr")
textplot_keyness(pres_key, color = c("blue", "red"), n = 10)




cleanEx()
nameEx("textplot_network")
### * textplot_network

flush(stderr()); flush(stdout())

### Name: textplot_network
### Title: Plot a network of feature co-occurrences
### Aliases: textplot_network as.network.fcm as.igraph.fcm
### Keywords: textplot

### ** Examples

toks <- corpus_subset(data_corpus_irishbudget2010) %>%
    tokens(remove_punct = TRUE) %>%
    tokens_tolower() %>%
    tokens_remove(stopwords("english"), padding = FALSE)
myfcm <- fcm(toks, context = "window", tri = FALSE)
feat <- names(topfeatures(myfcm, 30))
fcm_select(myfcm, feat, verbose = FALSE) %>% 
    textplot_network(min_freq = 0.5)
fcm_select(myfcm, feat, verbose = FALSE) %>% 
    textplot_network(min_freq = 0.8)
fcm_select(myfcm, feat, verbose = FALSE) %>%
    textplot_network(min_freq = 0.8, vertex_labelcolor = rep(c('gray40', NA), 15))

# as.igraph
if (requireNamespace("igraph", quietly = TRUE)) {
    txt <- c("a a a b b c", "a a c e", "a c e f g")
    mat <- fcm(txt)
    as.igraph(mat, min_freq = 1, omit_isolated = FALSE)
}



cleanEx()
nameEx("textplot_scale1d")
### * textplot_scale1d

flush(stderr()); flush(stdout())

### Name: textplot_scale1d
### Title: Plot a fitted scaling model
### Aliases: textplot_scale1d
### Keywords: textplot

### ** Examples

## Not run: 
##D ie_dfm <- dfm(data_corpus_irishbudget2010)
##D doclab <- apply(docvars(data_corpus_irishbudget2010, c("name", "party")), 
##D                 1, paste, collapse = " ")
##D 
##D ## wordscores
##D refscores <- c(rep(NA, 4), 1, -1, rep(NA, 8))
##D ws <- textmodel_wordscores(ie_dfm, refscores, smooth = 1)
##D # plot estimated word positions
##D textplot_scale1d(ws, highlighted = c("minister", "have", "our", "budget"))
##D # plot estimated document positions
##D textplot_scale1d(predict(ws, se.fit = TRUE), doclabels = doclab,
##D                  groups = docvars(data_corpus_irishbudget2010, "party"))
##D 
##D ## wordfish
##D wf <- textmodel_wordfish(dfm(data_corpus_irishbudget2010), dir = c(6,5))
##D # plot estimated document positions
##D textplot_scale1d(wf, doclabels = doclab)
##D textplot_scale1d(wf, doclabels = doclab,
##D                  groups = docvars(data_corpus_irishbudget2010, "party"))
##D # plot estimated word positions
##D textplot_scale1d(wf, margin = "features", 
##D                  highlighted = c("government", "global", "children", 
##D                                  "bank", "economy", "the", "citizenship",
##D                                  "productivity", "deficit"))
##D 
##D ## correspondence analysis
##D ca <- textmodel_ca(ie_dfm)
##D # plot estimated document positions
##D textplot_scale1d(ca, margin = "documents",
##D                  doclabels = doclab,
##D                  groups = docvars(data_corpus_irishbudget2010, "party"))
## End(Not run)



cleanEx()
nameEx("textplot_wordcloud")
### * textplot_wordcloud

flush(stderr()); flush(stdout())

### Name: textplot_wordcloud
### Title: Plot features as a wordcloud
### Aliases: textplot_wordcloud
### Keywords: textplot

### ** Examples

# plot the features (without stopwords) from Obama's inaugural addresses
set.seed(10)
obama_dfm <- 
    dfm(corpus_subset(data_corpus_inaugural, President == "Obama"),
        remove = stopwords("english"), remove_punct = TRUE) %>%
    dfm_trim(min_termfreq = 3)
    
# basic wordcloud
textplot_wordcloud(obama_dfm)

# plot in colors with some additional options
textplot_wordcloud(obama_dfm, rotation = 0.25, 
                   color = rev(RColorBrewer::brewer.pal(10, "RdBu")))
  
# other display options
col <- sapply(seq(0.1, 1, 0.1), function(x) adjustcolor("#1F78B4", x))
textplot_wordcloud(obama_dfm, adjust = 0.5, random_order = FALSE, 
                   color = col, rotation = FALSE)
  
# comparison plot of Obama v. Trump
obama_trump_dfm <- 
    dfm(corpus_subset(data_corpus_inaugural, President %in% c("Obama", "Trump")),
        remove = stopwords("english"), remove_punct = TRUE, groups = "President") %>%
    dfm_trim(min_termfreq = 3)

textplot_wordcloud(obama_trump_dfm, comparison = TRUE, max_words = 300,
                   color = c("blue", "red"))



cleanEx()
nameEx("textplot_xray")
### * textplot_xray

flush(stderr()); flush(stdout())

### Name: textplot_xray
### Title: Plot the dispersion of key word(s)
### Aliases: textplot_xray
### Keywords: textplot

### ** Examples

## Not run: 
##D data_corpus_inauguralPost70 <- corpus_subset(data_corpus_inaugural, Year > 1970)
##D # compare multiple documents
##D textplot_xray(kwic(data_corpus_inauguralPost70, "american"))
##D textplot_xray(kwic(data_corpus_inauguralPost70, "american"), scale = "absolute")
##D # compare multiple terms across multiple documents
##D textplot_xray(kwic(data_corpus_inauguralPost70, "america*"), 
##D               kwic(data_corpus_inauguralPost70, "people"))
##D 
##D # how to modify the ggplot with different options
##D library(ggplot2)
##D g <- textplot_xray(kwic(data_corpus_inauguralPost70, "american"), 
##D                    kwic(data_corpus_inauguralPost70, "people"))
##D g + aes(color = keyword) + scale_color_manual(values = c('red', 'blue'))
##D 
##D # adjust the names of the document names
##D docnames(data_corpus_inauguralPost70) <- apply(docvars(data_corpus_inauguralPost70, 
##D                                                        c("Year", "President")), 
##D                                               1, paste, collapse = ", ")
##D textplot_xray(kwic(data_corpus_inauguralPost70, "america*"), 
##D               kwic(data_corpus_inauguralPost70, "people"))
## End(Not run)



cleanEx()
nameEx("texts")
### * texts

flush(stderr()); flush(stdout())

### Name: texts
### Title: Get or assign corpus texts
### Aliases: texts texts<- as.character.corpus
### Keywords: corpus

### ** Examples

nchar(texts(corpus_subset(data_corpus_inaugural, Year < 1806)))

# grouping on a document variable
nchar(texts(corpus_subset(data_corpus_inaugural, Year < 1806), groups = "President"))

# grouping a character vector using a factor
nchar(data_char_ukimmig2010[1:5])
nchar(texts(data_corpus_inaugural[1:5], 
            groups = as.factor(data_corpus_inaugural[1:5, "President"])))

BritCorpus <- corpus(c("We must prioritise honour in our neighbourhood.", 
                       "Aluminium is a valourous metal."))
texts(BritCorpus) <- 
    stringi::stri_replace_all_regex(texts(BritCorpus),
                                   c("ise", "([nlb])our", "nium"),
                                   c("ize", "$1or", "num"),
                                   vectorize_all = FALSE)
texts(BritCorpus)
texts(BritCorpus)[2] <- "New text number 2."
texts(BritCorpus)



cleanEx()
nameEx("textstat_collocations")
### * textstat_collocations

flush(stderr()); flush(stdout())

### Name: textstat_collocations
### Title: Identify and score multi-word expressions
### Aliases: textstat_collocations collocations is.collocations
### Keywords: collocations textstat

### ** Examples

txts <- data_corpus_inaugural[1:2]
head(cols <- textstat_collocations(txts, size = 2, min_count = 2), 10)
head(cols <- textstat_collocations(txts, size = 3, min_count = 2), 10)

# extracting multi-part proper nouns (capitalized terms)
toks2 <- tokens(data_corpus_inaugural)
toks2 <- tokens_remove(toks2, stopwords("english"), padding = TRUE)
toks2 <- tokens_select(toks2, "^([A-Z][a-z\\-]{2,})", valuetype = "regex", 
                       case_insensitive = FALSE, padding = TRUE)
seqs <- textstat_collocations(toks2, size = 3, tolower = FALSE)
head(seqs, 10)

# vectorized size
txt <- c(". . . . a b c . . a b c . . . c d e",
         "a b . . a b . . a b . . a b . a b",
         "b c d . . b c . b c . . . b c")
textstat_collocations(txt, size = 2:3)




cleanEx()
nameEx("textstat_frequency")
### * textstat_frequency

flush(stderr()); flush(stdout())

### Name: textstat_frequency
### Title: Tabulate feature frequencies
### Aliases: textstat_frequency
### Keywords: plot

### ** Examples

dfm1 <- dfm(c("a a b b c d", "a d d d", "a a a"))
textstat_frequency(dfm1)
textstat_frequency(dfm1, groups = c("one", "two", "one"))

obamadfm <- 
    corpus_subset(data_corpus_inaugural, President == "Obama") %>%
    dfm(remove_punct = TRUE, remove = stopwords("english"))
freq <- textstat_frequency(obamadfm)
head(freq, 10)




cleanEx()
nameEx("textstat_keyness")
### * textstat_keyness

flush(stderr()); flush(stdout())

### Name: textstat_keyness
### Title: Calculate keyness statistics
### Aliases: textstat_keyness
### Keywords: textstat

### ** Examples

# compare pre- v. post-war terms using grouping
period <- ifelse(docvars(data_corpus_inaugural, "Year") < 1945, "pre-war", "post-war")
mydfm <- dfm(data_corpus_inaugural, groups = period)
head(mydfm) # make sure 'post-war' is in the first row
head(result <- textstat_keyness(mydfm), 10)
tail(result, 10)

# compare pre- v. post-war terms using logical vector
mydfm2 <- dfm(data_corpus_inaugural)
textstat_keyness(mydfm2, docvars(data_corpus_inaugural, "Year") >= 1945)

# compare Trump 2017 to other post-war preseidents
pwdfm <- dfm(corpus_subset(data_corpus_inaugural, period == "post-war"))
head(textstat_keyness(pwdfm, target = "2017-Trump"), 10)
# using the likelihood ratio method
head(textstat_keyness(dfm_smooth(pwdfm), measure = "lr", target = "2017-Trump"), 10)



cleanEx()
nameEx("textstat_lexdiv")
### * textstat_lexdiv

flush(stderr()); flush(stdout())

### Name: textstat_lexdiv
### Title: Calculate lexical diversity
### Aliases: textstat_lexdiv

### ** Examples

mydfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1980), verbose = FALSE)
(result <- textstat_lexdiv(mydfm, c("CTTR", "TTR", "U")))
cor(textstat_lexdiv(mydfm, "all")[,-1])




cleanEx()
nameEx("textstat_readability")
### * textstat_readability

flush(stderr()); flush(stdout())

### Name: textstat_readability
### Title: Calculate readability
### Aliases: textstat_readability

### ** Examples

txt <- c("Readability zero one.  Ten, Eleven.", "The cat in a dilapidated tophat.")
textstat_readability(txt, "Flesch.Kincaid")
textstat_readability(txt, c("FOG", "FOG.PSK", "FOG.NRI"))
inaugReadability <- textstat_readability(data_corpus_inaugural, "all")
cor(inaugReadability[,-1])

textstat_readability(data_corpus_inaugural, measure = "Flesch.Kincaid")
inaugReadability <- textstat_readability(data_corpus_inaugural, "all")
cor(inaugReadability[,-1])



cleanEx()
nameEx("textstat_select")
### * textstat_select

flush(stderr()); flush(stdout())

### Name: textstat_select
### Title: Select rows of textstat objects by glob, regex or fixed patterns
### Aliases: textstat_select
### Keywords: internal textstat

### ** Examples

period <- ifelse(docvars(data_corpus_inaugural, "Year") < 1945, "pre-war", "post-war")
mydfm <- dfm(data_corpus_inaugural, groups = period)
keyness <- textstat_keyness(mydfm)
textstat_select(keyness, 'america*')




cleanEx()
nameEx("textstat_simil")
### * textstat_simil

flush(stderr()); flush(stdout())

### Name: textstat_dist
### Title: Similarity and distance computation between documents or
###   features
### Aliases: textstat_dist textstat_simil

### ** Examples

# create a dfm from inaugural addresses from Reagan onwards
presDfm <- dfm(corpus_subset(data_corpus_inaugural, Year > 1990), 
               remove = stopwords("english"), stem = TRUE, remove_punct = TRUE)
               
# distances for documents 
(d1 <- textstat_dist(presDfm, margin = "documents"))
as.matrix(d1)

# distances for specific documents
textstat_dist(presDfm, "2017-Trump", margin = "documents")
textstat_dist(presDfm, "2005-Bush", margin = "documents", method = "jaccard")
(d2 <- textstat_dist(presDfm, c("2009-Obama" , "2013-Obama"), margin = "documents"))
as.list(d1)

# similarities for documents
pres_dfm <- dfm(data_corpus_inaugural, remove_punct = TRUE, remove = stopwords("english"))
(s1 <- textstat_simil(pres_dfm, method = "cosine", margin = "documents"))
as.matrix(s1)
as.list(s1)

# similarities for for specific documents
textstat_simil(pres_dfm, "2017-Trump", margin = "documents")
textstat_simil(pres_dfm, "2017-Trump", method = "cosine", margin = "documents")
textstat_simil(pres_dfm, c("2009-Obama" , "2013-Obama"), margin = "documents")

# compute some term similarities
s2 <- textstat_simil(pres_dfm, c("fair", "health", "terror"), method = "cosine", 
                      margin = "features")
head(as.matrix(s2), 10)
as.list(s2, n = 8)




cleanEx()
nameEx("tokens")
### * tokens

flush(stderr()); flush(stdout())

### Name: tokens
### Title: Tokenize a set of texts
### Aliases: tokens
### Keywords: tokens

### ** Examples

txt <- c(doc1 = "This is a sample: of tokens.",
         doc2 = "Another sentence, to demonstrate how tokens works.")
tokens(txt)
# removing punctuation marks and lowecasing texts
tokens(char_tolower(txt), remove_punct = TRUE)
# keeping versus removing hyphens
tokens("quanteda data objects are auto-loading.", remove_punct = TRUE)
tokens("quanteda data objects are auto-loading.", remove_punct = TRUE, remove_hyphens = TRUE)
# keeping versus removing symbols
tokens("<tags> and other + symbols.", remove_symbols = FALSE)
tokens("<tags> and other + symbols.", remove_symbols = TRUE)
tokens("<tags> and other + symbols.", remove_symbols = FALSE, what = "fasterword")
tokens("<tags> and other + symbols.", remove_symbols = TRUE, what = "fasterword")

## examples with URLs - hardly perfect!
txt <- "Repo https://githib.com/kbenoit/quanteda, and www.stackoverflow.com."
tokens(txt, remove_url = TRUE, remove_punct = TRUE)
tokens(txt, remove_url = FALSE, remove_punct = TRUE)
tokens(txt, remove_url = FALSE, remove_punct = TRUE, what = "fasterword")
tokens(txt, remove_url = FALSE, remove_punct = FALSE, what = "fasterword")


## MORE COMPARISONS
txt <- "#textanalysis is MY <3 4U @myhandle gr8 #stuff :-)"
tokens(txt, remove_punct = TRUE)
tokens(txt, remove_punct = TRUE, remove_twitter = TRUE)
#tokens("great website http://textasdata.com", remove_url = FALSE)
#tokens("great website http://textasdata.com", remove_url = TRUE)

txt <- c(text1="This is $10 in 999 different ways,\n up and down; left and right!", 
         text2="@kenbenoit working: on #quanteda 2day\t4ever, http://textasdata.com?page=123.")
tokens(txt, verbose = TRUE)
tokens(txt, remove_numbers = TRUE, remove_punct = TRUE)
tokens(txt, remove_numbers = FALSE, remove_punct = TRUE)
tokens(txt, remove_numbers = TRUE, remove_punct = FALSE)
tokens(txt, remove_numbers = FALSE, remove_punct = FALSE)
tokens(txt, remove_numbers = FALSE, remove_punct = FALSE, remove_separators = FALSE)
tokens(txt, remove_numbers = TRUE, remove_punct = TRUE, remove_url = TRUE)

# character level
tokens("Great website: http://textasdata.com?page=123.", what = "character")
tokens("Great website: http://textasdata.com?page=123.", what = "character", 
         remove_separators = FALSE)

# sentence level         
tokens(c("Kurt Vongeut said; only assholes use semi-colons.", 
           "Today is Thursday in Canberra:  It is yesterday in London.", 
           "Today is Thursday in Canberra:  \nIt is yesterday in London.",
           "To be?  Or\nnot to be?"), 
          what = "sentence")
tokens(data_corpus_inaugural[c(2,40)], what = "sentence")

# removing features (stopwords) from tokenized texts
txt <- char_tolower(c(mytext1 = "This is a short test sentence.",
                      mytext2 = "Short.",
                      mytext3 = "Short, shorter, and shortest."))
tokens(txt, remove_punct = TRUE)
tokens_remove(tokens(txt, remove_punct = TRUE), stopwords("english"))

# ngram tokenization
tokens(txt, remove_punct = TRUE, ngrams = 2)
tokens(txt, remove_punct = TRUE, ngrams = 2, skip = 1, concatenator = " ")
tokens(txt, remove_punct = TRUE, ngrams = 1:2)
# removing features from ngram tokens
tokens_remove(tokens(txt, remove_punct = TRUE, ngrams = 1:2), stopwords("english"))



cleanEx()
nameEx("tokens_compound")
### * tokens_compound

flush(stderr()); flush(stdout())

### Name: tokens_compound
### Title: Convert token sequences into compound tokens
### Aliases: tokens_compound

### ** Examples

mytexts <- c("The new law included a capital gains tax, and an inheritance tax.",
             "New York City has raised taxes: an income tax and inheritance taxes.")
mytoks <- tokens(mytexts, remove_punct = TRUE)

# for lists of sequence elements
myseqs <- list(c("tax"), c("income", "tax"), c("capital", "gains", "tax"), c("inheritance", "tax"))
(cw <- tokens_compound(mytoks, myseqs))
dfm(cw)

# when used as a dictionary for dfm creation
mydict1 <- dictionary(list(tax=c("tax", "income tax", "capital gains tax", "inheritance tax*")))
(cw2 <- tokens_compound(mytoks, mydict1))

# to pick up "taxes" in the second text, set valuetype = "regex"
(cw3 <- tokens_compound(mytoks, mydict1, valuetype = "regex"))

# dictionaries w/glob matches
mydict2 <- dictionary(list(negative = c("bad* word*", "negative", "awful text"),
                          positive = c("good stuff", "like? th??")))
toks <- tokens(c(txt1 = "I liked this, when we can use bad words, in awful text.",
                 txt2 = "Some damn good stuff, like the text, she likes that too."))
tokens_compound(toks, mydict2)

# with collocations
cols <- 
    textstat_collocations(tokens("capital gains taxes are worse than inheritance taxes"), 
                                  size = 2, min_count = 1)
toks <- tokens("The new law included capital gains taxes and inheritance taxes.")
tokens_compound(toks, cols)



cleanEx()
nameEx("tokens_group")
### * tokens_group

flush(stderr()); flush(stdout())

### Name: tokens_group
### Title: Recombine documents tokens by groups
### Aliases: tokens_group
### Keywords: internal tokens

### ** Examples

# dfm_group examples
corp <- corpus(c("a a b", "a b c c", "a c d d", "a c c d"), 
                   docvars = data.frame(grp = c("grp1", "grp1", "grp2", "grp2")))
toks <- tokens(corp)
quanteda:::tokens_group(toks, groups = "grp")
quanteda:::tokens_group(toks, groups = c(1, 1, 2, 2))
quanteda:::tokens_group(toks, groups = factor(c(1, 1, 2, 2), levels = 1:3))



cleanEx()
nameEx("tokens_lookup")
### * tokens_lookup

flush(stderr()); flush(stdout())

### Name: tokens_lookup
### Title: Apply a dictionary to a tokens object
### Aliases: tokens_lookup
### Keywords: tokens

### ** Examples

toks <- tokens(data_corpus_inaugural)
dict <- dictionary(list(country = "united states", 
                   law=c('law*', 'constitution'), 
                   freedom=c('free*', 'libert*')))
dfm(tokens_lookup(toks, dict, valuetype='glob', verbose = TRUE))
dfm(tokens_lookup(toks, dict, valuetype='glob', verbose = TRUE, nomatch = 'NONE'))

dict_fix <- dictionary(list(country = "united states", 
                       law = c('law', 'constitution'), 
                       freedom = c('freedom', 'liberty'))) 
# dfm(applyDictionary(toks, dict_fix, valuetype='fixed'))
dfm(tokens_lookup(toks, dict_fix, valuetype='fixed'))

# hierarchical dictionary example
txt <- c(d1 = "The United States has the Atlantic Ocean and the Pacific Ocean.",
         d2 = "Britain and Ireland have the Irish Sea and the English Channel.")
toks <- tokens(txt)
dict <- dictionary(list(US = list(Countries = c("States"), 
                                  oceans = c("Atlantic", "Pacific")),
                        Europe = list(Countries = c("Britain", "Ireland"),
                                      oceans = list(west = "Irish Sea", 
                                                    east = "English Channel"))))
tokens_lookup(toks, dict, levels = 1)
tokens_lookup(toks, dict, levels = 2)
tokens_lookup(toks, dict, levels = 1:2)
tokens_lookup(toks, dict, levels = 3)
tokens_lookup(toks, dict, levels = c(1,3))
tokens_lookup(toks, dict, levels = c(2,3))

# show unmatched tokens
tokens_lookup(toks, dict, nomatch = "_UNMATCHED")




cleanEx()
nameEx("tokens_ngrams")
### * tokens_ngrams

flush(stderr()); flush(stdout())

### Name: tokens_ngrams
### Title: Create ngrams and skipgrams from tokens
### Aliases: tokens_ngrams char_ngrams tokens_skipgrams

### ** Examples

# ngrams
tokens_ngrams(tokens(c("a b c d e", "c d e f g")), n = 2:3)

toks <- tokens(c(text1 = "the quick brown fox jumped over the lazy dog"))
tokens_ngrams(toks, n = 1:3)
tokens_ngrams(toks, n = c(2,4), concatenator = " ")
tokens_ngrams(toks, n = c(2,4), skip = 1, concatenator = " ")

# on character
char_ngrams(letters[1:3], n = 1:3)

# skipgrams
toks <- tokens("insurgents killed in ongoing fighting")
tokens_skipgrams(toks, n = 2, skip = 0:1, concatenator = " ") 
tokens_skipgrams(toks, n = 2, skip = 0:2, concatenator = " ") 
tokens_skipgrams(toks, n = 3, skip = 0:2, concatenator = " ")   



cleanEx()
nameEx("tokens_recompile")
### * tokens_recompile

flush(stderr()); flush(stdout())

### Name: tokens_recompile
### Title: recompile a serialized tokens object
### Aliases: tokens_recompile
### Keywords: internal tokens

### ** Examples

# lowercasing
toks1 <- tokens(c(one = "a b c d A B C D",
                 two = "A B C d"))
attr(toks1, "types") <- char_tolower(attr(toks1, "types"))
unclass(toks1)
unclass(quanteda:::tokens_recompile(toks1))

# stemming
toks2 <- tokens("Stemming stemmed many word stems.")
unclass(toks2)
unclass(quanteda:::tokens_recompile(tokens_wordstem(toks2)))

# compounding
toks3 <- tokens("One two three four.")
unclass(toks3)
unclass(tokens_compound(toks3, "two three"))

# lookup
dict <- dictionary(list(test = c("one", "three")))
unclass(tokens_lookup(toks3, dict))

# empty pads
unclass(tokens_select(toks3, dict))
unclass(tokens_select(toks3, dict, pad = TRUE))

# ngrams
unclass(tokens_ngrams(toks3, n = 2:3))




cleanEx()
nameEx("tokens_replace")
### * tokens_replace

flush(stderr()); flush(stdout())

### Name: tokens_replace
### Title: Replace types in tokens object
### Aliases: tokens_replace

### ** Examples

toks <- tokens(data_corpus_irishbudget2010)

# lemmatization
infle <- c("foci", "focus", "focused", "focuses", "focusing", "focussed", "focusses")
lemma <- rep("focus", length(infle))
toks2 <- tokens_replace(toks, infle, lemma)
kwic(toks2, "focus*")

# stemming
type <- types(toks)
stem <- char_wordstem(type, "porter")
toks3 <- tokens_replace(toks, type, stem, case_insensitive = FALSE)
identical(toks3, tokens_wordstem(toks, "porter"))



cleanEx()
nameEx("tokens_segment")
### * tokens_segment

flush(stderr()); flush(stdout())

### Name: tokens_segment
### Title: Segment tokens object by patterns
### Aliases: tokens_segment
### Keywords: internal tokens

### ** Examples

txts <- "Fellow citizens, I am again called upon by the voice of my country to
execute the functions of its Chief Magistrate. When the occasion proper for
it shall arrive, I shall endeavor to express the high sense I entertain of
this distinguished honor."
toks <- tokens(txts)

# split by any punctuation
toks_punc <- tokens_segment(toks, c(".", "?", "!"), valuetype = "fixed", 
                            pattern_position = "after")
toks_punc <- tokens_segment(toks, "^\\p{Sterm}$", valuetype = "regex", 
                            extract_pattern = FALSE, 
                            pattern_position = "after")



cleanEx()
nameEx("tokens_select")
### * tokens_select

flush(stderr()); flush(stdout())

### Name: tokens_select
### Title: Select or remove tokens from a tokens object
### Aliases: tokens_select tokens_remove tokens_keep

### ** Examples

## tokens_select with simple examples
toks <- tokens(c("This is a sentence.", "This is a second sentence."), 
                 remove_punct = TRUE)
tokens_select(toks, c("is", "a", "this"), selection = "keep", padding = FALSE)
tokens_select(toks, c("is", "a", "this"), selection = "keep", padding = TRUE)
tokens_select(toks, c("is", "a", "this"), selection = "remove", padding = FALSE)
tokens_select(toks, c("is", "a", "this"), selection = "remove", padding = TRUE)

# how case_insensitive works
tokens_select(toks, c("is", "a", "this"), selection = "remove", case_insensitive = TRUE)
tokens_select(toks, c("is", "a", "this"), selection = "remove", case_insensitive = FALSE)

# use window
tokens_select(toks, "second", selection = "keep", window = 1)
tokens_select(toks, "second", selection = "remove", window = 1)
tokens_remove(toks, "is", window = c(0, 1))

# tokens_remove example: remove stopwords
txt <- c(wash1 <- "Fellow citizens, I am again called upon by the voice of my country to
                   execute the functions of its Chief Magistrate.",
         wash2 <- "When the occasion proper for it shall arrive, I shall endeavor to express
                   the high sense I entertain of this distinguished honor.")
tokens_remove(tokens(txt, remove_punct = TRUE), stopwords("english"))

# token_keep example: keep two-letter words
tokens_keep(tokens(txt, remove_punct = TRUE), "??")



cleanEx()
nameEx("tokens_subset")
### * tokens_subset

flush(stderr()); flush(stdout())

### Name: tokens_subset
### Title: Extract a subset of a tokens
### Aliases: tokens_subset
### Keywords: tokens

### ** Examples

corp <- corpus(c(d1 = "a b c d", d2 = "a a b e",
                 d3 = "b b c e", d4 = "e e f a b"),
                 docvars = data.frame(grp = c(1, 1, 2, 3)))
toks <- tokens(corp)
# selecting on a docvars condition
tokens_subset(toks, grp > 1)
# selecting on a supplied vector
tokens_subset(toks, c(TRUE, FALSE, TRUE, FALSE))

# selecting on a tokens
toks1 <- tokens(c(d1 = "a b b c", d2 = "b b c d"))
toks2 <- tokens(c(d1 = "x y z", d2 = "a b c c d", d3 = "x x x"))
tokens_subset(toks1, subset = toks2)
tokens_subset(toks1, subset = toks2[c(3,1,2)])



cleanEx()
nameEx("tokens_tolower")
### * tokens_tolower

flush(stderr()); flush(stdout())

### Name: tokens_tolower
### Title: Convert the case of tokens
### Aliases: tokens_tolower tokens_toupper

### ** Examples

# for a document-feature matrix
toks <- tokens(c(txt1 = "b A A", txt2 = "C C a b B"))
tokens_tolower(toks) 
tokens_toupper(toks)



cleanEx()
nameEx("tokens_wordstem")
### * tokens_wordstem

flush(stderr()); flush(stdout())

### Name: tokens_wordstem
### Title: Stem the terms in an object
### Aliases: tokens_wordstem char_wordstem dfm_wordstem

### ** Examples

# example applied to tokens
txt <- c(one = "eating eater eaters eats ate",
         two = "taxing taxes taxed my tax return")
th <- tokens(txt)
tokens_wordstem(th)

# simple example
char_wordstem(c("win", "winning", "wins", "won", "winner"))

# example applied to a dfm
(origdfm <- dfm(txt))
dfm_wordstem(origdfm)




cleanEx()
nameEx("topfeatures")
### * topfeatures

flush(stderr()); flush(stdout())

### Name: topfeatures
### Title: Identify the most frequent features in a dfm
### Aliases: topfeatures

### ** Examples

mydfm <- corpus_subset(data_corpus_inaugural, Year > 1980) %>%
    dfm(remove_punct = TRUE)
mydfm_nostopw <- dfm_remove(mydfm, stopwords("english"))

# most frequent features
topfeatures(mydfm)
topfeatures(mydfm_nostopw)

# least frequent features
topfeatures(mydfm_nostopw, decreasing = FALSE)

# top features of individual documents  
topfeatures(mydfm_nostopw, n = 5, groups = docnames(mydfm_nostopw))

# grouping by president last name
topfeatures(mydfm_nostopw, n = 5, groups = "President")

# features by document frequencies
tail(topfeatures(mydfm, scheme = "docfreq", n = 200))



cleanEx()
nameEx("types")
### * types

flush(stderr()); flush(stdout())

### Name: types
### Title: Get word types from a tokens object
### Aliases: types

### ** Examples

toks <- tokens(data_corpus_inaugural)
types(toks)



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
