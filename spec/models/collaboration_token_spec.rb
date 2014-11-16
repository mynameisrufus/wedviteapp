require 'spec_helper'

describe CollaborationToken do
  it 'should set a token on create' do
    collaboration_token = CollaborationToken.make!
    expect(collaboration_token).to(be_valid)
    expect(collaboration_token.token).to_not be_nil
  end
end
