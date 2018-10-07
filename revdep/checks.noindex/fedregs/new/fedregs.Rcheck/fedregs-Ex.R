pkgname <- "fedregs"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('fedregs')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("cfr_part")
### * cfr_part

flush(stderr()); flush(stdout())

### Name: cfr_part
### Title: Parse the Relevant Details for CFR urls.
### Aliases: cfr_part

### ** Examples






cleanEx()
nameEx("cfr_text")
### * cfr_text

flush(stderr()); flush(stdout())

### Name: cfr_text
### Title: Extract the Text for a Given Year, Title, Chapter, and Part
### Aliases: cfr_text

### ** Examples





cleanEx()
nameEx("cfr_urls")
### * cfr_urls

flush(stderr()); flush(stdout())

### Name: cfr_urls
### Title: URLs for .xml Code of Federal Regulations.
### Aliases: cfr_urls

### ** Examples






cleanEx()
nameEx("numextract")
### * numextract

flush(stderr()); flush(stdout())

### Name: numextract
### Title: Extract the Part Numbers
### Aliases: numextract
### Keywords: internal

### ** Examples





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
