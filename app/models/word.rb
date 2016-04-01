class Word < ActiveRecord::Base
  QUERY_WORD_LEARNED = "id in (select lesson_words.word_id from lessons join
    lesson_words on lessons.id = lesson_words.lesson_id where
    lessons.user_id = ? and lessons.category_id in (?))"
  QUERY_WORD_UNLEARNED = "id not in (select lesson_words.word_id from lessons
    join lesson_words on lessons.id = lesson_words.lesson_id
    where lessons.user_id = ?) and words.category_id in (?)"
  QUERY_WORD_ALL = "id in (select id from words
    where words.category_id in (?))"

  belongs_to :category

  has_many :lesson_words
  has_many :word_answers, dependent: :destroy

  accepts_nested_attributes_for :word_answers,
    reject_if: proc {|attributes| attributes[:content].blank?},
    allow_destroy: true

  validates :content, presence: true
  validate :only_one_correct_answer

  scope :by_learned, ->(user_id, category_id){where QUERY_WORD_LEARNED,
    user_id, category_id}
  scope :by_unlearned, ->(user_id, category_id){where QUERY_WORD_UNLEARNED,
    user_id, category_id}
  scope :by_all, ->(user_id, category_id){where QUERY_WORD_ALL, category_id}

  private
  def only_one_correct_answer
    errors.add :many_answer, I18n.t("models.word.many_answer") unless
      word_answers.select{|answer| answer.correct}.size == 1
  end
end
