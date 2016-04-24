class Users::DashboardController < Users::BaseController
  def home
    redirect_to wedding_path(current_collaboration.wedding)
  end
end
