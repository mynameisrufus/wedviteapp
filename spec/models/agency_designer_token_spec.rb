require 'spec_helper'

describe AgencyDesignerToken do
  it 'should set a token on create' do
    agency_designer_token = AgencyDesignerToken.make!
    expect(agency_designer_token).to(be_valid)
    expect(agency_designer_token.token).not_to(be_nil)
  end
end
