class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @categories = Category.all
      @words = Word.send("by_learned", current_user.id, @categories.map(&:id)).
        paginate page: params[:page]
      @count = @words.present? ? @words.count : 0
      @activities = current_user.activities.order(created_at: :DESC).
        paginate page: params[:page], per_page: Settings.per_page
    end
  end
end
