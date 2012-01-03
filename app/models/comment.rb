class Comment < ActiveRecord::Base
  belongs_to :guest
  belongs_to :user
  belongs_to :comment
  has_many :comments

  validates_presence_of :guest_id
end
