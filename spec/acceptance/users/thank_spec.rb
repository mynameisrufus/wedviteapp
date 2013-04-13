require 'acceptance/acceptance_helper'

feature 'Invitation feature', %q{
  In order to post messages and replies
  As a wedding collaborator
  I want to manage posts and replies
} do

  background do
    change_subdomain :plan
  end

  it 'change the invite guests to thank guests after the wedding' do
    wedding, user, collaborator = wedup!

    guest = Guest.make! wedding_id: wedding.id, state: :accepted

    wedding.update_attribute :ceremony_when_end, 5.days.ago

    visit wedding_confirm_path(wedding)

    page.should have_content(guest.name)
    page.should have_content(guest.email)

    click_link 'Send!'

    page.should have_content("Thank you emails have been sent!")
  end
end
