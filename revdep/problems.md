# crsra

Version: 0.2.3

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 500 marked UTF-8 strings
    ```

# fivethirtyeight

Version: 0.4.0

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘fivethirtyeight’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  6.3Mb
      sub-directories of 1Mb or more:
        data   5.3Mb
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 1616 marked UTF-8 strings
    ```

# gutenbergr

Version: 0.1.4

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 13617 marked UTF-8 strings
    ```

# polmineR

Version: 0.7.10

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘RcppCWB’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# quanteda

Version: 1.3.4

## In both

*   checking whether package ‘quanteda’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/checks.noindex/quanteda/new/quanteda.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘quanteda’ ...
** package ‘quanteda’ successfully unpacked and MD5 sums checked
** libs
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c RcppExports.cpp -o RcppExports.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c ca_mt.cpp -o ca_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c collocations_mt_.cpp -o collocations_mt_.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c dist_mt.cpp -o dist_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c fcm_mt.cpp -o fcm_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c kwic_mt.cpp -o kwic_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c tokens_compound_mt.cpp -o tokens_compound_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c tokens_lookup_mt.cpp -o tokens_lookup_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c tokens_ngrams_mt.cpp -o tokens_ngrams_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c tokens_recompile_mt.cpp -o tokens_recompile_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c tokens_segment_mt.cpp -o tokens_segment_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c tokens_select_mt.cpp -o tokens_select_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c utility.cpp -o utility.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c wordcloud.cpp -o wordcloud.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c wordfish_dense.cpp -o wordfish_dense.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c wordfish_mt.cpp -o wordfish_mt.o
clang++ -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o quanteda.so RcppExports.o ca_mt.o collocations_mt_.o dist_mt.o fcm_mt.o kwic_mt.o tokens_compound_mt.o tokens_lookup_mt.o tokens_ngrams_mt.o tokens_recompile_mt.o tokens_segment_mt.o tokens_select_mt.o utility.o wordcloud.o wordfish_dense.o wordfish_mt.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/usr/local/gfortran/lib/gcc/x86_64-apple-darwin15/6.1.0 -L/usr/local/gfortran/lib -lgfortran -lquadmath -lm -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/usr/local/gfortran/lib/gcc/x86_64-apple-darwin15/6.1.0'
ld: warning: directory not found for option '-L/usr/local/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [quanteda.so] Error 1
ERROR: compilation failed for package ‘quanteda’
* removing ‘/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/checks.noindex/quanteda/new/quanteda.Rcheck/quanteda’

```
### CRAN

```
* installing *source* package ‘quanteda’ ...
** package ‘quanteda’ successfully unpacked and MD5 sums checked
** libs
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c RcppExports.cpp -o RcppExports.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c ca_mt.cpp -o ca_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c collocations_mt_.cpp -o collocations_mt_.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c dist_mt.cpp -o dist_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c fcm_mt.cpp -o fcm_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c kwic_mt.cpp -o kwic_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c tokens_compound_mt.cpp -o tokens_compound_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c tokens_lookup_mt.cpp -o tokens_lookup_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c tokens_ngrams_mt.cpp -o tokens_ngrams_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c tokens_recompile_mt.cpp -o tokens_recompile_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c tokens_segment_mt.cpp -o tokens_segment_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c tokens_select_mt.cpp -o tokens_select_mt.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c utility.cpp -o utility.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c wordcloud.cpp -o wordcloud.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c wordfish_dense.cpp -o wordfish_dense.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/Rcpp/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppParallel/include" -I"/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include" -I/usr/local/include  -DARMA_64BIT_WORD=1 -fPIC  -Wall -g -O2 -c wordfish_mt.cpp -o wordfish_mt.o
clang++ -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o quanteda.so RcppExports.o ca_mt.o collocations_mt_.o dist_mt.o fcm_mt.o kwic_mt.o tokens_compound_mt.o tokens_lookup_mt.o tokens_ngrams_mt.o tokens_recompile_mt.o tokens_segment_mt.o tokens_select_mt.o utility.o wordcloud.o wordfish_dense.o wordfish_mt.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/usr/local/gfortran/lib/gcc/x86_64-apple-darwin15/6.1.0 -L/usr/local/gfortran/lib -lgfortran -lquadmath -lm -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/usr/local/gfortran/lib/gcc/x86_64-apple-darwin15/6.1.0'
ld: warning: directory not found for option '-L/usr/local/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [quanteda.so] Error 1
ERROR: compilation failed for package ‘quanteda’
* removing ‘/Volumes/Data1TB/Google Drive/data_science/runconf16/tidytext/revdep/checks.noindex/quanteda/old/quanteda.Rcheck/quanteda’

```
# rzeit2

Version: 0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘ggplot2’
      All declared Imports should be used.
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 841 marked UTF-8 strings
    ```

# statquotes

Version: 0.2.2

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘fortunes’
    ```

# tidymodels

Version: 0.0.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘broom’ ‘ggplot2’ ‘infer’ ‘pillar’ ‘recipes’ ‘rsample’
      ‘tidyposterior’ ‘tidypredict’ ‘tidytext’ ‘yardstick’
      All declared Imports should be used.
    ```

