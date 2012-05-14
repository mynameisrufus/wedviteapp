class Invitations::WeddingsController < Invitations::BaseController
  before_filter :find_guest

  def accept
    @guest.update_state :accepted
  end

  def decline
    @guest.update_state :declined
  end

  def message
    @guest.messages.create! text: params[:message] if
      params[:message].present?

    redirect_to details_path
  end

  def details
    @wedding = @guest.wedding
  end

  def find_guest
    @guest = Guest.find_by_token params[:token]
  end
end
