require 'acceptance/acceptance_helper'

feature 'Gift Registry feature', %q{
  In order to provide guests with list of gifts to choose from
  As a wedding collaborator
  I want manage a Gift Registry
} do

  background do
    change_subdomain :plan
  end

  # scenario 'update the gift registry details' do
  #   wedding, user, collaborator = wedup!
  #   navigate_to_wedding wedding, user

  #   details = "Please send gifts to: #{Faker::Address.street_address}"

  #   click_link "Gift Registry"
  #   fill_in 'Details', with: details
  #   click_button 'Save'

  #   wedding.gift_registry.details.should eq details
  #   page.should have_content('Gift Registry details have been updated')
  # end

  # scenario 'add in item to the gift registry' do
  #   wedding, user, collaborator = wedup!
  #   navigate_to_wedding wedding, user

  #   click_link "Gift Registry"
  #   
  # end

  # scenario 'remove an item from the gift registry' do

  # end

  # scenario 'not be able to manage the registry if wrong role' do

  # end
end
