# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
5.times do |n|
  Word.create! content: Faker::Lorem.word, category_id: 1
end

2.times do |n|
  Word.create! content: Faker::Lorem.word, category_id: 2
end

Category.create! name: "Basic 500"
Category.create! name: "Advance 500"

7.times do |n|
  WordAnswer.create! content: Faker::Lorem.word, correct: true, word_id: n+1
end

User.create! name: "ToanLH",
  email: "toan@gmail.com",
  password: "1",
  password_confirmation: "1",
  admin: true
User.create! name: "ToanLH2",
  email: "toan2@gmail.com",
  password: "1",
  password_confirmation: "1",
  admin: false

Lesson.create! user_id: 1, category_id: 1, result: "18/30"

3.times do |n|
  LessonWord.create! lesson_id: 1, word_id: n+1, word_answer_id: n+1
end
