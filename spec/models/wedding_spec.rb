require 'spec_helper'

describe Wedding do
  it "should have a valid blueprint" do
    Wedding.make.should be_valid
  end

  it "should not allow the stationary to be changed after payment and invitation delivery" do
    wedding = Wedding.make payment_made: true
    wedding.should be_valid
    wedding.stationary_id = 1
    wedding.should_not be_valid
  end
end
