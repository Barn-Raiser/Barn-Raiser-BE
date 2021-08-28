# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


5.times do
  Need.create(
              point_of_contact: Faker::Internet.email,
              title: Faker::Lorem.sentence(word_count:3),
              description: Faker::Lorem.paragraph(sentence_count:3),
              start_time: Time.now,
              end_time: Time.now + 1,
              street_address: Faker::Address.street_address,
              city: Faker::Address.city,
              state: Faker::Address.state_abbr,
              zip_code: Faker::Address.zip_code,
              supporters_needed: Faker::Number.number(digits: 2),
              status: 1
            )
end

3.times do
  Need.create(
              point_of_contact: Faker::Internet.email,
              title: Faker::Lorem.sentence(word_count:3),
              description: Faker::Lorem.paragraph(sentence_count:3),
              start_time: Time.now,
              end_time: Time.now + 1,
              street_address: Faker::Address.street_address,
              city: Faker::Address.city,
              state: Faker::Address.state_abbr,
              zip_code: Faker::Address.zip_code,
              supporters_needed: Faker::Number.number(digits: 2),
              status: 0
            )
end

2.times do
  Need.create(
              point_of_contact: Faker::Internet.email,
              title: Faker::Lorem.sentence(word_count:3),
              description: Faker::Lorem.paragraph(sentence_count:3),
              start_time: Time.now,
              end_time: Time.now + 1,
              street_address: Faker::Address.street_address,
              city: Faker::Address.city,
              state: Faker::Address.state_abbr,
              zip_code: Faker::Address.zip_code,
              supporters_needed: Faker::Number.number(digits: 2),
              status: 2
            )
end
