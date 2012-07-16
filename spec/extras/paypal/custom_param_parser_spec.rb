require 'spec_helper'

describe PayPal::CustomParamParser do
  it "should parse the param" do
    parser = PayPal::CustomParamParser.new '1,2'
    parser.wedding_id.should eq 1
    parser.user_id.should eq 2
  end
end
