# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create!({
  email: 'rufuspost@gmail.com',
  password: 'f864r910h0w6g3AH026l4mR796Y809n3'
})

unless Rails.env.production?
  require 'ffaker'

  designer = Designer.create!({
    email: 'rufuspost@gmail.com',
    password: '4863are',
    first_name: 'Rufus',
    last_name: 'Post'
  })

  agency = Agency.create!({
    name: "Wedvite",
    principal_contact: designer
  })

  AgencyDesigner.create!({
    designer: designer,
    agency: agency,
    role: 'manage'
  })

  user = User.create!({
    email: 'rufuspost@gmail.com',
    password: 'password',
    first_name: 'Rufus',
    last_name: 'Post'
  })

  [["Greek wedding", 500], ["Small wedding", 40], ["Medium wedding", 120]].each do |wedding_type|
    wedding = Wedding.create!({
      name: wedding_type.first
    })

    collaborator = Collaborator.create!({
      role: 'invite',
      wedding: wedding,
      user: user
    })

    wedding_type.last.times do    
      guest = Guest.create!({
        wedding: wedding,
        name: Faker::Name.name,
        email: Faker::Internet.email,
        address: Faker::Address.street_address,
        phone: Faker::PhoneNumber.phone_number,
        adults: rand(1..4),
        children: rand(0..2),
        partner_number: rand(1..2)
      })
      guest.update_state Guest::STATES.shuffle.first[:noun]
    end
  end
end
