class Invitations::GuestsController < Invitations::BaseController
  def page_title
    @guest.name
  end

  def show

  end

  def accept
    unless @guest.accepted?
      @guest.update_state :accepted
      @guest.touch :replyed_on

      @guest.evt.create! wedding: @guest.wedding,
                         state: 'accepted',
                         headline: "#{@guest.name} has #{t("state.accepted.noun")}"
    end
    @guest.reload
    redirect_to our_day_path, notice: 'You have RSVP\'d'
  end

  def decline
    unless @guest.declined?
      @guest.update_state :declined
      @guest.touch :replyed_on

      @guest.evt.create! wedding: @guest.wedding,
                         state: 'declined',
                         headline: "#{@guest.name} has #{t("state.declined.noun")}"
    end
    @guest.reload
  end

  def message
    if params[:message].present?
      @message = @guest.messages.create! wedding: @guest.wedding,
                                         text: params[:message]
    end

    if @guest.declined?
      redirect_to declined_path
    else
      redirect_to our_day_path, notice: 'Message added'
    end
  end

  def declined

  end

  def update
    @guest.attributes = guest_strict_params

    if @guest.changed? && @guest.valid?
      @guest.changes.each do |change|
        if change[0] == 'state'
          label = t "guest.#{change[0]}"
          from  = t "state.#{change[1][0]}.noun"
          to    = t "state.#{change[1][1]}.noun"
        else
          label = t "guest.#{change[0]}"
          from  = change[1][0]
          to    = change[1][1]
        end
        @guest.evt.create!({
          wedding: @guest.wedding,
          state: 'changed',
          headline: "#{@guest.name} changed #{label} from #{from} to #{to}"
        })
      end
    end

    respond_to do |format|
      if @guest.save
        format.html { redirect_to guest_path(@guest.token), notice: 'Your details have been updated.' }
        format.json { head :ok }
      else
        format.html { redirect_to guest_path(@guest.token), notice: 'Sorry we could not update your details.' }
        format.json { render json: @wedding.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

  def guest_strict_params
    params.require(:guest_strict).permit(:name,
                                         :email,
                                         :adults,
                                         :children,
                                         :partner_number,
                                         :address,
                                         :phone)
  end
end
