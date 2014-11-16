class Gift < ActiveRecord::Base
  belongs_to :gift_registry
  belongs_to :guest

  validates :gift_registry_id, presence: true
  validates :description, presence: true

  default_scope { order('price DESC') }

  def claimed?
    !unclaimed?
  end

  def unclaimed?
    self.guest_id.nil?
  end

  def claimed_by guest
    self.guest_id == guest.id
  end

  def claim guest
    update_attribute :guest_id, guest.id
  end

  def unclaim
    update_attribute :guest_id, nil
  end
end
