class Collaborator < ActiveRecord::Base
  include Eventfull

  ROLES = %w(invite edit comment read)

  belongs_to :user
  belongs_to :wedding

  validates :wedding_id, presence: true

  validates :role, inclusion: {
    in: ROLES,
    message: "%{value} is not a valid role"
  }

  validates :user_id, presence: true,  uniqueness: {
    scope: :wedding_id,
    message: "already a collaborator on this wedding"
  }

  def is_role? role
    self.role == role
  end

  def is_not_role? role
    !is_role? role
  end
end
