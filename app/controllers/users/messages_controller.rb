class Users::MessagesController < Users::BaseController
  before_filter :find_wedding

  show_subnav true

  def create
    @message = current_user.messages.new text: params[:message][:text], wedding: @wedding

    respond_to do |format|
      if @message.save

        if params[:email]
          mail = Invitations::Mailer.message_email message: @message,
                                                   guests: @wedding.guests.accepted,
                                                   user: current_user
          mail.deliver
        end

        format.html do
          redirect_to wedding_timeline_path(@wedding), notice: 'Message added.'
        end
      else
        format.html { render action: "index" }
      end
    end
  end

  def update
    @message = @guest.messages.find params[:id]

    respond_to do |format|
      if @message.update_attributes text: params[:message]
        format.html { redirect_to wedding_timeline_path(@wedding), notice: 'Message updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message = @guest.messages.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to @wedding }
      format.json { head :ok }
    end
  end
end
