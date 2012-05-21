require 'spec_helper'

describe Wedding do
  it "should have a valid blueprint" do
    Wedding.make.should be_valid
  end
end
