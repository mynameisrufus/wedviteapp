class Users::RegistrationsController < Devise::RegistrationsController
  layout 'users/application'

  helper_method :show_subnav?

  def page_title
    user_signed_in? ? current_user.name : 'WedVite'
  end

  def show_subnav?
    false
  end
end
