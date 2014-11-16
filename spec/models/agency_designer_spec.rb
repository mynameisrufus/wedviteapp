require 'spec_helper'

describe AgencyDesigner do
  it 'should have a valid blueprint' do
    agency_designer = AgencyDesigner.make
    expect(agency_designer).to(be_valid)
  end

  it 'must have an agency id' do
    agency_designer = AgencyDesigner.make agency_id: nil
    expect(agency_designer).to_not(be_valid)
  end

  it 'must have an designer id' do
    agency_designer = AgencyDesigner.make designer_id: nil
    expect(agency_designer).to_not(be_valid)
  end
end
