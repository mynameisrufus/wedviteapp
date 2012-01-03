class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wedding

  validates_uniqueness_of :role
end
