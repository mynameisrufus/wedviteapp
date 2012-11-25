require 'acceptance/acceptance_helper'

feature 'Gift Registry feature', %q{
  In order to purchase a gift from the Gift Registry
  As a wedding guest
  I want view and claim a gift from the Gift Registry
} do

  let(:setup_guest) {
    wedding = Wedding.make!
    guest = Guest.make! wedding: wedding, state: 'accepted'
    [guest, wedding]
  }


  # scenario 'claim a gift' do
  #   guest, wedding = *setup_guest
  #   visit invitation_url(guest.token, subdomain: 'invitations')
  #   click_link 'Gift Registry'
  #   page.should have_content("Hello")
  #   click_button 'Message'
  #   guest.messages.first.text.should eq 'Hello'
  #   page.should have_content("Hello")
  # end
end
