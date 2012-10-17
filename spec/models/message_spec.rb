require 'spec_helper'

describe Message do
  let(:user_reply) {
    Reply.make replyable: User.make
  }

  let(:guest_reply) {
    Reply.make replyable: Guest.make
  }

  before :each do
    @message = Message.make messageable: User.make,
                            replies: [user_reply, guest_reply]
  end

  it 'should return all the participants that are users' do
    @message.participants.users.size.should eq 2
  end

  it 'should return all the participants that are guests' do
    @message.participants.guests.size.should eq 1
  end

  it 'should remove with not method' do
    @message.participants.not(@message.messageable).users.size.should eq 1
  end
end
