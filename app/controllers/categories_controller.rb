class CategoriesController < ApplicationController
  def index
    @categories = Category.all.paginate page: params[:page]
  end
end
