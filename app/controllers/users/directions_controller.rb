class Users::DirectionsController < Users::BaseController
  before_filter :find_wedding

  show_subnav true

  def page_title
    'Directions'
  end

  def show
    @ceremony_where  = @wedding.ceremony_where || Location.new
    @reception_where = @wedding.reception_where || Location.new
  end
end
