# kdtools

<details>

* Version: 0.4.2
* Source code: https://github.com/cran/kdtools
* URL: https://github.com/thk686/kdtools
* BugReports: https://github.com/thk686/kdtools/issues
* Date/Publication: 2020-06-24 22:50:02 UTC
* Number of recursive dependencies: 79

Run `revdep_details(, "kdtools")` for more info

</details>

## In both

*   checking whether package ‘kdtools’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/juliasilge/Work/tidytext/revdep/checks.noindex/kdtools/new/kdtools.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘kdtools’ ...
** package ‘kdtools’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"../include" -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
In file included from RcppExports.cpp:5:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"../include" -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c arrayvec.cpp -o arrayvec.o
In file included from arrayvec.cpp:1:
In file included from ./arrayvec.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"../include" -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c kdtools.cpp -o kdtools.o
In file included from kdtools.cpp:1:
In file included from ./arrayvec.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o kdtools.so RcppExports.o arrayvec.o kdtools.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: framework not found CoreFoundation
clang-7: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [kdtools.so] Error 1
ERROR: compilation failed for package ‘kdtools’
* removing ‘/Users/juliasilge/Work/tidytext/revdep/checks.noindex/kdtools/new/kdtools.Rcheck/kdtools’

```
### CRAN

```
* installing *source* package ‘kdtools’ ...
** package ‘kdtools’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"../include" -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
In file included from RcppExports.cpp:5:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"../include" -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c arrayvec.cpp -o arrayvec.o
In file included from arrayvec.cpp:1:
In file included from ./arrayvec.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"../include" -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c kdtools.cpp -o kdtools.o
In file included from kdtools.cpp:1:
In file included from ./arrayvec.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o kdtools.so RcppExports.o arrayvec.o kdtools.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: framework not found CoreFoundation
clang-7: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [kdtools.so] Error 1
ERROR: compilation failed for package ‘kdtools’
* removing ‘/Users/juliasilge/Work/tidytext/revdep/checks.noindex/kdtools/old/kdtools.Rcheck/kdtools’

```
# mvrsquared

<details>

* Version: 0.1.1
* Source code: https://github.com/cran/mvrsquared
* URL: https://github.com/TommyJones/mvrsquared
* BugReports: https://github.com/TommyJones/mvrsquared/issues
* Date/Publication: 2020-10-21 04:50:02 UTC
* Number of recursive dependencies: 82

Run `revdep_details(, "mvrsquared")` for more info

</details>

## In both

*   checking whether package ‘mvrsquared’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/juliasilge/Work/tidytext/revdep/checks.noindex/mvrsquared/new/mvrsquared.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘mvrsquared’ ...
** package ‘mvrsquared’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/RcppThread/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
In file included from RcppExports.cpp:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/RcppThread/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c calc_sum_squares_latent.cpp -o calc_sum_squares_latent.o
In file included from calc_sum_squares_latent.cpp:5:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o mvrsquared.so RcppExports.o calc_sum_squares_latent.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: framework not found CoreFoundation
clang-7: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [mvrsquared.so] Error 1
ERROR: compilation failed for package ‘mvrsquared’
* removing ‘/Users/juliasilge/Work/tidytext/revdep/checks.noindex/mvrsquared/new/mvrsquared.Rcheck/mvrsquared’

```
### CRAN

```
* installing *source* package ‘mvrsquared’ ...
** package ‘mvrsquared’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/RcppThread/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
In file included from RcppExports.cpp:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/RcppThread/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c calc_sum_squares_latent.cpp -o calc_sum_squares_latent.o
In file included from calc_sum_squares_latent.cpp:5:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/mvrsquared/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o mvrsquared.so RcppExports.o calc_sum_squares_latent.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: framework not found CoreFoundation
clang-7: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [mvrsquared.so] Error 1
ERROR: compilation failed for package ‘mvrsquared’
* removing ‘/Users/juliasilge/Work/tidytext/revdep/checks.noindex/mvrsquared/old/mvrsquared.Rcheck/mvrsquared’

```
# quanteda

<details>

* Version: 3.0.0
* Source code: https://github.com/cran/quanteda
* URL: https://quanteda.io
* BugReports: https://github.com/quanteda/quanteda/issues
* Date/Publication: 2021-04-06 07:30:13 UTC
* Number of recursive dependencies: 124

Run `revdep_details(, "quanteda")` for more info

</details>

## In both

