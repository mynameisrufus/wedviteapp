class Invitations::StationeryController < Invitations::BaseController
  around_filter :check_redirect, only: :show

  layout false

  def show
    @guest.touch :viewed_at
    render_stationery
  end

  def print
    render_stationery
  end

  protected

  def render_stationery
    render inline: @guest.wedding.stationery.render(@guest, accept_invitation_path, decline_invitation_path)
  end
end
