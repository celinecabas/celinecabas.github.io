# With jekyll-polyglot every language is built separately (English into /en/).
# Responsive images only need to be generated once, in the default language
# build: pages in every language reference the same /assets/img/ files, and
# `assets` is excluded from localization in _config.yml.
require "jekyll-imagemagick"

module JekyllImagemagick
  class ImageGenerator
    alias_method :generate_for_every_language, :generate

    def generate(site)
      return if site.respond_to?(:active_lang) && site.active_lang != site.default_lang

      generate_for_every_language(site)
    end
  end
end
