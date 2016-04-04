class User < ActiveRecord::Base
  include Colourable

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :collaborations, class_name: 'Collaborator', dependent: :destroy
  has_many :weddings, through: :collaborations

  has_many :messages, dependent: :destroy, as: :messageable
  has_many :replies, dependent: :destroy, as: :replyable

  # Remember me by default
  def remember_me
    true
  end

  def name
    first_name.present? && last_name.present? ? "#{first_name} #{last_name}" : email
  end

  # Facebook omniauthable methods.
  # See: https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.create(
        first_name: auth.extra.raw_info.first_name,
        last_name: auth.extra.raw_info.last_name,
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        password: Devise.friendly_token[0,20]
      )
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
