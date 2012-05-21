class Stationary < ActiveRecord::Base
  has_many :weddings
  has_many :stationary_images, dependent: :destroy
  has_many :stationary_assets, dependent: :destroy
  has_many :payments, as: :purchasable, dependent: :nullify
  belongs_to :agency

  validates_presence_of :style, :name
  validates_uniqueness_of :name
  validates :price, numericality: { greater_than_or_equal_to: 29.95 }
  validates :commision, numericality: true

  scope :published, where(published: true)
end
