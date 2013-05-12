class Users::FeedbackController < Users::BaseController

  def create
    if params[:feedback].present?
      mail.deliver
      redirect_to root_path, notice: "Thank you for your feedback."
    else
      render "new"
    end
  end

  protected

  def mail
    Users::FeedbackMailer.prepare user: current_user, text: params[:feedback]
  end

end
