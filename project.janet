(declare-project
  :name "speakeasy"
  :description "A standalone janet hiccup library"
  :dependencies ["https://github.com/joy-framework/tester"]
  :author "Sean Walker"
  :license "MIT"
  :url "https://github.com/swlkr/speakeasy"
  :repo "https://github.com/swlkr/speakeasy")

(declare-binscript
  :main "speakeasy")

(declare-source
  :source @["src"])

(phony "tests" []
  (os/shell "find . -name '*.janet' | entr -r -d jpm test"))
