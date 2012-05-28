class Users::SessionsController < Devise::SessionsController
  layout 'users/application'

  helper_method :show_subnav?

  def show_subnav?
    false
  end
end
