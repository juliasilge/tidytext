# kdtools

<details>

* Version: 0.4.1
* Source code: https://github.com/cran/kdtools
* URL: https://github.com/thk686/kdtools
* BugReports: https://github.com/thk686/kdtools/issues
* Date/Publication: 2019-04-23 22:50:03 UTC
* Number of recursive dependencies: 90

Run `revdep_details(,"kdtools")` for more info

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
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"../include" -I"/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include" -I"/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include" -I"/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"../include" -I"/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include" -I"/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include" -I"/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -c arrayvec.cpp -o arrayvec.o
In file included from arrayvec.cpp:1:
In file included from ./arrayvec.h:33:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include/strider.h:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/iterator/iterator_adaptor.hpp:10:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/static_assert.hpp:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config.hpp:57:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/platform/macos.hpp:28:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/detail/posix_features.hpp:18:
In file included from /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/unistd.h:658:
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/gethostuuid.h:39:17: error: C++ requires a type specifier for all declarations
int gethostuuid(uuid_t, const struct timespec *) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_NA);
                ^
In file included from arrayvec.cpp:1:
In file included from ./arrayvec.h:33:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include/strider.h:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/iterator/iterator_adaptor.hpp:10:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/static_assert.hpp:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config.hpp:57:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/platform/macos.hpp:28:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/detail/posix_features.hpp:18:
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/unistd.h:665:27: error: unknown type name 'uuid_t'; did you mean 'uid_t'?
int      getsgroups_np(int *, uuid_t);
                              ^
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types/_uid_t.h:31:31: note: 'uid_t' declared here
typedef __darwin_uid_t        uid_t;
                              ^
In file included from arrayvec.cpp:1:
In file included from ./arrayvec.h:33:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include/strider.h:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/iterator/iterator_adaptor.hpp:10:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/static_assert.hpp:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config.hpp:57:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/platform/macos.hpp:28:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/detail/posix_features.hpp:18:
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/unistd.h:667:27: error: unknown type name 'uuid_t'; did you mean 'uid_t'?
int      getwgroups_np(int *, uuid_t);
                              ^
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types/_uid_t.h:31:31: note: 'uid_t' declared here
typedef __darwin_uid_t        uid_t;
                              ^
In file included from arrayvec.cpp:1:
In file included from ./arrayvec.h:33:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include/strider.h:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/iterator/iterator_adaptor.hpp:10:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/static_assert.hpp:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config.hpp:57:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/platform/macos.hpp:28:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/detail/posix_features.hpp:18:
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/unistd.h:730:31: error: unknown type name 'uuid_t'; did you mean 'uid_t'?
int      setsgroups_np(int, const uuid_t);
                                  ^
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types/_uid_t.h:31:31: note: 'uid_t' declared here
typedef __darwin_uid_t        uid_t;
                              ^
In file included from arrayvec.cpp:1:
In file included from ./arrayvec.h:33:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include/strider.h:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/iterator/iterator_adaptor.hpp:10:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/static_assert.hpp:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config.hpp:57:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/platform/macos.hpp:28:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/detail/posix_features.hpp:18:
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/unistd.h:732:31: error: unknown type name 'uuid_t'; did you mean 'uid_t'?
int      setwgroups_np(int, const uuid_t);
                                  ^
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types/_uid_t.h:31:31: note: 'uid_t' declared here
typedef __darwin_uid_t        uid_t;
                              ^
5 errors generated.
make: *** [arrayvec.o] Error 1
ERROR: compilation failed for package ‘kdtools’
* removing ‘/Users/juliasilge/Work/tidytext/revdep/checks.noindex/kdtools/new/kdtools.Rcheck/kdtools’

```
### CRAN

```
* installing *source* package ‘kdtools’ ...
** package ‘kdtools’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"../include" -I"/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include" -I"/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include" -I"/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I"../inst/include" -I"../include" -I"/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/Rcpp/include" -I"/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include" -I"/Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -c arrayvec.cpp -o arrayvec.o
In file included from arrayvec.cpp:1:
In file included from ./arrayvec.h:33:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include/strider.h:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/iterator/iterator_adaptor.hpp:10:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/static_assert.hpp:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config.hpp:57:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/platform/macos.hpp:28:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/detail/posix_features.hpp:18:
In file included from /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/unistd.h:658:
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/gethostuuid.h:39:17: error: C++ requires a type specifier for all declarations
int gethostuuid(uuid_t, const struct timespec *) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_NA);
                ^
In file included from arrayvec.cpp:1:
In file included from ./arrayvec.h:33:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include/strider.h:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/iterator/iterator_adaptor.hpp:10:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/static_assert.hpp:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config.hpp:57:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/platform/macos.hpp:28:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/detail/posix_features.hpp:18:
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/unistd.h:665:27: error: unknown type name 'uuid_t'; did you mean 'uid_t'?
int      getsgroups_np(int *, uuid_t);
                              ^
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types/_uid_t.h:31:31: note: 'uid_t' declared here
typedef __darwin_uid_t        uid_t;
                              ^
In file included from arrayvec.cpp:1:
In file included from ./arrayvec.h:33:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include/strider.h:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/iterator/iterator_adaptor.hpp:10:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/static_assert.hpp:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config.hpp:57:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/platform/macos.hpp:28:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/detail/posix_features.hpp:18:
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/unistd.h:667:27: error: unknown type name 'uuid_t'; did you mean 'uid_t'?
int      getwgroups_np(int *, uuid_t);
                              ^
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types/_uid_t.h:31:31: note: 'uid_t' declared here
typedef __darwin_uid_t        uid_t;
                              ^
In file included from arrayvec.cpp:1:
In file included from ./arrayvec.h:33:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include/strider.h:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/iterator/iterator_adaptor.hpp:10:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/static_assert.hpp:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config.hpp:57:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/platform/macos.hpp:28:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/detail/posix_features.hpp:18:
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/unistd.h:730:31: error: unknown type name 'uuid_t'; did you mean 'uid_t'?
int      setsgroups_np(int, const uuid_t);
                                  ^
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types/_uid_t.h:31:31: note: 'uid_t' declared here
typedef __darwin_uid_t        uid_t;
                              ^
In file included from arrayvec.cpp:1:
In file included from ./arrayvec.h:33:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/strider/include/strider.h:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/iterator/iterator_adaptor.hpp:10:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/static_assert.hpp:17:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config.hpp:57:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/platform/macos.hpp:28:
In file included from /Users/juliasilge/Work/tidytext/revdep/library.noindex/kdtools/BH/include/boost/config/detail/posix_features.hpp:18:
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/unistd.h:732:31: error: unknown type name 'uuid_t'; did you mean 'uid_t'?
int      setwgroups_np(int, const uuid_t);
                                  ^
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types/_uid_t.h:31:31: note: 'uid_t' declared here
typedef __darwin_uid_t        uid_t;
                              ^
5 errors generated.
make: *** [arrayvec.o] Error 1
ERROR: compilation failed for package ‘kdtools’
* removing ‘/Users/juliasilge/Work/tidytext/revdep/checks.noindex/kdtools/old/kdtools.Rcheck/kdtools’

```
