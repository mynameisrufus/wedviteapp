class Wedding < ActiveRecord::Base
  has_one :stationary
  has_many :guests
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators

  validates_presence_of :name, :wedding_when
  validates_presence_of :reception_when, if: :has_reception
  validate :can_change_stationary

  def can_change_stationary
    errors.add :stationary_id, "You can no longer change your stationary as the invitations have been sent" if
      stationary_id_changed? and payment_made?
  end
end
