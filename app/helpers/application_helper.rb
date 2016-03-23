module ApplicationHelper

  def correct_answer word
    word.word_answers.find_by_correct(true).content
  end

  def full_title page_title = ""
    base_title = t "base_title"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
