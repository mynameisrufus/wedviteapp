class Users::RegistrationsController < Devise::RegistrationsController
  layout 'users/application'

  helper_method :show_subnav?

  def show_subnav?
    false
  end
end
