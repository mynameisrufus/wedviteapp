require 'spec_helper'

describe Users::PaymentsController do
  it "should process the IPN from PayPal" do
    stationery = Stationery.make!
    wedding    = Wedding.make! stationery: stationery
    expect {
      post 'notify', PAYPAL_FIXTURES[:ipn].merge(custom: "#{wedding.id},1" )
    }.to change{ Payment.count }.by(2)
  end
end
