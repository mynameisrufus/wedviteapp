class WeddingInvitorMarkdown
  class MarkdownRenderer < Redcarpet::Render::HTML
    def link(link, title, alt_text)
      "<a target=\"_blank\" href=\"#{link}\">#{alt_text}</a>"
    end
    def autolink(link, link_type)
      "<a target=\"_blank\" href=\"#{link}\">#{link}</a>"
    end
  end

  def self.new
    Redcarpet::Markdown.new(MarkdownRenderer,
      autolink: true, space_after_headers: true)
  end
end
