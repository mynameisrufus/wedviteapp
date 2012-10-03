class Invitations::GuestsController < Invitations::BaseController
  before_filter :find_guest

  def accept
    unless @guest.accepted?
      @guest.update_state :accepted
      @guest.update_attribute(:replyed_on, Time.now)

      @guest.evt.create! wedding: @guest.wedding,
                         state: 'accepted',
                         headline: "#{@guest.name} has #{t("state.accepted.noun")}"
    end
  end

  def decline
    unless @guest.declined?
      @guest.update_state :declined
      @guest.update_attribute(:replyed_on, Time.now)

      @guest.evt.create! wedding: @guest.wedding,
                         state: 'declined',
                         headline: "#{@guest.name} has #{t("state.declined.noun")}"
    end
  end

  def message
    if params[:message].present?
      @message = @guest.messages.create! wedding: @guest.wedding,
                                         text: params[:message]
    end

    if @guest.declined?
      redirect_to after_decline_path
    else
      redirect_to guesthome_path, notice: 'Message added'
    end
  end

  def update
    @guest.attributes = params[:guest_strict]

    if @guest.changed?
      @guest.changes.each do |change|
        label = t "guest.#{change[0]}"
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
        format.html { redirect_to guesthome_path, notice: 'Your details have been updated.' }
        format.json { head :ok }
      else
        format.html { render controller: "weddings", action: "details" }
        format.json { render json: @wedding.errors, status: :unprocessable_entity }
      end
    end
  end

  def after_decline
    redirect_to path_for_guest_state if should_redirect_guest?
  end

  protected

  def translate_unless_fixnum value
    value.class == Fixnum ? value : t("state.#{value}.noun")
  end
end
