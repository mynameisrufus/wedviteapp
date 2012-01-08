require 'friendly_token'

class CollaborationToken < ActiveRecord::Base
  belongs_to :wedding

  validates_presence_of :wedding_id, :token, :role, :email

  validates :email, uniqueness: {
    scope: :wedding_id,
    message: "already has an outstanding invitation to collaborate on this wedding"
  }

  def claimed?
    !self.claimed_on.nil?
  end

  before_validation on: :create do
    self.token = ::FriendlyToken.make
  end
end
