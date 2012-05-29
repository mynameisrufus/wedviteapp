class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :markdown

  def robots
    render text: "User-Agent: *\nDisallow: /", layout: false
  end

  def markdown
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      autolink: true, space_after_headers: true)
  end
end
