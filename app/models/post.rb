class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  attr_accessible :title, :body, :author_id, :published

  belongs_to :author

  validates :author_id, presence: true
  validates :title,     presence: true

  before_save do
    self.published_at = Time.now if
      self.published? && self.published_at.nil?
  end
end
