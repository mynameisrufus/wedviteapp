class Wedding < ActiveRecord::Base
  has_one :stationary, counter_cache: :popularity
  has_many :guests, dependent: :destroy
  belongs_to :ceremony_where, class_name: 'Location', foreign_key: 'ceremony_location_id', dependent: :destroy
  belongs_to :reception_where, class_name: 'Location', foreign_key: 'reception_location_id', dependent: :destroy
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators

  validates :partner_one_name, presence: true
  validates :partner_two_name, presence: true
  validates :name, presence: true
  validate :can_change_stationary

  before_validation on: :create do
    self.partner_one_name = 'Bride'
    self.partner_two_name = 'Groom'
  end

  def can_change_stationary
    errors.add :stationary_id, "You can no longer change your stationary as the invitations have been sent" if
      stationary_id_changed? and payment_made?
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
        :wording, :ceremony_only_wording, :save_the_date_wording,
        :ceremony_how, :ceremony_what, :reception_how, :reception_what,
        :ceremony_where, :reception_where,
        :guests
      ]
    else
      [
        :wording, :save_the_date_wording,
        :ceremony_how, :ceremony_what,
        :ceremony_where,
        :guests
      ]
    end
  end
end
