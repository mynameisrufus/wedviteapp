require 'acceptance/acceptance_helper'

feature 'Guest feature', %q{
  In order to orginise my invitations
  As a wedding collaborator
  I want manage guests
} do

  background do
    change_subdomain :plan
    @wedding      = Wedding.make!
    @user         = User.make!
    @collaborator = Collaborator.make! user_id: @user.id, wedding_id: @wedding.id
    @guest        = Guest.make! wedding_id: @wedding.id, adults: 2
    sign_in_with email: @user.email, password: @user.password
  end

  scenario 'add a guest to wedding' do
    visit root_path
    click_link @wedding.name
    click_link "add-guest"
    fill_in 'Name', with: "Roger and Sally"
    fill_in 'Email', with: "roger@aol.com"
    fill_in 'Address', with: "1 White Picket Fench lane"
    fill_in 'Phone', with: "+61 487 738 874"
    fill_in 'Adults', with: 2
    fill_in 'Children', with: 0
    choose 'Bride'
    click_button 'Add guest'
    page.should have_content('Roger and Sally have been added to the list.')
  end

  scenario 'edit an existing guest' do
    visit root_path
    click_link @wedding.name
    click_link @guest.name
    click_link "Edit guest"
    fill_in 'Name', with: "Bob and Roger"
    fill_in 'Adults', with: 2
    click_button 'Update guest'
    page.should have_content('Bob and Roger have been updated.')
  end

  scenario 'reject a guest' do
    visit root_path
    click_link @wedding.name
    click_link @guest.name
    click_button "Reject"
    page.should have_content("#{@guest.name} are now rejected.")
  end

  scenario 'accept a guest' do
    visit root_path
    click_link @wedding.name
    click_link @guest.name
    click_button "Approve"
    page.should have_content("#{@guest.name} are now approved.")
  end
end
