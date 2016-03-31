class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :load_lesson, only: [:update, :show]

  def create
    lesson = current_user.lessons.build category_id: params[:category_id]
    category = Category.find_by id: params[:category_id]
    question_quantity(category).times{
      lesson.lesson_words.build
    }
    lesson.save
    redirect_to lesson
  end

  def update
    params[:lesson][:result] = true
    @lesson.update_attributes lesson_params
    redirect_to @lesson
  end

  def show
    if @lesson.result.nil?
      @words = @lesson.category.words.shuffle.
        take question_quantity(@lesson.category)
    else
      word_answer = WordAnswer.all
      @result = WordAnswer.send(:by_list_id, @lesson.lesson_words.
        map(&:word_answer_id)).map(&:correct).count true
      @quantity = question_quantity @lesson.category
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit :user_id, :category_id, :result,
      lesson_words_attributes: [:id, :word_id, :word_answer_id]
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
  end

  def question_quantity category
    category.words.count >= Settings.QUESTION_PER_LESSON ? Settings.
      QUESTION_PER_LESSON : category.words.count
  end
end
