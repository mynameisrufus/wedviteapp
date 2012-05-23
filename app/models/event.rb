class Event < ActiveRecord::Base
  belongs_to :wedding
  belongs_to :eventfull, polymorphic: true

  validates :wedding_id, presence: true
  validates :headline, presence: true

  scope :eventfull, lambda { |type|
    where(eventfull_type: type.to_s.classify)
  }

  def to_css
    [
      'event',
      ['event-', eventfull_type.downcase].join,
      (state.nil? ? nil : ['event-', state].join)
    ].join(' ')
  end
end
