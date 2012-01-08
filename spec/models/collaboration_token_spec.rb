require 'spec_helper'

describe CollaborationToken do
  it "should set a token on create" do
    collaboration_token = CollaborationToken.make!
    collaboration_token.should be_valid
    collaboration_token.token.should_not be_nil
  end
end
