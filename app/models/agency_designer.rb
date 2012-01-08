class AgencyDesigner < ActiveRecord::Base
  ROLES = %w(manage publish edit)

  belongs_to :agency
  belongs_to :designer

  validates :agency_id, presence: true

  validates :role, inclusion: {
    in: ROLES,
    message: "%{value} is not a valid role"
  }

  validates :designer_id, presence: true,  uniqueness: {
    scope: :agency_id,
    message: "already a designer at this agency"
  }
end
