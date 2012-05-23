class Users::CommentsController < Users::BaseController
  before_filter :find_wedding
  before_filter :find_guest

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = @guest.comments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = @guest.comments.new
    @comment.user = current_user if user_signed_in?

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = @guest.comments.find(params[:id])
  end

  def create
    @comment = @guest.comments.new(params[:comment])
    @comment.user = current_user if user_signed_in?

    respond_to do |format|
      if @comment.save

        @comment.evt.create! wedding: @wedding,
                             state: 'new',
                             headline: "#{current_user.name} commented on #{@guest.name}",
                             quotation: @comment.text

        format.html { redirect_to wedding_guestlist_path(@wedding), notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = @guest.comments.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to wedding_guestlist_path(@wedding), notice: 'Comment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = @guest.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @wedding }
      format.json { head :ok }
    end
  end

  protected

  def find_guest
    @guest = @wedding.guests.find(params[:guest_id])
  end
end
