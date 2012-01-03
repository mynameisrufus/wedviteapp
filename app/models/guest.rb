class Guest < ActiveRecord::Base
  belongs_to :wedding
  has_many :comments

  validates_presence_of :wedding_id, :name, :email, :adults, :children

  before_create :set_initial_state
  before_create :set_uid

  def set_initial_state
    self.state = 'review'
  end

  def generate_uid
    Array.new(32).map{ UID_CHARS[rand(UID_CHARS.size)].chr }.join
  end

  def set_uid
    uid = generate_uid
    not_unique = self.class.where(uid: uid).first
    not_unique.nil? ? self.uid = uid : set_uid
  end

  UID_CHARS = (48..57).to_a + (65..90).to_a + (97..122).to_a

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

  def update_state(state)
    update_attributes state: state
  end
end
