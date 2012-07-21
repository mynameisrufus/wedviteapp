class Site::PagesController < Site::BaseController
  def home
    @lowest_possible_payment = Wedding::PRICE + lowest_stationery_price
    @higest_possible_payment = Wedding::PRICE + higest_stationery_price
  end

private

  def lowest_stationery_price
    Stationery.order('price ASC').pluck(:price).first.to_i
  end

  def higest_stationery_price
    Stationery.order('price DESC').pluck(:price).first.to_i
  end
end
