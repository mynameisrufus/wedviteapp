class Users::RegistrationsController < Devise::RegistrationsController
  layout 'users/application'

  helper_method :show_subnav?

  def page_title
    current_user.name
  end

  def show_subnav?
    false
  end
end
