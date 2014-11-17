class Guest < ActiveRecord::Base
  include Eventfull

  belongs_to :wedding

  has_many :comments, dependent: :destroy

  has_many :messages, dependent: :destroy, as: :messageable
  has_many :replies, dependent: :destroy, as: :replyable

  GuestState.each do |state|
    scope state.noun, -> { where(state: state.noun) }

    define_method state.verb do
      update_state state.noun
      self
    end

    define_method "#{state.noun}?" do
      self.state == state.noun.to_s
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
    in: GuestState.map{|s| s[:noun].to_s}
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
    GuestState.possibly_nouns.include?(self.state.to_sym)
  end

  def likely?
    GuestState.likely_nouns.include?(self.state.to_sym)
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
