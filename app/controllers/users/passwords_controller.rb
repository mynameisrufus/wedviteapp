class Users::PasswordsController < Devise::PasswordsController
  layout 'users/application'

  helper_method :show_subnav?

  def show_subnav?
    false
  end
end
