class Author < ActiveRecord::Base
  attr_accessible :name

  has_many :posts

  validates :name, presence: true
end
