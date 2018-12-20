pkgname <- "ggpage"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('ggpage')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("break_help")
### * break_help

flush(stderr()); flush(stdout())

### Name: break_help
### Title: Repeating of indexes
### Aliases: break_help

### ** Examples

break_help(c(1, 2, 3))
break_help(c(6, 8, 23, 50))



cleanEx()
nameEx("ggpage_build")
### * ggpage_build

flush(stderr()); flush(stdout())

### Name: ggpage_build
### Title: Creates a data frame for further analysis and plotting
### Aliases: ggpage_build

### ** Examples




cleanEx()
nameEx("ggpage_plot")
### * ggpage_plot

flush(stderr()); flush(stdout())

### Name: ggpage_plot
### Title: Creates a visualization from the ggpage_build output
### Aliases: ggpage_plot

### ** Examples




cleanEx()
nameEx("ggpage_quick")
### * ggpage_quick

flush(stderr()); flush(stdout())

### Name: ggpage_quick
### Title: Creates a quick visualization of the page layout
### Aliases: ggpage_quick

### ** Examples




cleanEx()
nameEx("paper_shape")
### * paper_shape

flush(stderr()); flush(stdout())

### Name: paper_shape
### Title: Identify the edges of the paper of each page
### Aliases: paper_shape

### ** Examples

paper_shape(ggpage_build(tinderbox))



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
