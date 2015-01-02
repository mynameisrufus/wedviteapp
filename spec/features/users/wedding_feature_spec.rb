require 'rails_helper'
require './spec/features/support/helpers'

describe 'Wedding describe', %q{
  In order to plan the wedding invitations
  As a wedding collaborator
  I want manage wedding details
} do

  before do
    change_subdomain :plan
  end

  it 'create a new wedding' do
    user = User.make!
    sign_in_with user.email, user.password
    fill_in "wedding[name]", with: "Our special day!"
    click_button "Create"
    page.should have_content('Wedding created.')
  end

  it 'create another wedding' do
    wedding, user, collaborator = wedup!
    sign_in_with user.email, user.password
    fill_in "wedding[name]", with: "Our special day!"
    click_button "Create"
    page.should have_content('Wedding created.')
  end
end
