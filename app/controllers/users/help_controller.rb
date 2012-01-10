class Users::HelpController < Users::BaseController
  layout 'users/help'

  def page
    render params[:page]
  end
end
