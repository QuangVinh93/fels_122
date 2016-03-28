class LessonsController < ApplicationController
  before_action :load_lesson, only: [:update, :show, :create]

  def create
    lesson = current_user.lessons.build category_id: params[:category_id]
    Settings.QUESTION_PER_LESSON.times{
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
      @words = Word.all.shuffle.take Settings.QUESTION_PER_LESSON
    else
      @category = Category.find_by id: @lesson.category_id
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
end
