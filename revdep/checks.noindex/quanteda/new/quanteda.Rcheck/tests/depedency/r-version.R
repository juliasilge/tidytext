require(stringi)

print_depends <- function(package, level = 0) {
    desc <- packageDescription(package)
    if ("Depends" %in% names(desc)) {
        dep <- stri_trim_both(desc$Depends)
        r <- stri_extract_first_regex(dep, 'R \\(.*?\\)')
        if (is.na(r)) r <- ''
        cat(strrep('  ', level), package, ": " , r, "\n", sep = '')
        if ("Imports" %in% names(desc)) {
            imp <- paste0(desc$Depends, ', ', desc$Imports)
            if (r != '') 
                imp <- stri_replace_first_fixed(imp, r, '')
            imp <- stri_replace_all_regex(imp, ' \\(.*?\\)', '')
            imp <- unlist(stri_split_regex(imp, ','))
            imp <- stri_trim_both(imp)
            imp <- imp[imp != '']
            for(i in imp) {
                print_depends(i, level + 1)
            }
        }
    }
}

print_depends('quanteda')
print_depends('Rcpp')
