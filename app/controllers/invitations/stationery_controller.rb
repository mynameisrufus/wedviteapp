class Invitations::StationeryController < Invitations::BaseController
  layout false

  def show
    @guest = Guest.find_by_token params[:token];


    if should_redirect_guest?
      redirect_to path_for_guest_state
    else
      render inline: @guest.wedding.stationery.render(@guest, accept_invitation_path, decline_invitation_path)
    end
  end
end
