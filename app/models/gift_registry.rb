class GiftRegistry < ActiveRecord::Base
  belongs_to :wedding
  has_many :gifts

  validates :wedding_id, presence: true
end
