class Invitations::StationeryController < Invitations::BaseController
  layout false

  def show
    if should_redirect_guest?
      redirect_to path_for_guest_state
    else
      render_stationery
    end
  end

  def print
    render_stationery
  end

  protected

  def render_stationery
    render inline: @guest.wedding.stationery.render(@guest, accept_invitation_path, decline_invitation_path)
  end
end
