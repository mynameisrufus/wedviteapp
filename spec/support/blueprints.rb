require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

User.blueprint do
  email { "user_#{sn}@example.com" }
  password { Faker::Name.name }
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
end

Admin.blueprint do
  # Attributes here
end

Designer.blueprint do
  # Attributes here
end

Guest.blueprint do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  address { Faker::Address.street_address }
  phone { Faker::PhoneNumber.phone_number }
  token { FriendlyToken.make }
  adults { rand(5) }
  children { rand(5) }
  partner_number { rand(1..2) }
end

Guest.blueprint :rejected do
  state { 'rejected' }
end

Guest.blueprint :accepted do
  state { 'accepted' }
end

Wedding.blueprint do
  name { "The Wedding of #{Faker::Name.first_name} and #{Faker::Name.first_name}" }
  ceremony_when { Time.now + 5.weeks }
  has_reception { true }
  reception_when { Time.now + 5.weeks }
  partner_one_name { Faker::Name.first_name }
  partner_two_name { Faker::Name.first_name }
  wording { "{{ guest.name }}" }
  ceremony_only_wording { "{{ guest.name }}" }
end

Comment.blueprint do
  # Attributes here
end

Collaborator.blueprint do
  user_id { 1 }
  wedding_id { 1 }
  role { Collaborator::ROLES.shuffle.first }
end

Stationery.blueprint do
  name { "Very nice stationery No. #{sn}" }
  style { "Simple" }
  published { true }
  price { 29.95 }
  commision { 0.10 }
  agency_id { Agency.make!.id }
  html {
<<EOL
<!DOCTYPE html>
<html lang="en">
<head>
</head>
<body>
  <div class="container">
    {{ content }}
    <div class="actions">
      <a href="{{ urls.accept }}">Accept</a>
      <a href="{{ urls.decline }}">Decline</a>
    </div>
  </div>
</body>
</html>
EOL
}
end

StationeryAsset.blueprint do
  # Attributes here
end

StationeryImage.blueprint do
  # Attributes here
end

Agency.blueprint do
  name { Faker::Name.name }
end

AgencyDesigner.blueprint do
  designer_id { 1 }
  agency_id { 1 }
  role { AgencyDesigner::ROLES.shuffle.first }
end

CollaborationToken.blueprint do
  wedding_id { 1 }
  role { Collaborator::ROLES.shuffle.first }
  email { Faker::Internet.email }
end

AgencyDesignerToken.blueprint do
  agency_id { 1 }
  role { AgencyDesigner::ROLES.shuffle.first }
  email { Faker::Internet.email }
end

Location.blueprint do

end

Message.blueprint do
  text { Faker::Lorem.paragraph }
end

Payment.blueprint do
  # Attributes here
end

Event.blueprint do
  # Attributes here
end

Post.blueprint do
  # Attributes here
end

Author.blueprint do
  # Attributes here
end

PromotionalCode.blueprint do
  code { Faker::Name.name }
  limit { 500 }
  claimed { 0 }
  discount { 0.5 }
  expires_on { Time.now + 5.months }
end

Reply.blueprint do
  # Attributes here
end

GiftRegistry.blueprint do
  details { "Please send gifts to: #{Faker::Address.street_address}" }
end

Gift.blueprint do
  description { "Donna Hay glass cake dome" }
  url { "http://www.donnahay.com.au/cake-dome" }
  price { 29.95 }
end
