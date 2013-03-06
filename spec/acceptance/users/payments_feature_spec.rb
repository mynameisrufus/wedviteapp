require 'acceptance/acceptance_helper'

feature 'Payments feature', %q{
  In order to send the invitations
  As a wedding collaborator
  I want pay for the service
} do

  background do
    change_subdomain :plan
  end

  pending 'use a promotional code' do
    promo = PromotionalCode.make! discount: 0.5

    wedding, user, collaborator = wedup!
    navigate_to_wedding wedding, user

    visit wedding_confirm_path(wedding)
    fill_in "promotional_code", with: promo.code
    click_button "Use"
    page.should have_content("50% off")
  end
end
