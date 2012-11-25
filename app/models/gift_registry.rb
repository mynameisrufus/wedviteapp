class GiftRegistry < ActiveRecord::Base
  attr_accessible :details

  belongs_to :wedding
  has_many :gifts

  validates :wedding_id, presence: true
end
