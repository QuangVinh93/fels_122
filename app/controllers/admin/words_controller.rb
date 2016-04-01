class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_words, only: [:destroy, :edit, :update]
  before_action :load_categories, only: [:edit, :new]

  def new
    @word = Word.new
  end

  def create
    word = Word.new word_params
    if word.save
      flash[:success] = t "admin.words.created"
      redirect_to admin_words_path
    else
      flash[:danger] = t "admin.words.create_error"
      redirect_to new_admin_word_path
    end
  end

  def index
    @words = Word.all
  end

  def edit
  end

  def update
    if validate_before_update?
      @word.update_attributes word_params
      flash[:success] = t "admin.words.updated"
      redirect_to admin_words_path
    else
      flash[:danger] = t "admin.words.update_error"
      redirect_to edit_admin_word_path @word
    end
  end

  def destroy
    @word.destroy
    flash[:danger] = t "admin.words.deleted"
    redirect_to admin_words_path
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id,
      word_answers_attributes: [:id, :content, :correct, :_destroy]
  end

  def load_words
    @word = Word.find_by params[:id]
  end

  def load_categories
    @categories = Category.all
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
