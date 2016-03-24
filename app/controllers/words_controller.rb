class WordsController < ApplicationController
  def index
    @categories = Category.all
    condition = if params[:condition].nil?
      "all"
    else
      params[:condition]
    end
    @words = Word.send("by_#{condition}", current_user.id, category_ids).
      paginate page: params[:page]
  end

  private
  def category_ids
    params[:category_id].blank? ? @categories.map(&:id) : params[:category_id]
  end
end
