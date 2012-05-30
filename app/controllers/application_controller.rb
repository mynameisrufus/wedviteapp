class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :markdown

  def robots
    render text: "User-Agent: *\nDisallow: /", layout: false
  end

  private

  def after_sign_out_path_for(resource_or_scope)
    Rails.env.production? ? 'http://wedviteapp.com' : 'http://wedvite.dev'
  end

  class MarkdownRenderer < Redcarpet::Render::HTML
    def link(link, title, alt_text)
      "<a target=\"_blank\" href=\"#{link}\">#{alt_text}</a>"
    end
    def autolink(link, link_type)
      "<a target=\"_blank\" href=\"#{link}\">#{link}</a>"
    end
  end

  def markdown
    @markdown ||= Redcarpet::Markdown.new(MarkdownRenderer,
      autolink: true, space_after_headers: true)
  end
end

