class Users::RepliesController < Users::BaseController
  before_filter :find_wedding
  before_filter :find_message

  def create
    @reply = current_user.replies.new text: params[:reply][:text], message: @message

    respond_to do |format|
      if @reply.save

        Messages::Guests.reply(@reply).deliver
        Messages::Users.reply(@reply).deliver

        format.html do
          redirect_to wedding_timeline_path(@wedding), notice: 'Reply created.'
        end
      else
        format.html { render action: "messages/index" }
      end
    end
  end

  def update
    @reply = @guest.replys.find params[:id]

    respond_to do |format|
      if @reply.update_attributes text: params[:reply]
        format.html { redirect_to wedding_timeline_path(@wedding), notice: 'Comment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reply = @guest.replys.find(params[:id])
    @reply.destroy

    respond_to do |format|
      format.html { redirect_to @wedding }
      format.json { head :ok }
    end
  end

  protected

  def find_message
    @message = Message.find params[:message_id]
  end
end
