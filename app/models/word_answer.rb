class WordAnswer < ActiveRecord::Base
  QUERY_ANSWER_LIST_ID = "id in (select id from word_answers where id in (?))"

  belongs_to :word

  has_many :lesson_words

  scope :by_list_id, ->list_id{where QUERY_ANSWER_LIST_ID, list_id}
end
