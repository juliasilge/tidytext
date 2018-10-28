context("test-namr.R")

describe("pick_word_from_title", {
  it("ignores common words", {
    expect_equal(pick_word_from_title("wrapper for the intro.js library"), "introjs")
  })
})

describe("make_spelling_rlike", {
  it("adds r suffixes", {
    expect_equal(make_spelling_rlike("tidy"), "tidyr")
  })
  it("shortens R prefixes", {
    expect_equal(make_spelling_rlike("archive"), "rchive")
  })
  it("removes trailing vowels", {
    expect_equal(make_spelling_rlike("reader"), "readr")
  })
  it("adds leading rs", {
    make_spelling_rlike("rinstr")
  })
})

describe("common_suffixes", {
  it("adds a prefix for common suffixes", {
    expect_equal(common_suffixes("package for plotting things", "my"), "myplot")
    expect_equal(common_suffixes("visualizer 2000 the reboot", "my"), "myvis")
  })
})

describe("namr", {
  it("works on real examples", {
    expect_equal(namr("A Package for Displaying Visual Scenes as They May Appear to an Animal with Lower Acuity"), "displayingrvis")
    expect_equal(namr("Analysis of Ecological Data : Exploratory and Euclidean Methods in Environmental Sciences"), "ecologicalr")
    expect_equal(namr("Population Assignment using Genetic, Non-Genetic or Integrated Data in a Machine Learning Framework"), "populationr")
  })
})
