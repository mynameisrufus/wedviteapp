
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
    page.should have_content('Leave us a message')
    fill_in 'message', with: 'Gluten free'
    click_button 'Message'
    guest.messages.first.text.should eq 'Gluten free'
    page.should have_content('Our Day')
  end

  scenario 'decline the invitation' do
    guest, wedding = *setup_guest

    click_link 'Decline'
    page.should have_content('Leave us a message')
    fill_in 'message', with: 'Gluten free'
    click_button 'Message'
    guest.messages.first.text.should eq 'Gluten free'
    page.should have_content("Thank you")
    page.should have_content("We are sorry you cannot not make it.")
  end

  scenario 'RSVP after previously declining' do
    # should only see a page with the option to change your status
    # should be able to leave a message
    # should add item to timeline if change
    # should email collaborators
  end

  scenario 'become rejected after the invitation has been sent' do
    # should get a 4 O something
  end
end
