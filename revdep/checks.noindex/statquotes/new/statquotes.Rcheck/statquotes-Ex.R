pkgname <- "statquotes"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('statquotes')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("quote_cloud")
### * quote_cloud

flush(stderr()); flush(stdout())

### Name: quote_cloud
### Title: Function to generate word cloud based upon quote database
### Aliases: quote_cloud

### ** Examples

quote_cloud()
quote_cloud(search = "graph")
quote_cloud(max.words = 10)



cleanEx()
nameEx("quote_topics")
### * quote_topics

flush(stderr()); flush(stdout())

### Name: quote_topics
### Title: List the topics of the quotes data base
### Aliases: quote_topics

### ** Examples

quote_topics()
quote_topics(TRUE)



cleanEx()
nameEx("search_quotes")
### * search_quotes

flush(stderr()); flush(stdout())

### Name: search_quotes
### Title: Function to search quote database
### Aliases: search_quotes

### ** Examples

search_quotes("^D") # regex to find all quotes that start with "D"
search_quotes("Tukey") #all quotes with "Tukey"
search_quotes("bad answer", fuzzy = TRUE) # fuzzy match

# to a data.frame
out <- search_quotes("bad answer", fuzzy = TRUE)
as.data.frame(out)




cleanEx()
nameEx("statquote")
### * statquote

flush(stderr()); flush(stdout())

### Name: statquote
### Title: Function to display a randomly chosen statistical quote
### Aliases: statquote print.statquote as.data.frame.statquote

### ** Examples

 set.seed(1234)
 statquote()
 statquote(source="Tukey")
 statquote(topic="science")
 statquote(topic="history")




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
