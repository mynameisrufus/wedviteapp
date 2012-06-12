class StationeryAsset < ActiveRecord::Base
  belongs_to :stationery

  validates_presence_of :stationery_id

  validates :attachment_file_name, presence: true,  uniqueness: {
    scope: :stationery_id,
    message: "you have already uploaded that file"
  }

  has_attached_file :attachment,
    storage: :s3,
    s3_credentials: "#{Rails.root}/config/s3.yml",
    path: "stationery/assets/:id/:hash.:extension",
    hash_secret: "wedvitehash"
end
