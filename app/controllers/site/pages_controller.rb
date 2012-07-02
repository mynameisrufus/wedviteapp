class Site::PagesController < Site::BaseController
  def home
    @lowest_possible_payment = Wedding::PRICE + Stationery.order('price ASC').pluck(:price).first
    @higest_possible_payment = Wedding::PRICE + Stationery.order('price DESC').pluck(:price).first
  end
end
