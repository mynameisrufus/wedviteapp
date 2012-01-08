require 'friendly_token'

class AgencyDesignerToken < ActiveRecord::Base
  belongs_to :agency

  validates_presence_of :agency_id, :token, :role, :email

  before_validation on: :create do
    self.token = ::FriendlyToken.make
  end
end
