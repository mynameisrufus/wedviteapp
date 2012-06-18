class Stationery < ActiveRecord::Base
  include StationeryRenderable

  has_many :weddings
  has_many :images, class_name: StationeryImage.to_s, dependent: :destroy
  has_many :assets, class_name: StationeryAsset.to_s, dependent: :destroy
  has_many :payments, as: :purchasable, dependent: :nullify
  belongs_to :agency

  validates_presence_of :style, :name, :agency_id
  validates_uniqueness_of :name
  validates :price, numericality: { greater_than_or_equal_to: 29.95 }
  validates :commision, numericality: true

  COMMISION = 0.1

  before_validation on: :create do
    self.commision = COMMISION if self.commision.nil?
  end

  has_attached_file :preview,
    storage: :s3,
    s3_credentials: "#{Rails.root}/config/s3.yml",
    path: "stationery/previews/:id/:hash.:extension",
    hash_secret: "wedvitehash"

  scope :published, where(published: true)
end
