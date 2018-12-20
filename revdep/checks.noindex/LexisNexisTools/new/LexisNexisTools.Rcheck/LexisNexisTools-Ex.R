pkgname <- "LexisNexisTools"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('LexisNexisTools')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("lnt_add")
### * lnt_add

flush(stderr()); flush(stdout())

### Name: lnt_add
### Title: Adds or replaces articles
### Aliases: lnt_add

### ** Examples

# Make LNToutput object from sample
LNToutput <- lnt_read(lnt_sample())

# extract meta and make corrections
correction <- LNToutput@meta[grepl("Wikipedia", LNToutput@meta$Headline), ]
correction$Newspaper <- "Wikipedia"

# replace corrected meta information
LNToutput <- lnt_add(to = LNToutput, what = correction, where = "meta", replace = TRUE)



cleanEx()
nameEx("lnt_asDate")
### * lnt_asDate

flush(stderr()); flush(stdout())

### Name: lnt_asDate
### Title: Convert Strings to dates
### Aliases: lnt_asDate

### ** Examples

LNToutput <- lnt_read(lnt_sample(), convert_date = FALSE)
d <- lnt_asDate(LNToutput@meta$Date)
d



cleanEx()
nameEx("lnt_convert")
### * lnt_convert

flush(stderr()); flush(stdout())

### Name: lnt_convert
### Title: Convert LNToutput to other formats
### Aliases: lnt_convert lnt2rDNA lnt2quanteda lnt2tm lnt2cptools
###   lnt2SQLite

### ** Examples

LNToutput <- lnt_read(lnt_sample())

docs <- lnt_convert(LNToutput, to = "rDNA")

corpus <- lnt_convert(LNToutput, to = "quanteda")

dbloc <- lnt_convert(LNToutput, to = "lnt2SQLite")

tCorpus <- lnt_convert(LNToutput, to = "corpustools")

tidy <- lnt_convert(LNToutput, to = "tidytext")

Corpus <- lnt_convert(LNToutput, to = "tm")



cleanEx()
nameEx("lnt_diff")
### * lnt_diff

flush(stderr()); flush(stdout())

### Name: lnt_diff
### Title: Display diff of similar articles
### Aliases: lnt_diff

### ** Examples

# Test similarity of articles
duplicates.df <- lnt_similarity(LNToutput = lnt_read(lnt_sample()),
                                threshold = 0.95)

lnt_diff(duplicates.df, min = 0.18, max = 0.30)



cleanEx()
nameEx("lnt_lookup")
### * lnt_lookup

flush(stderr()); flush(stdout())

### Name: lnt_lookup
### Title: Lookup keywords in articles
### Aliases: lnt_lookup

### ** Examples

# Make LNToutput object from sample
LNToutput <- lnt_read(lnt_sample())

# Lookup keywords
LNToutput@meta$Keyword <- lnt_lookup(LNToutput,
                                     "statistical computing")

# Keep only articles which mention the keyword
LNToutput_stat <- LNToutput[!sapply(LNToutput@meta$Keyword, is.null)]

# Covert list of keywords to string
LNToutput@meta$Keyword <- sapply(LNToutput@meta$Keyword, toString)



cleanEx()
nameEx("lnt_read")
### * lnt_read

flush(stderr()); flush(stdout())

### Name: lnt_read
### Title: Read in a LexisNexis TXT file
### Aliases: lnt_read

### ** Examples

LNToutput <- lnt_read(lnt_sample())
meta.df <- LNToutput@meta
articles.df <- LNToutput@articles
paragraphs.df <- LNToutput@paragraphs



cleanEx()
nameEx("lnt_rename")
### * lnt_rename

flush(stderr()); flush(stdout())

### Name: lnt_rename
### Title: Assign proper names to LexisNexis TXT files
### Aliases: lnt_rename
### Keywords: LexisNexis

### ** Examples


# Copy sample file to current wd
lnt_sample()

# Rename files in current wd and report back if successful
 ## Not run: 
##D report.df <- lnt_rename(recursive = FALSE,
##D                         report = TRUE)
## End(Not run)

# Or provide file name(s)
my_files<-list.files(pattern = ".txt", full.names = TRUE,
                     recursive = TRUE, ignore.case = TRUE)
report.df <- lnt_rename(x = my_files,
                        recursive = FALSE,
                        report = TRUE)

# Or provide folder name(s)
report.df <- lnt_rename(x = getwd())

report.df



cleanEx()
nameEx("lnt_sample")
### * lnt_sample

flush(stderr()); flush(stdout())

### Name: lnt_sample
### Title: Provides a small sample TXT file
### Aliases: lnt_sample

### ** Examples

lnt_sample()



cleanEx()
nameEx("lnt_similarity")
### * lnt_similarity

flush(stderr()); flush(stdout())

### Name: lnt_similarity
### Title: Check for highly similar articles.
### Aliases: lnt_similarity
### Keywords: similarity

### ** Examples

# Copy sample file to current wd
lnt_sample()

# Convert raw file to LNToutput object
LNToutput <- lnt_read(lnt_sample())

# Test similarity of articles
duplicates.df <- lnt_similarity(texts = LNToutput@articles$Article,
                                dates = LNToutput@meta$Date,
                                IDs = LNToutput@articles$ID)

# Remove instances with a high relative distance
duplicates.df <- duplicates.df[duplicates.df$rel_dist < 0.2]

# Create three separate data.frames from cleaned LNToutput object
LNToutput <- LNToutput[!LNToutput@meta$ID %in%
                         duplicates.df$ID_duplicate]
meta.df <- LNToutput@meta
articles.df <- LNToutput@articles
paragraphs.df <- LNToutput@paragraphs



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
