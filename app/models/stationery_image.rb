class StationeryImage < ActiveRecord::Base
  belongs_to :stationery

  validates_presence_of :stationery_id

  validates :attachment_file_name, presence: true,  uniqueness: {
    scope: :stationery_id,
    message: "you have already uploaded that file"
  }

  # :hash is derived from
  #
  #   :class/:attachment/:id/:style/:updated_at
  has_attached_file :attachment, path: "stationery/images/:id/:hash.:extension"

  do_not_validate_attachment_file_type :attachment
end
