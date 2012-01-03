class Agency < ActiveRecord::Base
  belongs_to :principal_contact, class_name: 'Designer', foreign_key: 'designer_id'
  has_many :agency_designers
  has_many :designers, through: :agency_designers

  validates_presence_of :name
end
