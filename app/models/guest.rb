class Guest < ActiveRecord::Base
  belongs_to :wedding
  has_many :comments

  STATES = [
    { verb: :approve, noun: :approved },
    { verb: :reject, noun: :rejected },
    { verb: :accept, noun: :accepted },
    { verb: :decline, noun: :declined },
    { verb: :sent, noun: :sent },
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

  validates_presence_of :wedding_id, :name, :adults, :children, :token

  validates :state, presence: {
    in: STATES.map{|s| s[:noun].to_s}
  }

  validates :partner_number, presence: {
    in: [1,2],
    message: "Must choose what side the guest is on"
  }

  validates :email, presence: true, email: true, uniqueness: {
    scope: :wedding_id,
    message: "is already used in this list."
  }

  before_validation on: :create do
    self.state = 'review'
    self.token = ::FriendlyToken.make
  end

  def total_guests
    adults + children
  end

  def update_state(state)
    update_attributes state: state
  end
end
