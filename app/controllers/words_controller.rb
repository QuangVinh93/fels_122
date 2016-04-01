class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.all
    condition = params[:condition].nil? ? "all" : params[:condition]
    @words = Word.send("by_#{condition}", current_user.id, category_ids).
      paginate page: params[:page]
  end

  private
  def category_ids
    params[:category_id].blank? ? @categories.map(&:id) : params[:category_id]
  end
end
