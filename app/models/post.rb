class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :author

  validates :author_id, presence: true
  validates :title,     presence: true

  scope :published, -> { where(published: true) }

  before_save do
    self.published_at = Time.now if
      self.published? && self.published_at.nil?
  end
end
