require 'acceptance/acceptance_helper'

feature 'Gift Registry feature', %q{
  In order to provide guests with list of gifts to choose from
  As a wedding collaborator
  I want manage a Gift Registry
} do

  background do
    change_subdomain :plan
  end

  scenario 'update the gift registry details' do
    wedding, user, collaborator = wedup!
    navigate_to_wedding wedding, user

    details = "Please send gifts to: #{Faker::Address.street_address}"

    click_link "Gift Registry"
    fill_in 'gift_registry[details]', with: details
    click_button 'Save and start adding gifts'

    wedding.gift_registry.details.should eq details
    page.should have_content('Gift Registry details saved')
  end

  scenario 'add in item to the gift registry' do
    wedding, user, collaborator = wedup!
    navigate_to_wedding wedding, user
    GiftRegistry.make! wedding: wedding

    click_link "Gift Registry"

    fill_in 'gift[description]', with: "Donna Hay glass cake dome"
    fill_in 'gift[url]', with: "http://www.donnahay.com.au/cake-dome"
    fill_in 'gift[price]', with: 29.95
    click_button 'Add gift'

    wedding.gift_registry.gifts.count.should eq 1
    page.should have_content('Gift added to the Registry')
  end

  pending 'remove an item from the gift registry'

  pending 'not be able to manage the registry if wrong role'
end
