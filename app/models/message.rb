class Message < ActiveRecord::Base
  include Eventfull

  belongs_to :wedding
  belongs_to :messageable, dependent: :destroy, polymorphic: true
  has_many :replies

  validates_presence_of :text, :wedding_id, :messageable_id,
                        :messageable_type

  after_create do
    evt.create! wedding: wedding,
                state: 'new',
                headline: "#{messageable.name} wrote:"
  end

  def by? type
    messageable_type == type.to_s.humanize
  end
end
