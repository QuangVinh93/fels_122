class Admin::CategoriesController <ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_category, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "admin.flash.edited_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "admin.flash.edited_fail"
      render :edit
    end
  end

  def destroy
    if @category.destroy?
      flash[:success] = t "admin.flash.deleted_success"
    else
      flash[:danger] = t "admin.flash.deleted_fail"
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end

  def find_category
    @category = Category.find params[:id]
  end
end
