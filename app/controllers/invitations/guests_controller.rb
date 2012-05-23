class Invitations::GuestsController < Invitations::BaseController
  before_filter :find_guest

  def accept
    @guest.update_state :accepted
    @guest.update_attribute(:replyed_on, Time.now)

    @guest.evt.create! wedding: @guest.wedding,
                       state: 'accepted',
                       headline: "#{@guest.name} has RSVPd"
  end

  def decline
    @guest.update_state :declined
    @guest.update_attribute(:replyed_on, Time.now)

    @guest.evt.create! wedding: @guest.wedding,
                       state: 'declined',
                       headline: "#{@guest.name} has declined your invitation"
  end

  def message
    if params[:message].present?
      @message = @guest.messages.create! text: params[:message]

      @message.evt.create! wedding: @guest.wedding,
                           state: 'new',
                           headline: @guest.name,
                           quotation: @message.text
    end

    redirect_to wedding_details_path, notice: 'Message added'
  end

  def update
    respond_to do |format|
      if @guest.update_attributes guest_strict_params
        format.html { redirect_to wedding_details_path, notice: 'Your details have been updated.' }
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
