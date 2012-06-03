require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

User.blueprint do
  email { Faker::Internet.email }
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
  adults { rand(5) }
  children { rand(5) }
  partner_number { rand(1..2) }
end

Wedding.blueprint do
  name { "The Wedding of #{Faker::Name.first_name} and #{Faker::Name.first_name}" }
  ceremony_when { Time.now + 5.weeks }
  has_reception { true }
  reception_when { Time.now + 5.weeks }
end

Comment.blueprint do
  # Attributes here
end

Collaborator.blueprint do
  user_id { 1 }
  wedding_id { 1 }
  role { Collaborator::ROLES.shuffle.first }
end

Stationary.blueprint do
  name { Faker::Name.first_name }
  style { "Simple" }
  published { true }
  price { 29.95 }
  commision { 0.10 }
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
      <a href="{{ urls.rsvp }}">RSVP</a>
      <a href="{{ urls.decline }}">Decline</a>
    </div>
  </div>
</body>
</html>
EOL
}
end

StationaryAsset.blueprint do
  # Attributes here
end

StationaryImage.blueprint do
  # Attributes here
end

Agency.blueprint do
  # Attributes here
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
  # Attributes here
end

Payment.blueprint do
  # Attributes here
end

Event.blueprint do
  # Attributes here
end
