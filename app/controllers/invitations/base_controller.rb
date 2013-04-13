class Invitations::BaseController < ApplicationController
  layout 'invitations/application'

  before_filter :find_guest

  protected

  def find_guest
    @guest = GuestStrict.token_find params[:token]
    @wedding = @guest.wedding
  end

  def should_redirect_guest?
    @guest.accepted? && request.fullpath != our_day_path ||
    @guest.declined? && request.fullpath != after_decline_path
  end

  def path_for_guest_state
    case @guest.state
      when 'accepted' then @wedding.thank_process_started? ? thank_path : our_day_path
      when 'declined' then after_decline_path
      else invitation_path
    end
  end
end
