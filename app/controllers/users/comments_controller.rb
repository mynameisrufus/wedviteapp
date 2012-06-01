class Users::CommentsController < Users::BaseController
  before_filter :find_wedding
  before_filter :find_guest

  def index
    @comments = @guest.comments.order("created_at DESC").all
    @comment  = @guest.comments.new

    respond_to do |format|
      format.html { render layout: false if request.xhr? }
      format.json { render json: @comments }
    end
  end

  def create
    @comment = @guest.comments.new text: params[:comment], user: current_user

    respond_to do |format|
      if @comment.save

        @comment.evt.create! wedding: @wedding,
                             state: 'new',
                             headline: "#{current_user.name} commented on #{@guest.name}",
                             quotation: @comment.text

        format.html do
          unless request.xhr?
            redirect_to wedding_guestlist_path(@wedding), notice: 'Comment was successfully created.'
          else
            render partial: 'users/comments/comment', locals: { :comment => @comment }
          end
        end
        format.json { render json: @comment, status: :created, location: wedding_guest_comment_path(@wedding, @guest, @comment) }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @comment = @guest.comments.find params[:id]

    respond_to do |format|
      if @comment.update_attributes text: params[:comment]
        format.html { redirect_to wedding_guestlist_path(@wedding), notice: 'Comment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

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
