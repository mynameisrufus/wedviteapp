
require 'acceptance/acceptance_helper'

feature 'Invitation feature', %q{
  In order RSVP or decline and invitation
  As a wedding guest
  I want open an invitation and respond
} do

  scenario 'view in invitation' do
    stationery = Stationary.make!
    wedding    = Wedding.make! stationary: stationery
    guest      = Guest.make! wedding: wedding
    visit invitation_url(guest.token, subdomain: 'invitations')

    page.should have_content(guest.name)
    page.should have_content('RSVP')
    page.should have_content('Decline')
  end

  scenario 'RSVP to the wedding' do
    stationery = Stationary.make!
    wedding    = Wedding.create! name: "Our wedding", stationary: stationery
    guest      = Guest.make! wedding: wedding
    visit invitation_url(guest.token, subdomain: 'invitations')

    click_link 'RSVP'
    page.should have_content('Leave us a message')
    fill_in 'message', with: 'Gluten free'
    click_button 'Message'
    guest.messages.first.text.should eq 'Gluten free'
    page.should have_content('Our day')
  end
end
