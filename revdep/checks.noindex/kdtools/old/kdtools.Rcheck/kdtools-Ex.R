pkgname <- "kdtools"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('kdtools')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("convert")
### * convert

flush(stderr()); flush(stdout())

### Name: matrix_to_tuples
### Title: Convert a matrix to a vector of arrays
### Aliases: matrix_to_tuples tuples_to_matrix

### ** Examples

x = matrix(1:10, 5)
y = matrix_to_tuples(x)
str(x)
str(y)
y[1:2, ]




cleanEx()
nameEx("kdsort")
### * kdsort

flush(stderr()); flush(stdout())

### Name: kd_sort
### Title: Sort multidimensional data
### Aliases: kd_sort kd_is_sorted

### ** Examples

x = kd_sort(matrix(runif(200), 100))
kd_is_sorted(x)
plot(x, type = "o", pch = 19, col = "steelblue", asp = 1)




cleanEx()
nameEx("lexsort")
### * lexsort

flush(stderr()); flush(stdout())

### Name: lex_sort
### Title: Sort a matrix into lexicographical order
### Aliases: lex_sort

### ** Examples

x = lex_sort(matrix(runif(200), 100))
plot(x, type = "o", pch = 19, col = "steelblue", asp = 1)




cleanEx()
nameEx("nneighb")
### * nneighb

flush(stderr()); flush(stdout())

### Name: kd_nearest_neighbors
### Title: Find nearest neighbors
### Aliases: kd_nearest_neighbors kd_nearest_neighbor

### ** Examples

x = matrix(runif(200), 100)
y = matrix_to_tuples(x)
kd_sort(y, inplace = TRUE)
y[kd_nearest_neighbor(y, c(1/2, 1/2)),]
kd_nearest_neighbors(y, c(1/2, 1/2), 3)




cleanEx()
nameEx("search")
### * search

flush(stderr()); flush(stdout())

### Name: kd_lower_bound
### Title: Search sorted data
### Aliases: kd_lower_bound kd_upper_bound kd_range_query kd_binary_search

### ** Examples

x = matrix(runif(200), 100)
y = matrix_to_tuples(x)
kd_sort(y, inplace = TRUE)
y[kd_lower_bound(y, c(1/2, 1/2)),]
y[kd_upper_bound(y, c(1/2, 1/2)),]
kd_binary_search(y, c(1/2, 1/2))
kd_range_query(y, c(1/3, 1/3), c(2/3, 2/3))




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
