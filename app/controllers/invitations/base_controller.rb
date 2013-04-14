class Invitations::BaseController < ApplicationController
  layout 'invitations/application'

  before_filter :find_guest

  REDIRECT_STATES = ["accepted", "thanked", "declined"].freeze

  protected

  def find_guest
    @guest = GuestStrict.token_find params[:token]
    @wedding = @guest.wedding
  end

  def check_redirect
    if REDIRECT_STATES.include?(@guest.state)
      case @guest.state
      when "accepted"
        redirect_to @wedding.thank_process_started? ? thank_path : our_day_path
      when "thanked"
        redirect_to @wedding.thank_process_started? ? thank_path : our_day_path
      when "declined"
        redirect_to guest_path(@guest.token)
      else
        yield
      end
    else
      yield
    end
  end
end
