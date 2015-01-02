require 'rails_helper'
require './spec/features/support/helpers'

describe 'Update guest details describe', %q{
  As a wedding guest
  I want to update my details
  So the wedding collaborators have my correct information
} do

  let(:setup_guest) {
    wedding = Wedding.make!
    guest   = Guest.make! wedding: wedding, state: 'accepted'
    visit invitation_url(guest.token, subdomain: 'invitations')
    [guest, wedding]
  }

  # TODO requires custom update logic on GuestStrict so you can add more adults
  # and children.
  pending 'change the number of adults and children' do
    guest, wedding = *setup_guest
    adults = guest.adults + rand(10)

    click_link 'You'
    fill_in 'guest_strict_adults', with: adults
    click_button 'Update'

    page.should have_content 'Your details have been updated.'
    guest.reload
    guest.adults.should eq adults
  end

  pending 'change my name'

  it 'change my email address' do
    guest, wedding = *setup_guest
    email = 'rufuspost@gmail.com'

    click_link 'You'
    fill_in 'guest_strict_email', with: email
    click_button 'Update'

    page.should have_content 'Your details have been updated.'
    guest.reload
    guest.email.should eq email
  end

  it 'fail to update email address' do
    guest, wedding = *setup_guest

    click_link 'You'
    fill_in 'guest_strict_email', with: 'this is not an email address'
    click_button 'Update'
    page.should have_content 'Sorry we could not update your details.'
  end

  pending 'change wether I am attending the reception or not'
end
