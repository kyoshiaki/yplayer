# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
User.create!(name:  "admin",
             password:              "adminadmin",
             password_confirmation: "adminadmin",
             admin:     true)

User.create!(name:  "company",
             password:              "company",
             password_confirmation: "company",
             admin:     false)

99.times do |n|
  name  = Faker::Name.unique.name
  password = "password"
  User.create!(name:  name,
               password:              password,
               password_confirmation: password,
               admin: (n % 2) == 0 ? true : false)
end

=begin
# Sounds
users = User.order(:created_at).take(6)
50.times do |n|
  path = Faker::File.file_name(nil,nil,'mp3')
  name = File.basename(path)
  users.each { |user| user.sounds.create!(
    path: path,
    name: name, 
    listened: (n % 2) == 0 ? true : false, 
    playhead: rand(100) ) }
end
=end
