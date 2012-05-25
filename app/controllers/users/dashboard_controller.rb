class Users::DashboardController < Users::BaseController
  def home
    @wedding = Wedding.new
  end
end
