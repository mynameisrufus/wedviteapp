require 'rails_helper'
require './spec/features/support/helpers'

describe 'Wedding details', %q{
  In order to inform my guests of where my wedding is
  As a wedding collaborator
  I want manage directions
} do

  before do
    change_subdomain :plan
  end

  it 'update wedding details' do
    wedding, user, collaborator = wedup!
    navigate_to_wedding wedding, user

    click_link 'Wedding Details'

    within '#ourday' do
      fill_in 'wedding[ceremony_what]', with: 'Pew pew'
      click_button 'Save changes'
    end

    page.should have_content('Details updated')
    wedding.reload
    wedding.ceremony_what.should eq 'Pew pew'
  end
end
