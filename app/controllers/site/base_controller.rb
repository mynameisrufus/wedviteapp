class Site::BaseController < ApplicationController
  layout 'site/application'

  def robots
    render text: '', layout: false
  end
end
