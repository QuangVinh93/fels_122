class Admin::CategoriesController <ApplicationController
  before_action :logged_in_user
  before_action :verify_admin

  def index
    @categories = Category.all.paginate page: params[:page]
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "admin.flash.created_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "admin.flash.created_fail"
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end
end
