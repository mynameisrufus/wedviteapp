class Stationary < ActiveRecord::Base
  has_many :weddings
  has_many :stationary_images
  has_many :stationary_assets

  validates_presence_of :style, :name
  validates_uniqueness_of :name
  validates :price, numericality: { greater_than_or_equal_to: 29.95 }
  validates :commision, numericality: { greater_than_or_equal_to: 0.15 }

  scope :published, where(published: true)
end
