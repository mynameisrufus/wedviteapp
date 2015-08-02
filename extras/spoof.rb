class Spoof
  def self.wedding attributes = {}
    wedding = Wedding.new({
      name: "Preview wedding",
      wording: "Hi!",
      partner_one_name: Faker::Name.name,
      partner_two_name: Faker::Name.name,
      ceremony_when: Time.now + 10.days + 5.hours,
      ceremony_when_end: Time.now + 10.days + 10.hours,
      respond_deadline: Time.now + 5.days + 10.hours
    }.merge(attributes))
    # Need a fake id for url creation.
    wedding.id = rand 999
    wedding
  end

  def self.guest attributes = {}
    Guest.new({
      wedding: wedding,
      name: Faker::Name.name,
      email: email,
      token: token
    }.merge(attributes))
  end

  def self.user attributes = {}
    User.new({
      email: email,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name
    }.merge(attributes))
  end

  def self.message attributes = {}
    guest.messages.new({
      text: "tinopai... mete"
    }.merge(attributes))
  end

  def self.reply attributes = {}
    guest.replies.new({
      text: "tinopai... mete",
      message: message
    }.merge(attributes))
  end

  def self.text
    Faker::Lorem.paragraph
  end

  def self.token
    "64T8ShNka1UvM7uxpV3G"
  end

  def self.email
    Faker::Internet.email
  end
end
