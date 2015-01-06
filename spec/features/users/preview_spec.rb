require 'rails_helper'
require './spec/features/support/helpers'

describe 'Preview', %q{
  In order to ensure our inviation is correct
  As a wedding collaborator
  I want preview our invition
} do

  before do
    change_subdomain :plan
  end

  it 'preview stationery' do
    wedding, user, collaborator = wedup!
    navigate_to_wedding wedding, user

    stationery = Stationery.make!
    wedding.update_attributes stationery_id: stationery.id

    click_link 'Invitation & Stationery'

    click_link 'Preview'
  end
end
