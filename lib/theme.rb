# frozen_string_literal: true

# Activate the required plugins.

require "jekyll-environment-variables"
require "jekyll-feed"
require "jekyll-gfm-admonitions"
require "jekyll-image-size"
require "jekyll-toc"

# Activate the theme's own plugins.

require_relative "theme/file_hash"
require_relative "theme/file_tree"
require_relative "theme/not_found"
