class Users::SessionsController < Devise::SessionsController
  layout 'users/application'

  helper_method :show_subnav?

  def show_subnav?
    false
  end

  after_filter :clear_sign_signout_flash, :only => [:create, :destroy]

  protected

  def clear_sign_signout_flash
    if flash.keys.include?(:notice)
      flash.delete(:notice)
    end
  end
end
