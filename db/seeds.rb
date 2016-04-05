# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create! name: "ToanLH",
  email: "toan@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  admin: true
User.create! name: "ToanLH2",
  email: "toan2@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  admin: false

20.times do |n|
  name = Faker::Name.name
  email = "FELS#{n+1}@gmail.com"
  password = "123456"
  User.create! name: name,
    email: email,
    password: password,
    password_confirmation: password
end

users = User.all
user  = users.first
following = users[1..19]
followers = users[2..18]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

Category.create! name: "Basic 500", description: "None"
Category.create! name: "Advance 500", description: "None"

100.times do |n|
  Word.create! content: Faker::Lorem.word,
    category_id: 1,
    word_answers_attributes: [
      {content: Faker::Lorem.word, correct:true},
      {content: Faker::Lorem.word, correct:false},
      {content: Faker::Lorem.word, correct:false}
    ]
end

100.times do |n|
  Word.create! content: Faker::Lorem.word,
    category_id: 2,
    word_answers_attributes: [
      {content: Faker::Lorem.word, correct:true},
      {content: Faker::Lorem.word, correct:false},
      {content: Faker::Lorem.word, correct:false}
    ]
end
