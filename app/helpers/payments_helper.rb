module PaymentsHelper
  def total
    amounts.inject(0) do |sum, amount|
      sum + amount
    end
  end

  def wedding_price
    Wedding::PRICE * discount_inverse
  end

  def stationery_price
    @wedding.stationery.price
  end

  def amounts
    [wedding_price, stationery_price]
  end

  def discount_inverse
    1 - @promotional_code.discount
  end
end
