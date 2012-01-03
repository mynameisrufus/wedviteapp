require 'spec_helper'

describe AgencyDesigner do
  it "should have a valid blueprint" do
    AgencyDesigner.make
  end

  it "must have an agency id" do
    agency_designer = AgencyDesigner.make agency_id: nil
    agency_designer.should_not be_valid
  end

  it "must have an designer id" do
    agency_designer = AgencyDesigner.make designer_id: nil
    agency_designer.should_not be_valid
  end
end
