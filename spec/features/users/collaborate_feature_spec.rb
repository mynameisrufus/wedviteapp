require 'rails_helper'
require './spec/features/support/helpers'

describe 'Collaborate feature', %q{
  In order to collaborate on a wedding invitation plan
  As a wedding collaborator
  I want manage collaborators
} do

  def navigate_to_collaborators wedding, user
    sign_in_with user.email, user.password
    visit plan_root_path
    click_link wedding.name
    click_link "Collaborate"
  end

  before do
    change_subdomain :plan
  end

  it 'invite a collaborator', type: :feature do
    wedding, user, collaborator = wedup!
    navigate_to_collaborators wedding, user

    click_link 'Click here to invite a collaborator'
    fill_in 'email', with: 'user@example.com'
    choose 'role_invite'
    click_button 'Save'

    page.should have_content 'An invitation to collaborate has been sent to user@example.com'
  end

  it 'add an already collaborating collaborator', type: :feature do
    wedding, user, collaborator = wedup!
    navigate_to_collaborators wedding, user

    other_user = User.make!

    click_link 'Click here to invite a collaborator'
    fill_in 'email', with: other_user.email
    choose 'role_invite'
    click_button 'Save'

    page.should have_content "#{other_user.name} is now collaborating on this wedding"
  end

  it 'change a collaborators role if I have the invite role', type: :feature do
    wedding, user, collaborator = wedup!

    other_user                  = User.make!
    wedding.collaborators.create! user: other_user, role: 'read'

    navigate_to_collaborators wedding, user

    click_link 'change'
    choose 'role_edit'
    click_button 'Save'

    page.should have_content "#{other_user.name} now has the 'edit' role."
  end

  it 'not allow me manage collaborators if I do not have the invite role', type: :feature do
    wedding      = Wedding.make!
    user         = User.make!
    collaborator = Collaborator.make! user_id: user.id, wedding_id: wedding.id, role: 'edit'

    navigate_to_wedding wedding, user
    page.should_not have_content 'Collaborate'
  end

  it 'only allow editing of wedding details etc if you have the edit or invite roles', type: :feature do
    wedding      = Wedding.make!
    user         = User.make!
    collaborator = Collaborator.make! user_id: user.id, wedding_id: wedding.id, role: 'comment'

    navigate_to_wedding wedding, user
    page.should_not have_content 'Wedding Details'
    page.should_not have_content 'Invitation & Stationery'
  end

  it 'accept an invitation to collaborate on a wedding', type: :feature do
    wedding      = Wedding.make!
    user         = User.make!
    token = CollaborationToken.make! wedding_id: wedding.id, role: 'comment'
    visit collaborate_path(token.token)
    page.should_not have_content 'You are now collaborating on this wedding'
  end

  it 'should not be able to send if I do not have the invite role' do
    wedding      = Wedding.make!
    user         = User.make!
    collaborator = Collaborator.make! user_id: user.id, wedding_id: wedding.id, role: 'edit'

    navigate_to_wedding wedding, user
    page.should_not have_content 'Invite Guests'
  end

  it 'remove a collaborator', type: :feature do
    wedding      = Wedding.make!
    user         = User.make!
    other_user   = User.make!
    collaborator = Collaborator.make! user_id: user.id, wedding_id: wedding.id, role: 'invite'
    other_collaborator = Collaborator.make! user_id: other_user.id, wedding_id: wedding.id, role: 'edit'

    navigate_to_collaborators wedding, user
    click_link 'remove'
    page.should have_content "#{other_collaborator.user.name} has been removed as a collaborator"
  end
end
