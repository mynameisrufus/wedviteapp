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
    @guest.attributes = params[:guest_strict]

    if @guest.changed?
      @guest.changes.each do |change|
        label = t change[0]
        from  = translate_unless_fixnum change[1][0]
        to    = translate_unless_fixnum change[1][1]
        @guest.evt.create!({
          wedding: @guest.wedding,
          state: 'changed',
          headline: "#{@guest.name} changed #{label} from #{from} to #{to}"
        })
      end
    end
    

    respond_to do |format|
      if @guest.save
        format.html { redirect_to wedding_details_path, notice: 'Your details have been updated.' }
        format.json { head :ok }
      else
        format.html { render controller: "weddings", action: "details" }
        format.json { render json: @wedding.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

  def translate_unless_fixnum value
    value.class == Fixnum ? value : t(value)
  end
end
