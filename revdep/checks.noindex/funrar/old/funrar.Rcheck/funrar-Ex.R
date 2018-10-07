pkgname <- "funrar"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('funrar')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("compute_dist_matrix")
### * compute_dist_matrix

flush(stderr()); flush(stdout())

### Name: compute_dist_matrix
### Title: Functional Distance Matrix
### Aliases: compute_dist_matrix distance_matrix

### ** Examples

set.seed(1)  # For reproducibility
trait = data.frame(
   sp = paste("sp", 1:5),
   trait_1 = runif(5),
   trait_2 = as.factor(c("A", "A", "A", "B", "B")))

rownames(trait) = trait$sp

dist_mat = compute_dist_matrix(trait[, -1])




cleanEx()
nameEx("distinctiveness")
### * distinctiveness

flush(stderr()); flush(stdout())

### Name: distinctiveness
### Title: Functional Distinctiveness on site-species matrix
### Aliases: distinctiveness

### ** Examples

data("aravo", package = "ade4")
# Site-species matrix
mat = as.matrix(aravo$spe)

# Compute relative abundances
mat = make_relative(mat)

# Example of trait table
tra = aravo$traits[, c("Height", "SLA", "N_mass")]
# Distance matrix
dist_mat = compute_dist_matrix(tra)

di = distinctiveness(pres_matrix = mat, dist_matrix = dist_mat)
di[1:5, 1:5]

# Compute distinctiveness for all species in the regional pool
# i.e., with all the species in all the communities
# Here considering each species present evenly in the regional pool
reg_pool = matrix(1, ncol = ncol(mat))
colnames(reg_pool) = colnames(mat)
row.names(reg_pool) = c("Regional_pool")

reg_di = distinctiveness(reg_pool, dist_mat)




cleanEx()
nameEx("distinctiveness_dimensions")
### * distinctiveness_dimensions

flush(stderr()); flush(stdout())

### Name: distinctiveness_dimensions
### Title: Distinctiveness dimensions
### Aliases: distinctiveness_dimensions

### ** Examples

data("aravo", package = "ade4")

# Site-species matrix
mat = as.matrix(aravo$spe)
rel_mat = make_relative(mat)

# Example of trait table
tra = aravo$traits[, c("Height", "SLA", "N_mass")]

di_dim = distinctiveness_dimensions(rel_mat, tra)




cleanEx()
nameEx("distinctiveness_stack")
### * distinctiveness_stack

flush(stderr()); flush(stdout())

### Name: distinctiveness_stack
### Title: Functional Distinctiveness on a stacked data.frame
### Aliases: distinctiveness_stack

### ** Examples

data("aravo", package = "ade4")

# Example of trait table
tra = aravo$traits[, c("Height", "SLA", "N_mass")]
# Distance matrix
dist_mat = compute_dist_matrix(tra)

# Site-species matrix converted into data.frame
mat = as.matrix(aravo$spe)
mat = make_relative(mat)
dat = matrix_to_stack(mat, "value", "site", "species")
dat$site = as.character(dat$site)
dat$species = as.character(dat$species)

di_df = distinctiveness_stack(dat, "species", "site", "value", dist_mat)
head(di_df)




cleanEx()
nameEx("is_relative")
### * is_relative

flush(stderr()); flush(stdout())

### Name: is_relative
### Title: Tell if matrix or data.frame has relative abundances
### Aliases: is_relative

### ** Examples

data("aravo", package = "ade4")

# Site-species matrix
mat = as.matrix(aravo$spe)
head(mat)[, 1:5]  # Has absolute abundances
rel_mat = make_relative(mat)
head(rel_mat)  # Relative abundances

# Forced to use ':::' becasue function is not exported
funrar:::is_relative(mat)      # FALSE
funrar:::is_relative(rel_mat)  # TRUE




cleanEx()
nameEx("make_relative")
### * make_relative

flush(stderr()); flush(stdout())

### Name: make_relative
### Title: Relative abundance matrix from absolute abundance matrix
### Aliases: make_relative

### ** Examples

data("aravo", package = "ade4")

# Site-species matrix
mat = as.matrix(aravo$spe)
head(mat)[, 1:5]  # Has absolute abundances
rel_mat = make_relative(mat)
head(rel_mat)  # Relative abundances




cleanEx()
nameEx("matrix_to_stack")
### * matrix_to_stack

flush(stderr()); flush(stdout())

### Name: matrix_to_stack
### Title: Matrix to stacked (= tidy) data.frame
### Aliases: matrix_to_stack matrix_to_tidy

### ** Examples

data("aravo", package = "ade4")

# Site-species matrix converted into data.frame
mat = as.matrix(aravo$spe)
dat = matrix_to_stack(mat, "value", "site", "species")
str(dat)




cleanEx()
nameEx("restrictedness")
### * restrictedness

