class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin

  def new
    @category = Category.all
    @word = Word.new
  end

  def create
    word = Word.new word_params
    word.save
    redirect_to new_admin_word_path
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id,
      word_answers_attributes: [:id, :content, :correct]
  end
end
