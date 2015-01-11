class Users::CollaboratorsController < Users::BaseController
  before_filter :find_wedding, except: %w(collaborate)
  before_filter :authorize, only: %w(index new edit create)

  show_subnav true

  def index
    @collaborators = @wedding.collaborators.all
    respond_with @collaborators
  end

  def new
    @invitor = Collaborate::User.new role: 'read'

    respond_to do |format|
      format.html { render layout: false if request.xhr? }
      format.json { render json: @invitor }
    end
  end

  def edit
    @collaborator = @wedding.collaborators.find(params[:id])

    respond_to do |format|
      format.html { render layout: false if request.xhr? }
      format.json { render json: @guest }
    end
  end

  def create
    @invitor = Collaborate::User.new email: params[:email], wedding: @wedding, requestor: current_user, role: params[:role]

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

  def update
    @collaborator = @wedding.collaborators.find(params[:id])

    authorize! :manage, @collaborator

    respond_to do |format|
      if @collaborator.update_attributes(role: params[:role])
        format.html { redirect_to wedding_collaborators_path(@wedding), notice: "#{@collaborator.user.name} now has the '#{@collaborator.role}' role." }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @collaborator.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @collaborator = @wedding.collaborators.find(params[:id])

    authorize! :manage, @collaborator

    message = "#{@collaborator.user.name} has been removed as a collaborator"

    @collaborator.evt.create! wedding: @wedding,
                              headline: message

    @collaborator.destroy

    respond_to do |format|
      format.html { redirect_to wedding_collaborators_path(@wedding), notice: message }
      format.json { head :ok }
    end
  end

  def collaborate
    @collaboration_token = CollaborationToken.where(token: params[:token]).first!
    @wedding             = @collaboration_token.wedding

    respond_to do |format|
      if @collaboration_token.claimed?
        format.html { redirect_to plan_root_path, notice: 'This link has now expired.' }
        format.json { head :ok }
      else
        @collaborator = Collaborator.new wedding: @wedding, user: current_user, role: @collaboration_token.role
        if @collaborator.save
          @collaboration_token.update_attributes claimed_on: Time.now

          @collaborator.evt.create! wedding: @wedding,
                                    headline: "#{current_user.name} is now collaborating on this wedding"
        end
        format.html { redirect_to wedding_guestlist_path(@wedding), notice: 'You are now collaborating on this wedding.' }
        format.json { head :ok }
      end
    end
  end

  protected

  def authorize
    authorize! :manage_collaborators, @wedding
  end
end
