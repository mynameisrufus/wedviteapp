class Invitations::BaseController < ApplicationController
  layout 'invitations/application'

  protected

  def find_guest
    @guest   = GuestStrict.token_find params[:token]
    @wedding = @guest.wedding
  end
end
