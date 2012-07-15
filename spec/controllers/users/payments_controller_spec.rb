require 'spec_helper'

describe Users::PaymentsController do
  let :mock_body do
    stationery = Stationery.make!
    wedding    = Wedding.make! stationery: stationery
    PAYPAL_FIXTURES[:ipn].merge(custom: "#{wedding.id},1", txn_id: 10.times.map{ rand(9) }.join)
  end

  it "should process the IPN from PayPal" do
    body = mock_body

    stub_request(:post, "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_notify-validate").
      to_return(:status => 200, :body => "VERIFIED", :headers => {})

    expect { post 'notify', body }.to change{ Payment.count }.by(2)
  end
end
