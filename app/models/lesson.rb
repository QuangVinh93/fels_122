class Lesson < ActiveRecord::Base
  include CreateActivity

  after_create :save_activity

  belongs_to :user
  belongs_to :category

  has_many :lesson_words
  has_many :activities
  has_many :words, through: :lesson_words
  has_many :word_answers, through: :lesson_words

  accepts_nested_attributes_for :lesson_words

  private
  def save_activity
    create_activity user_id, id, Settings.activities.learned
  end
end
