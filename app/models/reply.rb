class Reply < ActiveRecord::Base
  include Eventfull

  belongs_to :message
  belongs_to :replyable, polymorphic: true

  validates_presence_of :text, :message_id, :replyable_id,
                        :replyable_type

  def by? type
    replyable_type == type.to_s.humanize
  end
end
