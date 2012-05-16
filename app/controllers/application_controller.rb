class ApplicationController < ActionController::Base
  protect_from_forgery

  def robots
    render text: "User-Agent: *\nDisallow: /", layout: false
  end
end
