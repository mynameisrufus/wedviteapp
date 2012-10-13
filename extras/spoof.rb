class Spoof
  def self.wedding attributes = {}
    Wedding.new({
      name: "Preview wedding",
      wording: "Hi!",
      partner_one_name: Faker::Name.name,
      partner_two_name: Faker::Name.name,
      ceremony_when: Time.now + 10.days,
      ceremony_when_end: Time.now + 10.days + 2.hours,
      ceremony_when: Time.now + 10.days + 5.hours,
      ceremony_when_end: Time.now + 10.days + 10.hours,
      respond_deadline: Time.now + 5.days + 10.hours
    }.merge(attributes))
  end

  def self.guest attributes = {}
    Guest.new({
      wedding: wedding,
      name: Faker::Name.name,
      email: Faker::Internet.email,
      token: "64T8ShNka1UvM7uxpV3G"
    }.merge(attributes))
  end

  def self.user attributes = {}
    User.new({
      email: Faker::Internet.email,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name
    }.merge(attributes))
  end

  def self.message
    guest.messages.new({
      text: "tinopai... mete"
    })
  end
end
