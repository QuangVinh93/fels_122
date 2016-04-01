class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_words, only: [:destroy, :update]

  def create
    word = Word.new word_params
    if word.save
      flash[:success] = t "admin.words.created"
    else
      flash[:danger] = t "admin.words.create_error"
    end
    redirect_to :back
  end

  def update
    if validate_before_update?
      @word.update_attributes word_params
      flash[:success] = t "admin.words.updated"
    else
      flash[:danger] = t "admin.words.update_error"
    end
    redirect_to :back
  end

  def destroy
    @word.destroy
    flash[:danger] = t "admin.words.deleted"
    redirect_to :back
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id,
      word_answers_attributes: [:id, :content, :correct, :_destroy]
  end

  def load_words
    @word = Word.find_by id: params[:id]
  end

  def validate_before_update?
    destroyed = false
    params[:word][:word_answers_attributes].each do |answer|
      answer = answer.at(1)
      destroyed = true if answer[:_destroy] == "false" && answer[:correct] == "1"
    end
    destroyed
  end
end
