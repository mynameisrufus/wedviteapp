require 'friendly_token'

class Guest < ActiveRecord::Base
  belongs_to :wedding
  has_many :comments

  validates_presence_of :wedding_id, :name, :adults, :children, :token, :state

  validates :email, presence: true,  uniqueness: {
    scope: :wedding_id,
    message: "is already used in this list."
  }

  before_validation on: :create do
    self.state = 'review'
    self.token = ::FriendlyToken.make
  end

  STATES = [
    { verb: :approve, noun: :approved },
    { verb: :reject, noun: :rejected },
    { verb: :accept, noun: :accepted },
    { verb: :decline, noun: :declined },
    { verb: :viewed, noun: :viewed },
    { verb: :tentative, noun: :tentative },
    { verb: :review, noun: :review}
  ]

  STATES.each do |state|
    scope state[:noun], where(state: state[:noun].to_s)

    define_method state[:verb] do
      update_state state[:noun].to_s
    end

    define_method "#{state[:noun]}?" do
      self.state == state[:noun].to_s
    end
  end

  def total_guests
    adults + children
  end

  def update_state(state)
    update_attributes state: state
  end
end
