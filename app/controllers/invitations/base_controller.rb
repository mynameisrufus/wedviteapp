class Invitations::BaseController < ApplicationController
  layout 'invitations/application'

  protected

  def find_guest
    @guest   = GuestStrict.find_by_token params[:token]
    @wedding = @guest.wedding
  end
end
