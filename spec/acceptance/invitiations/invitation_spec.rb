require 'acceptance/acceptance_helper'

feature 'Invitation feature', %q{
  In order RSVP or decline and invitation
  As a wedding guest
  I want open an invitation and respond
} do

  let(:setup_stationery) {
    agency = Agency.make!
    Stationery.make! agency: agency
  }

  let(:setup_guest) {
    wedding = Wedding.make! stationery: setup_stationery
    guest = Guest.make! wedding: wedding, state: 'approved'
    visit invitation_url(guest.token, subdomain: 'invitations')
    [guest, wedding]
  }

  scenario 'accept the invitation' do
    guest, wedding = *setup_guest

    click_link 'Accept'
    page.should have_content('You have RSVP\'d')
  end

  scenario 'decline the invitation' do
    guest, wedding = *setup_guest

    click_link 'Decline'

    page.should_not have_content("Our day")
    page.should_not have_content("Directions")

    page.should have_content('Leave us a message')
    fill_in 'message', with: 'Gluten free'
    click_button 'Message'
    guest.messages.first.text.should eq 'Gluten free'
    page.should have_content("We are sorry you cannot not make it.")
  end

  pending 'RSVP after previously declining'

  pending 'become rejected after the invitation has been sent'
end
