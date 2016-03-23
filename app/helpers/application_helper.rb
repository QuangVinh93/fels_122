module ApplicationHelper
  def correct_answer word
    word.word_answers.find_by_correct(true).content
  end
end
