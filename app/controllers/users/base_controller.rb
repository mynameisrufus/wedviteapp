class Users::BaseController < ApplicationController
  layout 'users/application'

  before_filter :authenticate_user!

  def find_wedding
    @wedding = current_user.weddings.find params[:wedding_id]
  end
end
