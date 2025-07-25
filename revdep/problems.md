# bugphyzz

<details>

* Version: 1.2.0
* GitHub: https://github.com/waldronlab/bugphyzz
* Source code: https://github.com/cran/bugphyzz
* Date/Publication: 2025-04-17
* Number of recursive dependencies: 230

Run `revdepcheck::revdep_details(, "bugphyzz")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        7.             ├─BiocFileCache::bfcadd(cache, rname, url)
        8.             └─BiocFileCache::bfcadd(cache, rname, url)
        9.               └─BiocFileCache:::.util_download(...)
       10.                 └─BiocFileCache:::.util_set_cache_info(bfc, rid[ok])
       11.                   ├─BiocFileCache:::.httr_get_cache_info(fpath)
       12.                   │ ├─base::withCallingHandlers(...)
       13.                   │ └─httr::HEAD(link)
       14.                   │   └─httr:::handle_url(handle, url, ...)
       15.                   └─BiocFileCache:::.sql_get_fpath(bfc, rid)
       16.                     └─BiocFileCache:::.sql_get_field(bfc, rid, "fpath")
       17.                       └─base::stopifnot(all(id %in% .get_all_rids(bfc)))
      
      [ FAIL 1 | WARN 1 | SKIP 0 | PASS 25 ]
      Error: Test failures
      Execution halted
    ```

