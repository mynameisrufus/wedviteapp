class Users::BaseController < ApplicationController
  layout 'users/application'

  before_filter :authenticate_user!

  respond_to :html, :json

  def find_wedding
    @wedding = current_user.weddings.find params[:wedding_id] || params[:id]
  end
end
