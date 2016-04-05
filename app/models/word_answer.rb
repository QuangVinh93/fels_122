class WordAnswer < ActiveRecord::Base
  QUERY_WORD_ANSWERS_CORRECT = "id in (select lesson_words.word_answer_id
    from lessons join lesson_words on lessons.id = lesson_words.lesson_id
    where lessons.id = ?) and correct = 't'"

  belongs_to :word

  has_many :lesson_words
  has_many :lessons, through: :lesson_words

  validates :content, presence: true

  scope :correct_answers, ->lesson_id{where QUERY_WORD_ANSWERS_CORRECT, lesson_id}
end
