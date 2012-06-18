class Designers::DashboardController < Designers::BaseController
  def home
    @stationery = Stationery.new
  end
end
