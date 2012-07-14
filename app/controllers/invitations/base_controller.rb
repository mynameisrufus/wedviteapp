class Invitations::BaseController < ApplicationController
  layout 'invitations/application'

  protected

  def find_guest
    @guest   = GuestStrict.token_find params[:token]
    @wedding = @guest.wedding
  end

  def should_redirect_guest?
    @guest.accepted? && request.fullpath != guesthome_path ||
    @guest.declined? && request.fullpath != after_decline_path
  end

  def path_for_guest_state
    case @guest.state
      when 'accepted' then guesthome_path
      when 'declined' then after_decline_path
      else invitation_path
    end
  end
end
