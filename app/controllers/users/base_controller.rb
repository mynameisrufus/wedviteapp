class Users::BaseController < ApplicationController
  layout 'users/application'

  before_filter :authenticate_user!

  helper_method :show_subnav?

  respond_to :html, :json

  def find_wedding
    @wedding = current_user.weddings.find params[:wedding_id] || params[:id]
  end

  def self.show_subnav on_or_off = nil
    on_or_off.nil? ? (@subnav || false) : @subnav = on_or_off
  end

  def show_subnav?
    self.class.show_subnav
  end
end
