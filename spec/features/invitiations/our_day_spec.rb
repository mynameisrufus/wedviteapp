require 'rails_helper'
require './spec/features/support/helpers'

describe 'Our day describe', %q{
  As a wedding collaborator
  I want to share the our day page with our guests before the wedding
} do

  let(:setup_guest) {
    wedding = Wedding.make! ceremony_where: Location.make!
    guest   = Guest.make! wedding: wedding, state: 'accepted'
    visit invitation_url(guest.token, subdomain: 'invitations')
    [guest, wedding]
  }

  it 'return have the correct sections available' do
    guest, wedding = *setup_guest

    ['Our Day', 'Directions', 'You', 'Guest List', 'Messages'].each do |nav_item|
      page.should have_content(nav_item)
    end
  end

  it 'show the our day content before the wedding' do
    guest, wedding = *setup_guest

    page.should have_content(wedding.ceremony_what.split(/\n/).first.gsub(/\*/, ''))
  end
end
