class StationaryImage < ActiveRecord::Base
  belongs_to :stationary

  validates_presence_of :stationary_id

  has_attached_file :attachment,
    storage: :s3,
    s3_credentials: "#{Rails.root}/config/s3.yml",
    path: "stationary/images/:id/:hash.:extension",
    hash_secret: "wedvitehash"
end
