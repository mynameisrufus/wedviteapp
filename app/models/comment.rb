class Comment < ActiveRecord::Base
  belongs_to :guest, counter_cache: true
  belongs_to :user

  validates_presence_of :guest_id, :user_id, :text
end
