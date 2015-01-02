require 'rails_helper'
require './spec/features/support/helpers'

describe 'Invitation describe', %q{
  In order to post messages and replies
  As a wedding collaborator
  I want to manage posts and replies
} do

  before do
    change_subdomain :plan
  end

  it 'change the invite guests to thank guests after the wedding' do
    wedding, user, collaborator = wedup!

    guest = Guest.make! wedding_id: wedding.id, state: :accepted

    wedding.update_attribute :ceremony_when_end, 5.days.ago

    navigate_to_wedding wedding, user

    click_link 'Thank Guests'

    page.should have_content(guest.name)
    page.should have_content(guest.email)

    click_link 'Send!'

    page.should have_content("Thank you emails have been sent!")
  end
end
