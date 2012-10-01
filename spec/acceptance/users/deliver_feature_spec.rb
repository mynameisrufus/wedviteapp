require 'acceptance/acceptance_helper'

feature 'Deliver feature', %q{
  In order to deliver the invitation emails to guests
  As a wedding collaborator
  I want send out the emails
} do

  background do
    change_subdomain :plan
  end

  scenario 'should display a list of people who are approved' do
    wedding, user, collaborator = wedup!
    wedding.paid!

    guest_approved = Guest.make! wedding_id: wedding.id, state: :approved
    guest_review = Guest.make! wedding_id: wedding.id, state: :review

    sign_in_with user.email, user.password

    visit wedding_confirm_path(wedding)

    page.should have_content("List of approved guests that will be emailed")

    page.should have_content(guest_approved.name)
    page.should have_content(guest_approved.email)

    page.should_not have_content(guest_review.name)
    page.should_not have_content(guest_review.email)
  end

  scenario 'deliver emails to approved guests' do
    wedding, user, collaborator = wedup!
    wedding.paid!

    guest_approved = Guest.make! wedding_id: wedding.id, state: :approved

    sign_in_with user.email, user.password

    visit wedding_confirm_path(wedding)

    click_link 'Send!'

    page.should have_content("Invitations have been sent!")
    guest_approved.reload
    guest_approved.invited_on.should_not be_nil
    guest_approved.sent?.should be_true
  end
end
