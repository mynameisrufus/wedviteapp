class Users::HelpController < Users::BaseController
  layout 'users/help'

  skip_before_filter :authenticate_user!

  def page
    render params[:page]
  end
end
