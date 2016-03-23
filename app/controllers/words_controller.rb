class WordsController < ApplicationController
  def index
    @categories = Category.all
    @words = Word.all.paginate page: params[:page]
  end
end
