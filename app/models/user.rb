class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  
  has_many :collaborations, class_name: 'Collaborator', dependent: :destroy
  has_many :weddings, through: :collaborations

  def name
    if first_name.nil? && last_name.nil?
      email
    else
      "#{first_name} #{last_name}"
    end
  end
end
