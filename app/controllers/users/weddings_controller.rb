class Users::WeddingsController < Users::BaseController
  before_filter :find_wedding, only: %w(
    wording ceremony_only_wording save_the_date_wording
    ceremony_how ceremony_what reception_how reception_what
    payment payment_success payment_failure
  )

  before_filter :find_for_send, only: %w(confirm_send send_invites)

  skip_before_filter :verify_authenticity_token, only: %w(payment_success)

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
      if !@wedding.payment_made? && @wedding.payment_due?
        format.html { redirect_to wedding_payment_path(@wedding), alert: 'You must pay to keep using this feature.' }
        format.json { render json: @wedding, status: :created, location: @wedding }
      else
        format.html # show.html.erb
        format.json { render json: @wedding }
      end
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

  def confirm_send

  end

  def send_invites
    @guests.each do |guest|
      mail = Invitations::Mailer.invite user: current_user, guest: guest, wedding: @wedding
      mail.deliver
      guest.update_attribute(:invited_on, Time.now)
    end
  end

  def payment_success
    respond_to do |format|
      if params[:payment_status] == "Completed"

        @wedding.update_attributes payment_made: true, payment_date: Time.now

        @transaction = @wedding.payments.create! gross: params[:mc_gross],
                                                 transaction_fee: params[:mc_fee],
                                                 currency: params[:mc_currency],
                                                 transaction_id: params[:txn_id],
                                                 user_id: current_user.id,
                                                 gateway: "PayPal",
                                                 gateway_response: params

        format.html { redirect_to @wedding, notice: 'Payment made.' }
      else
        format.html { redirect_to @wedding, alert: 'Payment not made.' }
      end
    end
  end

  def payment_failure
    respond_to do |format|
      format.html { redirect_to @wedding, alert: 'Payment not made.' }
      format.json { head :ok }
    end
  end

  protected

  def find_for_send
    @wedding = current_user.weddings.find(params[:wedding_id])
    @guests  = @wedding.guests.approved.where(invited_on: nil)
  end
end
