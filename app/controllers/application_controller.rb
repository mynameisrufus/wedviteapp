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

  def markdown
    @markdown ||= WeddingInvitorMarkdown.new
  end

  rescue_from Liquid::SyntaxError do
    render template: "/errors/400.html.erb", status: 400
  end
end

