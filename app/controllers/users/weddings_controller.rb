class Users::WeddingsController < Users::BaseController
  before_filter :find_wedding, only: %w(
    wording ceremony_only_wording save_the_date_wording
    ceremony_how ceremony_what reception_how reception_what
  )

  # GET /weddings
  # GET /weddings.json
  def index
    @weddings = Wedding.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @weddings }
    end
  end

  # GET /weddings/1
  # GET /weddings/1.json
  def show
    @wedding = current_user.weddings.find(params[:id])
    @guests  = @wedding.guests.order("name ASC, position DESC")
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wedding }
    end
  end

  # GET /weddings/new
  # GET /weddings/new.json
  def new
    @wedding = Wedding.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wedding }
    end
  end

  # GET /weddings/1/edit
  def edit
    @wedding = current_user.weddings.find(params[:id])
  end

  # POST /weddings
  # POST /weddings.json
  def create
    @wedding = Wedding.new(params[:wedding])

    respond_to do |format|
      if @wedding.save
        Collaborator.create! user: current_user, wedding: @wedding, role: 'invite'
        format.html { redirect_to @wedding, notice: 'Wedding created.' }
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
        format.html { redirect_to @wedding, notice: 'Wedding was successfully updated.' }
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
