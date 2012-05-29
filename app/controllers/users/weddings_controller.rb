class Users::WeddingsController < Users::BaseController
  before_filter :find_wedding, except: %w(new create)

  show_subnav true

  def details
    @ceremony_where  = @wedding.ceremony_where || Location.new
    @reception_where = @wedding.reception_where || Location.new
  end

  def update_details
    @wedding = current_user.weddings.find params[:wedding_id]
    @wedding.update_attributes(params[:wedding])
    redirect_to wedding_details_path(@wedding), notice: 'Details updated.'
  end

  def guestlist
    @guests = @wedding.guests
    respond_with @wedding, @guests
  end

  def invitations
    @stationary = Stationary.published.sorted(params[:sort], 'popularity ASC').page(params[:page]).per(50).all
  end

  def update_invitations
    @wedding = current_user.weddings.find params[:wedding_id]
    @wedding.update_attributes(params[:wedding])
    redirect_to wedding_invitations_path(@wedding), notice: 'Invitation wording has been updated.'
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
    @wedding = Wedding.new(params[:wedding])

    respond_to do |format|
      if @wedding.save

        Collaborator.create! user: current_user, wedding: @wedding, role: 'invite'

        @wedding.evt.create! wedding: @wedding,
                             headline: "#{current_user.name} created a new wedding called #{@wedding.name}"

        format.html { redirect_to wedding_details_path(@wedding), notice: 'Wedding created.' }
        format.json { render json: @wedding, status: :created, location: @wedding }
      else
        format.html { render action: "new" }
        format.json { render json: @wedding.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /weddings/1
  # PUT /weddings/1.json
  def update
    @wedding = current_user.weddings.find(params[:id])

    respond_to do |format|
      if @wedding.update_attributes(params[:wedding])
        format.html { redirect_to wedding_guestlist_path(@wedding), notice: 'Wedding was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
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
end
