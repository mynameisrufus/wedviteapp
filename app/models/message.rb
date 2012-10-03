class Message < ActiveRecord::Base
  include Eventfull

  belongs_to :wedding
  belongs_to :messageable, dependent: :destroy, polymorphic: true

  validates_presence_of :text, :wedding_id, :messageable_id,
                        :messageable_type
end
