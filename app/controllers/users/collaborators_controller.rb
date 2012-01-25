class Users::CollaboratorsController < Users::BaseController
  before_filter :find_wedding, except: %w(collaborate)

  # GET /collaborators
  # GET /collaborators.json
  def index
    @collaborators = @wedding.collaborators.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @collaborators }
    end
  end

  # GET /collaborators/1
  # GET /collaborators/1.json
  def show
    @collaborator = @wedding.collaborators.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @collaborator }
    end
  end

  # GET /collaborators/new
  # GET /collaborators/new.json
  def new
    @invitor = Invitor::Collaborator.new role: 'read'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invitor }
    end
  end

  # GET /collaborators/1/edit
  def edit
    @collaborator = @wedding.collaborators.find(params[:id])
  end

  # POST /collaborators
  # POST /collaborators.json
  def create
    @invitor = Invitor::Collaborator.new email: params[:email], wedding: @wedding, requestor: current_user, role: params[:role]

    message = Proc.new {
      @invitor.invite_sent? ? "An invitation to collaborate has been sent to #{@invitor.email}" : "#{@invitor.user.name} is now collaborating on this wedding"
    }

    respond_to do |format|
      if @invitor.save
        format.html { redirect_to wedding_collaborators_path(@wedding), notice: message.call }
        format.json { render json: @invitor, status: :created, location: @wedding }
      else
        format.html { render action: "new" }
        format.json { render json: @invitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /collaborators/1
  # PUT /collaborators/1.json
  def update
    @collaborator = @wedding.collaborators.find(params[:id])

    respond_to do |format|
      if @collaborator.update_attributes(role: params[:role])
        format.html { redirect_to @collaborator, notice: 'Collaborator was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @collaborator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collaborators/1
  # DELETE /collaborators/1.json
  def destroy
    @collaborator = @wedding.collaborators.find(params[:id])
    @collaborator.destroy

    respond_to do |format|
      format.html { redirect_to collaborators_url }
      format.json { head :ok }
    end
  end

  # GET /weddings/1/collaborate/o8Tq2nfw6SYdmcME7oz7
  def collaborate
    @wedding = Wedding.find(params[:wedding_id])
    @collaboration_token = CollaborationToken.where(wedding_id: @wedding.id).where(token: params[:token]).first!

    respond_to do |format|
      if @collaboration_token.claimed?
        format.html { redirect_to root_path, notice: 'This link has now expired.' }
        format.json { head :ok }
      else
        @collaborator = Collaborator.new wedding: @wedding, user: current_user, role: @collaboration_token.role
        if @collaborator.save
          @collaboration_token.update_attributes claimed_on: Time.now
        end
        format.html { redirect_to @wedding, notice: 'You are now collaborating on this wedding.' }
        format.json { head :ok }
      end
    end
  end
end
