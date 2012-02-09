require 'spec_helper'

describe CollaboratorInvitor do
  describe 'Collaborator' do
    before :all do
      @user      = User.make!
      @requestor = User.make!
      @wedding   = Wedding.make!
      #Collaborator.make! wedding: @wedding, user: @user, role: 'invite'
    end

    it "should create a new collaboration token for a non existing user and send an email" do
      lambda do
        invitor = CollaboratorInvitor.new email: 'user@example.com',
                                          wedding: @wedding,
                                          requestor: @requestor,
                                          role: Collaborator::ROLES.shuffle.first
        invitor.save
      end.should change(CollaborationToken, :count).by(1)
    end

    it "should create add a collaboration to an existing user and send an email" do
      lambda do
        invitor = CollaboratorInvitor.new email: @user.email,
                                          wedding: @wedding,
                                          requestor: @requestor,
                                          role: Collaborator::ROLES.shuffle.first
        invitor.save
      end.should change(Collaborator, :count).by(1)
    end
  end
end
