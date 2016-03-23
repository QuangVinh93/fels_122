# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do |n|
  Word.create! content: Faker::Lorem.word, category_id: 1
end

Category.create! name: "Basic 500"
Category.create! name: "Advance 500"

10.times do |n|
  WordAnswer.create! content: Faker::Lorem.word, correct: true, word_id: n+1
end