flush(stderr()); flush(stdout())

### Name: restrictedness
### Title: Geographical Restrictedness on site-species matrix
### Aliases: restrictedness

### ** Examples

data("aravo", package = "ade4")
# Site-species matrix
mat = as.matrix(aravo$spe)
ri = restrictedness(mat)
head(ri)




cleanEx()
nameEx("restrictedness_stack")
### * restrictedness_stack

flush(stderr()); flush(stdout())

### Name: restrictedness_stack
### Title: Geographical Restrictedness for stacked data.frame
### Aliases: restrictedness_stack

### ** Examples

data("aravo", package = "ade4")

# Site-species matrix converted into data.frame
mat = as.matrix(aravo$spe)
dat = matrix_to_stack(mat, "value", "site", "species")
dat$site = as.character(dat$site)
dat$species = as.character(dat$species)
ri_df = restrictedness_stack(dat, "species", "site")
head(ri_df)




cleanEx()
nameEx("scarcity")
### * scarcity

flush(stderr()); flush(stdout())

### Name: scarcity
### Title: Scarcity on site-species matrix
### Aliases: scarcity

### ** Examples

data("aravo", package = "ade4")
# Site-species matrix
mat = as.matrix(aravo$spe)
mat = make_relative(mat)

si = scarcity(pres_matrix = mat)
si[1:5, 1:5]




cleanEx()
nameEx("scarcity_stack")
### * scarcity_stack

flush(stderr()); flush(stdout())

### Name: scarcity_stack
### Title: Scarcity
### Aliases: scarcity_stack

### ** Examples

data("aravo", package = "ade4")

# Site-species matrix converted into data.frame
mat = as.matrix(aravo$spe)
mat = make_relative(mat)
dat = matrix_to_stack(mat, "value", "site", "species")
dat$site = as.character(dat$site)
dat$species = as.character(dat$species)

si_df = scarcity_stack(dat, "species", "site", "value")
head(si_df)




cleanEx()
nameEx("stack_to_matrix")
### * stack_to_matrix

flush(stderr()); flush(stdout())

### Name: stack_to_matrix
### Title: Stacked (= tidy) data.frame to matrix
### Aliases: stack_to_matrix tidy_to_matrix

### ** Examples

example = data.frame("sites" = c(rep("1", 3), rep("2", 2)),
 "species" = c("A", "B", "C", "B", "D"),
  "abundance" = c(0.33, 0.33, 0.33, 0.4, 0.6))

mat = stack_to_matrix(example, "sites", "species", "abundance")
mat




cleanEx()
nameEx("uniqueness")
### * uniqueness

flush(stderr()); flush(stdout())

### Name: uniqueness
### Title: Functional Uniqueness for site-species matrix matrix
### Aliases: uniqueness

### ** Examples

data("aravo", package = "ade4")

# Site-species matrix
mat = as.matrix(aravo$spe)
colnames(mat) = as.character(colnames(mat))

# Example of trait table
tra = aravo$traits[, c("Height", "SLA", "N_mass")]
# Distance matrix
dist_mat = compute_dist_matrix(tra)

ui = uniqueness(mat, dist_mat)
head(ui)

# Computing uniqueness for each community
com_ui = apply(mat, 1,
                function(x, dist_m) {
                    smaller_com = x[x > 0 & !is.na(x)]
                    uniqueness(t(as.matrix(smaller_com)), dist_m)
                }, dist_m = dist_mat)




cleanEx()
nameEx("uniqueness_dimensions")
### * uniqueness_dimensions

flush(stderr()); flush(stdout())

### Name: uniqueness_dimensions
### Title: Uniqueness dimensions
### Aliases: uniqueness_dimensions

### ** Examples

data("aravo", package = "ade4")

# Site-species matrix
mat = as.matrix(aravo$spe)
rel_mat = make_relative(mat)

# Example of trait table
tra = aravo$traits[, c("Height", "SLA", "N_mass")]

ui_dim = uniqueness_dimensions(rel_mat, tra)




cleanEx()
nameEx("uniqueness_stack")
### * uniqueness_stack

flush(stderr()); flush(stdout())

### Name: uniqueness_stack
### Title: Functional Uniqueness on stacked data.frame
### Aliases: uniqueness_stack

### ** Examples

data("aravo", package = "ade4")

# Site-species matrix converted into data.frame
mat = as.matrix(aravo$spe)
dat = matrix_to_stack(mat, "value", "site", "species")
dat$site = as.character(dat$site)
dat$species = as.character(dat$species)

# Example of trait table
tra = aravo$traits[, c("Height", "SLA", "N_mass")]
# Distance matrix
dist_mat = compute_dist_matrix(tra)

ui_df = uniqueness_stack(dat, "species", dist_mat)
head(ui_df)




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
