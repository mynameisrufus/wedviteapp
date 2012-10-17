require 'spec_helper'

describe Message do
  let(:user_reply) {
    Reply.make replyable: User.make
  }

  let(:user_reply_two) {
    Reply.make replyable: User.make
  }

  let(:guest_reply) {
    Reply.make replyable: Guest.make(:accepted)
  }

  let(:guest_reply_rejected) {
    Reply.make replyable: Guest.make(:rejected)
  }

  before :each do
    user     = User.make
    wedding  = Wedding.make
    replies  = [user_reply, user_reply_two, guest_reply, guest_reply_rejected]
    @message = Message.make messageable: user,
                            replies: replies,
                            wedding: wedding

    # Return the users here because only users that are no longer
    # collaborating are no longer participants.
    wedding.stub(:users).and_return [user, replies.first.replyable]
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
