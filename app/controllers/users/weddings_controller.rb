class Users::WeddingsController < Users::BaseController
  before_filter :find_wedding, except: %w(new create)

  show_subnav true

  def page_title
    'Home'
  end

  def show
    @guest_list = GuestList.new @wedding.guests
    @events = @wedding.events.order("created_at DESC").page(1).per(10)
    respond_with @wedding, @guest_list, @events
  end

  def guestlist
    @guest_list = GuestList.new @wedding.guests
    respond_with @wedding, @guest_list
  end

  def invitations
    @stationery = Stationery.published
  end

  def update_details
    @wedding = current_user.weddings.find params[:wedding_id]

    handle_update('Details updated.', wedding_details_path(@wedding), :details) do
      @wedding.update_attributes(wedding_params)
    end
  end

  def update_invitations
    @wedding = current_user.weddings.find params[:wedding_id]

    invitations

    handle_update('Invitation wording has been updated.', wedding_invitations_path(@wedding), :invitations) do
      @wedding.update_attributes(wedding_params)
    end
  end

  def timeline
    @events = @wedding.events.order("created_at DESC").page(params[:page]).per(50)
    respond_with @events
  end

  def new
    @wedding = Wedding.new
    respond_with @wedding
  end

  def edit
    @wedding = current_user.weddings.find(params[:id])
    respond_with @wedding
  end

  def create
    @wedding = Wedding.new(wedding_params)

    respond_to do |format|
      if @wedding.save

        Collaborator.create! user: current_user, wedding: @wedding, role: 'invite'

        @wedding.evt.create! wedding: @wedding,
                             headline: "#{current_user.name} created a new wedding called #{@wedding.name}"

        format.html { redirect_to wedding_details_path(@wedding), notice: 'Wedding created.' }
        format.json { render json: @wedding, status: :created, location: @wedding }
      else
        format.html { redirect_to root_path, notice: "You must give your wedding a name" }
        format.json { render json: @wedding.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /weddings/1
  # PUT /weddings/1.json
  def update
    @wedding = current_user.weddings.find(params[:id])
    unless @wedding.update_attributes(wedding_params)
      flash[:alert] = "Could not update wedding."
    end
    redirect_to wedding_guestlist_path(@wedding)
  end

  def handle_update(success_message, success_path, failure_action)
    respond_to do |format|
      if yield
        format.html { redirect_to success_path, notice: success_message }
        format.json { head :ok }
      else
        format.html { render action: failure_action }
        format.json { render json: @wedding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weddings/1
  # DELETE /weddings/1.json
  def destroy
    @wedding = current_user.weddings.find(params[:id])
    @wedding.destroy

    respond_to do |format|
      format.html { redirect_to weddings_url }
      format.json { head :ok }
    end
  end

  def wedding_params
    params.require(:wedding).permit(:name,
                                    :wording,
                                    :save_the_date_wording,
                                    :ceremony_only_wording,
                                    :respond_deadline,
                                    :ceremony_when,
                                    :ceremony_how,
                                    :ceremony_what,
                                    :has_reception,
                                    :reception_when,
                                    :reception_how,
                                    :reception_what,
                                    :partner_one_name,
                                    :partner_two_name,
                                    :ceremony_when_end,
                                    :reception_when_end,
                                    :thank_you_wording)
  end
end
