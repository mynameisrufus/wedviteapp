class Users::GuestsController < Users::BaseController
  before_filter :find_wedding
  before_filter :find_guest, only: %w(approve reject tentative accept decline move remind)

  def approve
    change_state :approve
  end

  def reject
    change_state :reject
  end

  def tentative
    change_state :tentative
  end

  def accept
    change_state :accept
  end

  def decline
    change_state :decline
  end

  # GET /guests
  # GET /guests.json
  def index
    @guests = @wedding.guests.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @guests }
    end
  end

  # POST /guests/1/move
  # POST /guests/1/move.json
  def move
    @guest.move params[:index]

    respond_to do |format|
      format.html { render nothing: true }
      format.json { head :ok }
    end
  end

  # GET /guests/1
  # GET /guests/1.json
  def show
    @guest = @wedding.guests.find(params[:id])

    respond_to do |format|
      format.html { render layout: false if request.xhr? }
      format.json { render json: @guest }
    end
  end

  # GET /guests/new
  # GET /guests/new.json
  def new
    @guest = @wedding.guests.new

    respond_to do |format|
      format.html { render layout: false if request.xhr? }
      format.json { render json: @guest }
    end
  end

  # GET /guests/1/edit
  def edit
    @guest = @wedding.guests.find(params[:id])

    respond_to do |format|
      format.html { render layout: false if request.xhr? }
      format.json { render json: @guest }
    end
  end

  # POST /guests
  # POST /guests.json
  def create
    @guest = @wedding.guests.new(params[:guest])

    respond_to do |format|
      if @guest.save

        @guest.evt.create! wedding: @wedding,
                           state: 'new',
                           headline: "#{current_user.name} added #{@guest.name} to the guest list"

        format.html { redirect_to wedding_guestlist_path(@wedding), notice: "#{@guest.name} #{@guest.total_guests > 1 ? "have" : "has"} been added to the list."  }
        format.json { render json: @guest, status: :created, location: @guest }
      else
        errors = @guest.errors.full_messages.map do |message|
          content_tag(:li, message)
        end.join

        format.html { redirect_to wedding_guestlist_path(@wedding), alert: "Guest had problems: <ul>#{errors}</ul>"  }

        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /guests/1
  # PUT /guests/1.json
  def update
    @guest = @wedding.guests.find(params[:id])

    respond_to do |format|
      if @guest.update_attributes(params[:guest])
        format.html { redirect_to wedding_guestlist_path(@wedding), notice: "#{@guest.name} #{@guest.total_guests > 1 ? "have" : "has"} been updated."  }
        format.json { head :ok }
      else
        errors = @guest.errors.full_messages.map do |message|
          content_tag(:li, message)
        end.join

        format.html { redirect_to wedding_guestlist_path(@wedding), alert: "Guest had problems: <ul>#{errors}</ul>"  }

        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guests/1
  # DELETE /guests/1.json
  def destroy
    @guest = @wedding.guests.find(params[:id])
    @guest.destroy

    respond_to do |format|
      format.html { redirect_to @wedding }
      format.json { head :ok }
    end
  end

  def remind
    mail = wedding.celebrated? ? thank_you_remind_mail : invitation_remind_mail
    mail.deliver
    respond_to do |format|
      format.html { redirect_to wedding_guestlist_path(@wedding), notice: "#{@guest.name} has been sent a reminder email." }
      format.json { head :ok }
    end
  end

  protected

  def invitation_remind_mail
    Invitations::RemindMailer.prepare wedding: @wedding,
                                      sender: current_user,
                                      guest: @guest
  end

  def thank_you_remind_mail
    Invitations::ThankRemindMailer.prepare wedding: @wedding,
                                           sender: current_user,
                                           guest: @guest
  end

  def find_wedding
    @wedding = current_user.weddings.find params[:wedding_id]
  end

  def find_guest
    @guest = @wedding.guests.find(params[:guest_id])
  end

  def change_state(state)
    respond_to do |format|
      if @guest.send state


        @guest.evt.create! wedding: @guest.wedding,
                           state: @guest.state,
                           headline: "#{current_user.name} changed #{@guest.name} to #{@guest.state}"

        format.html { redirect_to wedding_guestlist_path(@wedding), notice: "#{@guest.name} #{@guest.total_guests > 1 ? "are" : "is"} now #{t "state.#{@guest.state}.noun"}." }
        format.json { head :ok }
      else
        format.html { redirect_to @wedding, notice: "Could not change the guests state." }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end
end
