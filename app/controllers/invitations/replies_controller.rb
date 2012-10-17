class Invitations::RepliesController < Invitations::BaseController
  before_filter :find_message

  def create
    @reply = @guest.replies.new text: params[:reply][:text], message: @message

    respond_to do |format|
      if @reply.save

        send_reply_to_participants

        format.html do
          redirect_to invitation_path(@guest.token), notice: 'Reply created.'
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
        format.html { redirect_to wedding_guestlist_path(@wedding), notice: 'Comment was successfully updated.' }
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

  def send_reply_to_participants
    send_reply_to_participating_users && send_reply_to_participating_guests
  end

  def send_reply_to_participating_users
    mail = Users::ReplyMailer.prepare reply: @reply,
                                      sender: @guest,
                                      wedding: @wedding,
                                      users: @message.participants.users
    mail.deliver
  end

  def send_reply_to_participating_guests
    mail = Invitations::ReplyMailer.prepare reply: @reply,
                                            sender: @guest,
                                            wedding: @wedding,
                                            guests: @message.participants.not(@guest).guests
    mail.deliver
  end
end
