class Guest < ActiveRecord::Base
  include Eventfull

  belongs_to :wedding

  has_many :comments, dependent: :destroy
  has_many :messages, dependent: :destroy

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
    self.state    = 'review'
    self.token    = ::FriendlyToken.make
  end

  after_validation if: Proc.new { state_changed? || partner_number_changed? || new_record? } do
    guest = last_for_partner_and_state
    self.position = guest.nil? ? 0 : (guest.position.to_i + 1)
  end

  def last_for_partner_and_state
    self.class.where(state: state)
              .where(wedding_id: wedding_id)
              .where(partner_number: partner_number)
              .order("position DESC")
              .first
  end

  def total_guests
    adults + children
  end

  def update_state(state)
    update_attributes state: state
  end

  def siblings
    self.class.where(state: state)
        .where(wedding_id: wedding_id)
        .where(partner_number: partner_number)
        .where("id != ?", id)
        .order("position ASC")
  end

  def move(new_position)
    higher_order_siblings = siblings.select do |sibling|
      sibling.position.to_i >= new_position.to_i
    end
  
    Guest.transaction do
      higher_order_siblings.each_with_index do |sibling, index|
        sibling.update_attribute :position, (new_position.to_i + index + 1)
      end
      update_attribute :position, new_position.to_i
    end
  end
end
