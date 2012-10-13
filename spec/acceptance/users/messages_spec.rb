require 'acceptance/acceptance_helper'

feature 'Invitation feature', %q{
  In order to post messages and replies
  As a wedding collaborator
  I want to manage posts and replies
} do

  background do
    change_subdomain :plan
  end

  scenario 'not see message feature before invitations sent' do
    wedding, user, collaborator = wedup!
    navigate_to_wedding wedding, user

    click_link 'Timeline'

    page.should_not have_selector 'form'
  end

  scenario 'see message feature after invitations sent' do
    wedding, user, collaborator = wedup!
    wedding.invite_process_started!
    navigate_to_wedding wedding, user

    click_link 'Timeline'

    page.should have_selector 'form'
  end

  scenario 'post a new message' do
    wedding, user, collaborator = wedup!
    wedding.invite_process_started!
    navigate_to_wedding wedding, user

    click_link 'Timeline'
    fill_in 'message_text', with: 'Hello'
    click_button 'Message'

    user.messages.first.text.should eq 'Hello'
    page.should have_content("Hello")
  end

  pending 'delete my own message' do

  end

  pending 'delete message from guest if I have edit role' do

  end

  pending 'update my own message' do

  end

  scenario 'reply to a message' do
    wedding, user, collaborator = wedup!
    wedding.invite_process_started!
    user.messages.make! wedding: wedding
    navigate_to_wedding wedding, user

    click_link 'Timeline'
    fill_in 'reply_text', with: 'Goodbye'
    click_button 'Reply'

    user.messages.first.replies.first.text.should eq 'Goodbye'
    page.should have_content("Goodbye")
  end

  pending 'delete my own reply' do

  end

  pending 'update my own reply' do

  end

  pending 'delete reply from guest if I have edit role' do

  end
end
