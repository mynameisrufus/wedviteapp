require 'stationery_markup_validator'

class Stationery < ActiveRecord::Base
  include StationeryRenderable

  has_many :weddings
  has_many :images, class_name: StationeryImage.to_s, dependent: :destroy
  has_many :assets, class_name: StationeryAsset.to_s, dependent: :destroy
  has_many :payments, as: :purchasable, dependent: :nullify
  belongs_to :agency

  validates_presence_of :style, :name, :agency_id
  validates_uniqueness_of :name
  validates :price, numericality: true 
  validates :commision, numericality: true
  validates_with StationeryMarkupValidator, attribute: :html, if: :published

  COMMISION = 0.1

  before_validation on: :create do
    self.commision = COMMISION if self.commision.nil?
  end

  has_attached_file :preview, path: "stationery/previews/:id/:hash.:extension"

  do_not_validate_attachment_file_type :preview

  scope :published, -> { where(published: true) }

  def deploy!
    update_attributes html: html_dev,
                      example_wording: example_wording_dev,
                      deployed_at: Time.now
  end
end