*   checking whether package ‘quanteda’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/juliasilge/Work/tidytext/revdep/checks.noindex/quanteda/new/quanteda.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘quanteda’ ...
** package ‘quanteda’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
In file included from RcppExports.cpp:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c fcm_mt.cpp -o fcm_mt.o
In file included from fcm_mt.cpp:1:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c index_mt.cpp -o index_mt.o
In file included from index_mt.cpp:1:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c tokens_chunk_mt.cpp -o tokens_chunk_mt.o
In file included from tokens_chunk_mt.cpp:1:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c tokens_compound_mt.cpp -o tokens_compound_mt.o
In file included from tokens_compound_mt.cpp:2:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c tokens_lookup_mt.cpp -o tokens_lookup_mt.o
In file included from tokens_lookup_mt.cpp:2:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c tokens_ngrams_mt.cpp -o tokens_ngrams_mt.o
In file included from tokens_ngrams_mt.cpp:2:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c tokens_recompile_mt.cpp -o tokens_recompile_mt.o
In file included from tokens_recompile_mt.cpp:2:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c tokens_replace_mt.cpp -o tokens_replace_mt.o
In file included from tokens_replace_mt.cpp:2:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c tokens_segment_mt.cpp -o tokens_segment_mt.o
In file included from tokens_segment_mt.cpp:1:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c tokens_select_mt.cpp -o tokens_select_mt.o
In file included from tokens_select_mt.cpp:1:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c utility.cpp -o utility.o
In file included from utility.cpp:1:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o quanteda.so RcppExports.o fcm_mt.o index_mt.o tokens_chunk_mt.o tokens_compound_mt.o tokens_lookup_mt.o tokens_ngrams_mt.o tokens_recompile_mt.o tokens_replace_mt.o tokens_segment_mt.o tokens_select_mt.o utility.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/usr/local/gfortran/lib/gcc/x86_64-apple-darwin18/8.2.0 -L/usr/local/gfortran/lib -lgfortran -lquadmath -lm -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/usr/local/gfortran/lib/gcc/x86_64-apple-darwin18/8.2.0'
ld: library not found for -lm
clang-7: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [quanteda.so] Error 1
ERROR: compilation failed for package ‘quanteda’
* removing ‘/Users/juliasilge/Work/tidytext/revdep/checks.noindex/quanteda/new/quanteda.Rcheck/quanteda’

```
### CRAN

```
* installing *source* package ‘quanteda’ ...
** package ‘quanteda’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
In file included from RcppExports.cpp:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c fcm_mt.cpp -o fcm_mt.o
In file included from fcm_mt.cpp:1:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c index_mt.cpp -o index_mt.o
In file included from index_mt.cpp:1:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c tokens_chunk_mt.cpp -o tokens_chunk_mt.o
In file included from tokens_chunk_mt.cpp:1:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c tokens_compound_mt.cpp -o tokens_compound_mt.o
In file included from tokens_compound_mt.cpp:2:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c tokens_lookup_mt.cpp -o tokens_lookup_mt.o
In file included from tokens_lookup_mt.cpp:2:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c tokens_ngrams_mt.cpp -o tokens_ngrams_mt.o
In file included from tokens_ngrams_mt.cpp:2:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c tokens_recompile_mt.cpp -o tokens_recompile_mt.o
In file included from tokens_recompile_mt.cpp:2:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c tokens_replace_mt.cpp -o tokens_replace_mt.o
In file included from tokens_replace_mt.cpp:2:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c tokens_segment_mt.cpp -o tokens_segment_mt.o
In file included from tokens_segment_mt.cpp:1:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c tokens_select_mt.cpp -o tokens_select_mt.o
In file included from tokens_select_mt.cpp:1:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DARMA_DONT_PRINT_OPENMP_WARNING  -I../inst/include -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppParallel/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c utility.cpp -o utility.o
In file included from utility.cpp:1:
In file included from ../inst/include/lib.h:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/quanteda/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o quanteda.so RcppExports.o fcm_mt.o index_mt.o tokens_chunk_mt.o tokens_compound_mt.o tokens_lookup_mt.o tokens_ngrams_mt.o tokens_recompile_mt.o tokens_replace_mt.o tokens_segment_mt.o tokens_select_mt.o utility.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/usr/local/gfortran/lib/gcc/x86_64-apple-darwin18/8.2.0 -L/usr/local/gfortran/lib -lgfortran -lquadmath -lm -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/usr/local/gfortran/lib/gcc/x86_64-apple-darwin18/8.2.0'
ld: library not found for -lm
clang-7: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [quanteda.so] Error 1
ERROR: compilation failed for package ‘quanteda’
* removing ‘/Users/juliasilge/Work/tidytext/revdep/checks.noindex/quanteda/old/quanteda.Rcheck/quanteda’

