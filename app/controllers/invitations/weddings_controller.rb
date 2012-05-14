class Invitations::WeddingsController < Invitations::BaseController
  def accept

  end

  def decline

  end

  def message
    @guest = Guest.find_by_token params[:token]

    @guest.messages.create! text: params[:message] if
      params[:message].present?

    redirect_to details_path
  end

  def details

  end
end
