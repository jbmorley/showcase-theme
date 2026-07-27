require "digest"

module Jekyll
  module FileHashFilter

    def file_hash(relative_path)
      site = @context.registers[:site]
      full_path = File.join(site.source, relative_path)
      return "" unless File.exist?(full_path)
      Digest::SHA256.file(full_path).hexdigest[0, 8]
    end

  end
end

Liquid::Template.register_filter(Jekyll::FileHashFilter)
