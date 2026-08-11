module Jekyll
  class NotFoundGenerator < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      return if site.pages.any? { |page| File.basename(page.name, ".*") == "404" }

      page = PageWithoutAFile.new(site, __dir__, "", "404.html")
      page.data.merge!(
        "title" => "Not Found",
        "layout" => "page",
        "permalink" => "/404.html",
      )
      page.content = %(<p class="center">The page you requested could not be found.</p>\n)
      site.pages << page
    end
  end
end
