class Invitations::MessagesController < Invitations::BaseController
  def index
    @messages = @wedding.messages.includes(:replies).order("created_at DESC").page(params[:page]).per(50)
  end

  def create
    @message = @guest.messages.new text: params[:message][:text], wedding: @wedding

    respond_to do |format|
      if @message.save
        format.html do
          redirect_to messages_path(@guest.token), notice: 'Message added.'
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
        format.html { redirect_to messages_path(@guest.token), notice: 'Comment was successfully updated.' }
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
