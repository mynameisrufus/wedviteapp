require 'rails_helper'
require './spec/features/support/helpers'

describe 'Invitation feature', %q{
  In order to post messages and replies
  As a wedding collaborator
  I want to manage posts and replies
} do

  before do
    change_subdomain :plan
  end

  it 'not see message feature before invitations sent' do
    wedding, user, collaborator = wedup!
    navigate_to_wedding wedding, user

    click_link 'Timeline'

    page.should_not have_selector 'form'
  end

  it 'see message feature after invitations sent' do
    wedding, user, collaborator = wedup!
    wedding.invite_process_started!
    navigate_to_wedding wedding, user

    click_link 'Timeline'

    page.should have_selector 'form'
  end

  it 'post a new message' do
    wedding, user, collaborator = wedup!
    wedding.invite_process_started!
    navigate_to_wedding wedding, user

    click_link 'Timeline'
    fill_in 'message_text', with: 'Hello'
    click_button 'Message'

    user.messages.first.text.should eq 'Hello'
    page.should have_content("Hello")
  end

  pending 'delete my own message'

  pending 'delete message from guest if I have edit role'

  pending 'update my own message'

  it 'reply to a message' do
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

  pending 'delete my own reply'

  pending 'update my own reply'

  pending 'delete reply from guest if I have edit role'
end
