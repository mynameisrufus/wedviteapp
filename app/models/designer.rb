class Designer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :agency_designers
  has_many :agencies, through: :agency_designers
  has_many :stationeries, through: :agencies

  def name
    "#{first_name} #{last_name}" unless first_name.nil? && last_name.nil?
  end
end
