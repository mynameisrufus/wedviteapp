require 'rails_helper'
require './spec/features/support/helpers'

describe 'Invitation describe', %q{
  In order to post messages and replies
  As a wedding guest
  I want to manage posts and replies
} do

  let(:setup_guest) {
    wedding = Wedding.make!
    guest = Guest.make! wedding: wedding, state: 'accepted'
    [guest, wedding]
  }

  it 'post a new message' do
    guest, wedding = *setup_guest
    visit invitation_url(guest.token, subdomain: 'invitations')
    click_link 'Messages'
    fill_in 'message_text', with: 'Hello'
    click_button 'Message'
    guest.messages.first.text.should eq 'Hello'
    page.should have_content("Hello")
  end

  pending 'delete my own message'

  pending 'update my own message'

  it 'reply to a message' do
    guest, wedding = *setup_guest
    guest.messages.make! text: 'Hello my friend', wedding: wedding
    visit invitation_url(guest.token, subdomain: 'invitations')
    click_link 'Messages'
    page.should have_content("Hello my friend")
    fill_in 'reply_text', with: 'Goodbye my friend'
    click_button 'Reply'
    guest.replies.first.text.should eq 'Goodbye my friend'
    page.should have_content("Hello my friend")
    page.should have_content("Goodbye my friend")
  end

  pending 'delete my own reply'

  pending 'update my own reply'
end
