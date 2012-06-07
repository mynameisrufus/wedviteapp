class Invitations::StationaryController < Invitations::BaseController
  layout false

  def show
    @guest = Guest.find_by_token params[:token];

    if @guest.accepted? || @guest.declined?
      redirect_to guesthome_path
    else
      render inline: @guest.wedding.stationary.render(@guest, accept_invitation_path, decline_invitation_path)
    end
  end
end
