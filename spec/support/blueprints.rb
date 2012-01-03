require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

User.blueprint do
  # Attributes here
end

Admin.blueprint do
  # Attributes here
end

Designer.blueprint do
  # Attributes here
end

Guest.blueprint do
  # Attributes here
end

# when is a reserved word so does not work with machinist
class Wedding
  def _when=(datetime)
    self.when = datetime
  end
end

Wedding.blueprint do
  name { "The Wedding of #{Faker::Name.first_name} and #{Faker::Name.first_name}" }
  _when { Time.now + 5.weeks }
  where { Faker::Address.street_address }
  has_reception { true }
  reception_when { Time.now + 5.weeks }
  reception_where { Faker::Address.street_address }
end

Comment.blueprint do
  # Attributes here
end

Collaborator.blueprint do
  # Attributes here
end

Stationary.blueprint do
  # Attributes here
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
end
