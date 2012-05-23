class Comment < ActiveRecord::Base
  include Eventfull

  belongs_to :guest, counter_cache: true
  belongs_to :user

  validates_presence_of :guest_id, :user_id, :text
end
