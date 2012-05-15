class Message < ActiveRecord::Base
  belongs_to :guest, counter_cache: true

  validates_presence_of :text
end
