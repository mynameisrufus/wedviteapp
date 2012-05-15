class Invitations::GuestsController < Invitations::BaseController
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

    redirect_to wedding_details_path
  end

  def update
    respond_to do |format|
      if @guest.update_attributes guest_strict_params
        format.html { redirect_to wedding_details_path, notice: 'Wedding was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render controller: "weddings", action: "details" }
        format.json { render json: @wedding.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

  def guest_strict_params
    params[:guest_strict].select do |key|
      %w(state attending_reception address phone adults children).include?(key)
    end
  end
end