```
# textmineR

<details>

* Version: 3.0.4
* Source code: https://github.com/cran/textmineR
* URL: https://www.rtextminer.com/
* BugReports: https://github.com/TommyJones/textmineR/issues
* Date/Publication: 2019-04-18 16:30:03 UTC
* Number of recursive dependencies: 83

Run `revdep_details(, "textmineR")` for more info

</details>

## In both

*   checking whether package ‘textmineR’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/juliasilge/Work/tidytext/revdep/checks.noindex/textmineR/new/textmineR.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘textmineR’ ...
** package ‘textmineR’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c CalcLikelihoodC.cpp -o CalcLikelihoodC.o
In file included from CalcLikelihoodC.cpp:2:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c CalcSumSquares.cpp -o CalcSumSquares.o
In file included from CalcSumSquares.cpp:2:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c Dtm2DocsC.cpp -o Dtm2DocsC.o
In file included from Dtm2DocsC.cpp:2:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c HellingerMat.cpp -o HellingerMat.o
In file included from HellingerMat.cpp:1:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c Hellinger_cpp.cpp -o Hellinger_cpp.o
In file included from Hellinger_cpp.cpp:1:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c JSD_cpp.cpp -o JSD_cpp.o
In file included from JSD_cpp.cpp:1:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c JSDmat.cpp -o JSDmat.o
In file included from JSDmat.cpp:1:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
In file included from RcppExports.cpp:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c lda_c_functions.cpp -o lda_c_functions.o
In file included from lda_c_functions.cpp:3:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include/RcppArmadilloExtensions/sample.h:30:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include/RcppArmadilloExtensions/fixprob.h:25:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o textmineR.so CalcLikelihoodC.o CalcSumSquares.o Dtm2DocsC.o HellingerMat.o Hellinger_cpp.o JSD_cpp.o JSDmat.o RcppExports.o lda_c_functions.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: framework not found CoreFoundation
clang-7: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [textmineR.so] Error 1
ERROR: compilation failed for package ‘textmineR’
* removing ‘/Users/juliasilge/Work/tidytext/revdep/checks.noindex/textmineR/new/textmineR.Rcheck/textmineR’

```
### CRAN

```
* installing *source* package ‘textmineR’ ...
** package ‘textmineR’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c CalcLikelihoodC.cpp -o CalcLikelihoodC.o
In file included from CalcLikelihoodC.cpp:2:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c CalcSumSquares.cpp -o CalcSumSquares.o
In file included from CalcSumSquares.cpp:2:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c Dtm2DocsC.cpp -o Dtm2DocsC.o
In file included from Dtm2DocsC.cpp:2:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c HellingerMat.cpp -o HellingerMat.o
In file included from HellingerMat.cpp:1:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c Hellinger_cpp.cpp -o Hellinger_cpp.o
In file included from Hellinger_cpp.cpp:1:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c JSD_cpp.cpp -o JSD_cpp.o
In file included from JSD_cpp.cpp:1:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c JSDmat.cpp -o JSDmat.o
In file included from JSDmat.cpp:1:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
In file included from RcppExports.cpp:4:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include' -I'/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppProgress/include' -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include   -fPIC  -Wall -g -O2  -c lda_c_functions.cpp -o lda_c_functions.o
In file included from lda_c_functions.cpp:3:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include/RcppArmadilloExtensions/sample.h:30:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include/RcppArmadilloExtensions/fixprob.h:25:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/RcppArmadillo/include/RcppArmadillo.h:34:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp.h:57:
/Users/juliasilge/Work/tidytext/revdep/library.noindex/textmineR/Rcpp/include/Rcpp/DataFrame.h:136:18: warning: unused variable 'data' [-Wunused-variable]
            SEXP data = Parent::get__();
                 ^
1 warning generated.
clang++ -mmacosx-version-min=10.13 -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o textmineR.so CalcLikelihoodC.o CalcSumSquares.o Dtm2DocsC.o HellingerMat.o Hellinger_cpp.o JSD_cpp.o JSDmat.o RcppExports.o lda_c_functions.o -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: framework not found CoreFoundation
clang-7: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [textmineR.so] Error 1
ERROR: compilation failed for package ‘textmineR’
* removing ‘/Users/juliasilge/Work/tidytext/revdep/checks.noindex/textmineR/old/textmineR.Rcheck/textmineR’

```
