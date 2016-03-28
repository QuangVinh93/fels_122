class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category, dependent: :destroy

  has_many :lesson_words
end
