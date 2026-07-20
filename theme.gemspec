# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "theme"
  spec.version       = "0.5.0"
  spec.authors       = ["Jason Morley"]
  spec.email         = ["hello@jbmorley.co.uk"]

  spec.summary       = "Write a short summary, because Rubygems requires one."
  spec.homepage      = "https://jbmorley.co.uk"
  spec.license       = "MIT"

  spec.files = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r!^(assets|lib/|_(includes|layouts|sass)/|(LICENSE|README)((\.(txt|md|markdown)|$)))!i)
  end

  spec.add_runtime_dependency "jekyll", "~> 4.2"
  spec.add_runtime_dependency "jekyll-environment-variables"
  spec.add_runtime_dependency "jekyll-feed", "~> 0.12"
  spec.add_runtime_dependency "jekyll-gfm-admonitions"
  spec.add_runtime_dependency "jekyll-image-size", "~> 1.2"
  spec.add_runtime_dependency "jekyll-toc"
end
