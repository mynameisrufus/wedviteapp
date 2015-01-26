require 'rails_helper'
require './spec/features/support/helpers'

describe 'Gift Registry describe', %q{
  In order to provide guests with list of gifts to choose from
  As a wedding collaborator
  I want manage a Gift Registry
} do

  before do
    change_subdomain :plan
  end

  it 'update the gift registry details' do
    wedding, user, collaborator = wedup!
    navigate_to_wedding wedding, user

    details = "Please send gifts to: #{Faker::Address.street_address}"

    click_link "Gift Registry"
    fill_in 'gift_registry[details]', with: details
    click_button 'Save and start adding gifts'

    wedding.gift_registry.details.should eq details
    page.should have_content('Gift Registry details saved')
  end

  it 'add in item to the gift registry' do
    wedding, user, collaborator = wedup!
    navigate_to_wedding wedding, user
    GiftRegistry.make! wedding: wedding, active: true

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

  it 'should allow the feature to be turned off' do
    wedding, user, collaborator = wedup!
    navigate_to_wedding wedding, user
    GiftRegistry.make! wedding: wedding, active: true

    click_link 'Gift Registry'

    click_button 'Turn off Gift Registry'

    expect(wedding.gift_registry.active).to be(false)
  end
end
