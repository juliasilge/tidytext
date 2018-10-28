context("test-name_to_search_terms.R")

describe("name_to_search_terms", {
  it("does not remove trailing R when proceeded by a vowel", {
    expect_equal(name_to_search_terms("linear"), "linear")
    expect_equal(name_to_search_terms("loder"), "loder")
  })
  it("does remove trailing R when not proceeded by a vowel", {
    expect_equal(name_to_search_terms("covr"), "cov")
    expect_equal(name_to_search_terms("knitr"), "knit")
  })
})
