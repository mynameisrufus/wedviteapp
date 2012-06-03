class Wedding < ActiveRecord::Base
  include Eventfull
  has_many :events

  has_many :guests, dependent: :destroy
  has_many :collaborators, dependent: :destroy
  has_many :collaboration_tokens, dependent: :destroy
  has_many :users, through: :collaborators
  has_many :payments, as: :purchasable, dependent: :nullify
  belongs_to :stationary, counter_cache: :popularity
  belongs_to :ceremony_where, class_name: 'Location', foreign_key: 'ceremony_location_id', dependent: :destroy
  belongs_to :reception_where, class_name: 'Location', foreign_key: 'reception_location_id', dependent: :destroy

  validates :partner_one_name, presence: true
  validates :partner_two_name, presence: true
  validates :name, presence: true

  PRICE = 49.95

  before_validation on: :create do
    self.partner_one_name = 'Bride'
    self.partner_two_name = 'Groom'
  end

  before_create do
    self.stationary = Stationary.first
  end

  before_create do
    %w(ceremony_when ceremony_when_end reception_when reception_when_end respond_deadline).each do |date|
      self.send :"#{date}=", Time.now
    end
  end

  HELP_ATTRIBUTES = %w(wording ceremony_only_wording ceremony_what reception_what ceremony_how reception_how)
  HELP_MARKDOWN   = HELP_ATTRIBUTES.inject({}) do |memo, help|
    memo.merge({ help => File.read(File.join(Rails.root, 'app', 'help', "#{help}.md")) })
  end

  before_create do
    HELP_ATTRIBUTES.each do |help|
      self.send :"#{help}=", HELP_MARKDOWN[help]
    end
  end

  def invite_process_started!
    unless invite_process_started?
      update_attributes({
        invite_process_started: true,
        invite_process_started_at: Time.now
      })
    end
  end

  class GuestStates
    def initialize(guests)
      @guests = guests
    end
  end

  class GuestState

  end

  def guests_states
    @guests_states ||= GuestStates.new guests.all
  end

  def percent_complete
    completable_attributes.reduce(0) do |count, attribute|
      count += send(attribute).present? ? 1 : 0
    end.to_f / completable_attributes.size.to_f * 100
  end

  def outstanding_attributes
    completable_attributes.reduce([]) do |tasks, attribute|
      tasks << attribute unless send(attribute).present?
      tasks
    end
  end

  def completable_attributes
    if has_reception?
      [
        :wording, :ceremony_only_wording,
        :save_the_date_wording, :thank_you_wording,
        :ceremony_how, :ceremony_what, :reception_how, :reception_what,
        :ceremony_where, :reception_where,
        :guests, :stationary
      ]
    else
      [
        :wording,
        :save_the_date_wording, :thank_you_wording,
        :ceremony_how, :ceremony_what,
        :ceremony_where,
        :guests, :stationary
      ]
    end
  end

  # Julie and Rob's wedding
  def title
    "#{self.partner_one_name} and #{self.partner_two_name}'s Wedding"
  end

  def payment_due?
    (self.created_at + 10.days).to_i <= Time.now.to_i
  end
end
