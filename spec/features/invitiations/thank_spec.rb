require 'rails_helper'
require './spec/features/support/helpers'

describe 'Thank you describe', %q{
  As a wedding collaborator
  I want to share the thank you page with our guests after the wedding
} do

  let(:setup_guest) {
    wedding = Wedding.make! thank_process_started: true, thank_process_started_at: Time.now
    guest = Guest.make! wedding: wedding, state: 'thanked'
    visit invitation_url(guest.token, subdomain: 'invitations')
    [guest, wedding]
  }

  it 'show the thank you content after the wedding and thank process started' do
    guest, wedding = *setup_guest

    page.should_not have_content('Our day')
    page.should_not have_content('Directions')

    page.should have_content('You')
    page.should have_content('Guest List')
    page.should have_content('Thank You')
    page.should have_content('Messages')
  end
end
