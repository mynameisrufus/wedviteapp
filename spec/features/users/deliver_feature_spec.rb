require 'rails_helper'
require './spec/features/support/helpers'

describe 'Deliver describe', %q{
  In order to deliver the invitation emails to guests
  As a wedding collaborator
  I want send out the emails
} do

  before do
    change_subdomain :plan
  end

  it 'should display a list of people who are approved', type: :feature do
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

  it 'deliver emails to approved guests', type: :feature do
    wedding, user, collaborator = wedup!
    wedding.paid!

    guest_approved = Guest.make! wedding_id: wedding.id, state: :approved

    sign_in_with user.email, user.password

    visit wedding_confirm_path(wedding)

    click_link 'Send!'

    page.should have_content("Invitations have been sent!")
    guest_approved.reload
    guest_approved.invited_on.should_not be_nil
    expect(guest_approved.sent?).to equal(true)
  end
end
