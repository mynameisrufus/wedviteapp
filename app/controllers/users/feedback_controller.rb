class Users::FeedbackController < Users::BaseController
  def create
    respond_to do |format|
      if params[:feedback].present?
        Users::Mailer.feedback(user: current_user, text: params[:feedback]).deliver
        format.html { redirect_to root_path, notice: 'Feedback sent.' }
        format.json { head :ok }
      else
        format.html { render action: "new" }
        format.json { render json: [], status: :unprocessable_entity }
      end
    end
  end
end
