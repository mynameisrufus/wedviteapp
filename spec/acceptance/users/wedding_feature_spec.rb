require 'acceptance/acceptance_helper'

feature 'Wedding feature', %q{
  In order to plan the wedding invitations
  As a wedding collaborator
  I want manage wedding details
} do

  background do
    change_subdomain :plan
  end

  scenario 'create a new wedding' do
    user = User.make!
    sign_in_with user.email, user.password
    fill_in "wedding[name]", with: "Our special day!"
    click_button "Create"
    page.should have_content('Wedding created.')
  end

  scenario 'create another wedding' do
    wedding, user, collaborator = wedup!
    sign_in_with user.email, user.password
    fill_in "wedding[name]", with: "Our special day!"
    click_button "Create"
    page.should have_content('Wedding created.')
  end
end
