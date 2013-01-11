class Guest < ActiveRecord::Base
  include Eventfull

  belongs_to :wedding

  has_many :comments, dependent: :destroy

  has_many :messages, dependent: :destroy, as: :messageable
  has_many :replies, dependent: :destroy, as: :replyable

  class States < Array
    def initialize
      super [
        { verb: :approve, noun: :approved },
        { verb: :reject, noun: :rejected },
        { verb: :accept, noun: :accepted },
        { verb: :decline, noun: :declined },
        { verb: :sent, noun: :sent },
        { verb: :thank, noun: :thanked },
        { verb: :tentative, noun: :tentative },
        { verb: :review, noun: :review}
      ]
    end

    def possibly
      [:tentative, :accepted, :sent, :approved]
    end

    def likely
      [:accepted, :sent, :approved]
    end
  end

  STATES = States.new.freeze

  # Collection class
  #
  # This collection object give helper methods for totals and selecting guests
  # that match certain criteria.
  #
  # Example:
  #
  #   guest_list = Guest::List.new Wedding.find(1).guests.all
  #   guest_list.partner(1).approved.total => 10
  #
  class List < Array

    def mod modifier
      @modifier = modifier
      self
    end

    def modifier
      @modifier || 2
    end

    def total
      inject(modifier) do |t, guest|
        t + guest.adults + guest.children
      end
    end

    def adults
      inject(modifier) do |t, guest|
        t + guest.adults
      end
    end

    def children
      inject(0) do |t, guest|
        t + guest.children
      end
    end

    def select
      inject(self.class.new.mod(modifier)) do |list, guest|
        if yield guest
          list << guest
        end
        list
      end
    end

    def partner num
      select do |guest|
        guest.partner_number == num
      end.mod 1
    end

    def possibly
      select do |guest|
        guest.possibly?
      end
    end

    def likely
      select do |guest|
        guest.likely?
      end
    end

    Guest::STATES.each do |state|
      define_method state[:noun] do
        select do |guest|
          guest.state.to_s == state[:noun].to_s
        end
      end
    end
  end

  STATES.each do |state|
    scope state[:noun], where(state: state[:noun].to_s)

    define_method state[:verb] do
      update_state state[:noun].to_s
      self
    end

    define_method "#{state[:noun]}?" do
      self.state == state[:noun].to_s
    end
  end

  def invited!
    sent.update_attributes(invited_on: Time.now, state: :sent)
  end

  def self.invited! guests
    update_all({ invited_on: Time.now, state: :sent }, { id: guests })
  end

  def thank!
    sent.update_attributes(thanked_on: Time.now, state: :thanked)
  end

  def self.thanked! guests
    update_all({ thanked_on: Time.now, state: :thanked }, { id: guests })
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
    self.state = 'review' if self.state.nil?
    self.token = ::FriendlyToken.make
  end

  after_validation if: Proc.new { state_changed? || partner_number_changed? || new_record? } do
    guest = last_for_partner_and_state
    self.position = guest.nil? ? 0 : (guest.position.to_i + 1)
  end

  def viewed?
    !viewed_at.nil?
  end

  def last_for_partner_and_state
    self.class.where(state: state)
              .where(wedding_id: wedding_id)
              .where(partner_number: partner_number)
              .order("position DESC")
              .first
  end

  class Grammer
    def initialize count
      @count = count
    end

    def first_person?
      @count == 1
    end

    def first_person
      first_person? ? :first_person : :third_person
    end
  end

  def g
    @grammer ||= Grammer.new total_guests
  end

  def total_guests
    adults + children
  end

  def possibly?
    STATES.possibly.include?(self.state.to_sym)
  end

  def likely?
    STATES.likely.include?(self.state.to_sym)
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
