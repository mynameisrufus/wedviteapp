require 'spec_helper'

describe AgencyDesignerToken do
  it "should set a token on create" do
    agency_designer_token = AgencyDesignerToken.make!
    agency_designer_token.should be_valid
    agency_designer_token.token.should_not be_nil
  end
end
