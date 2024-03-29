class Users::BaseController < ApplicationController
  layout 'users/application'

  before_filter :authenticate_user!

  helper_method :show_subnav?
  helper_method :current_collaboration

  respond_to :html, :json

  def find_wedding
    @wedding = current_collaboration.wedding
  end

  def wedding_id
    params[:wedding_id] || params[:id]
  end

  def current_collaboration
    @current_collaboration ||= current_user.collaborations.where(wedding_id: wedding_id).first!
  end

  def self.show_subnav on_or_off = nil
    on_or_off.nil? ? (@subnav || false) : @subnav = on_or_off
  end

  def show_subnav?
    self.class.show_subnav
  end

  def current_ability
    @current_ability ||= Ability.new(current_collaboration)
  end
end
