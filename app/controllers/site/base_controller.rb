class Site::BaseController < ApplicationController
  layout 'site/application'

  before_filter :redirect_if_current_user

  def robots
    render text: '', layout: false
  end

  protected

  def redirect_if_current_user
    redirect_to plan_root_path(subdomain: 'plan') if user_signed_in?
  end
end
