require 'rails_helper'
require './spec/features/support/helpers'

describe 'Invitation details', %q{
  In order to inform my guests of where my wedding is
  As a wedding collaborator
  I want manage directions
} do

  before do
    change_subdomain :plan
  end

  it 'update invitation details' do
    wedding, user, collaborator = wedup!
    navigate_to_wedding wedding, user

    click_link 'Invitation & Stationery'

    within '#wording' do
      fill_in 'wedding[wording]', with: 'Hello {{ guest.name }}'
      click_button 'Save changes'
    end

    page.should have_content('Invitation wording has been updated')
    wedding.reload
    wedding.wording.should eq 'Hello {{ guest.name }}'
  end
end
