class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :markdown

  def robots
    render text: "User-Agent: *\nDisallow: /", layout: false
  end

  if Rails.env.staging?

    before_filter :staging_authenticate

    def staging_authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == "wedvite" && password == "password"
      end
      warden.custom_failure! if performed?
    end

  end

  private

  def after_sign_out_path_for(resource_or_scope)
    {
      development: 'http://wedvite.dev',
      test:        'http://wedvite.dev',
      staging:     'http://wedvite.net',
      production:  'http://wedviteapp.com'
    }.fetch(Rails.env.to_sym)
  end

  def markdown
    @markdown ||= WeddingInvitorMarkdown.new
  end

  rescue_from Liquid::SyntaxError do
    render template: "/errors/400.html.erb", status: 400
  end
end

