class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :find_user, only: [:show, :edit, :update]

  def index
    name = params[:s_name].present? ? params[:s_name] : ""

    condition = if params[:s_admin].present? && params[:s_user].present?
      "all"
    elsif params[:s_admin].present?
      params[:s_admin]
    elsif params[:s_user].present?
      params[:s_user]
    else
      nil
    end

    if condition
      @users = User.send("search_#{condition}", name).paginate page: params[:page],
        per_page: Settings.users.per_page
    else
      @users = User.all.paginate page: params[:page],
        per_page: Settings.users.per_page
    end
  end

  def show
    if logged_in?
      @categories = Category.all
      @words = Word.send("by_learned", @user.id, @categories.map(&:id)).
        paginate page: params[:page]
      @count = @words.present? ? @words.count : 0
      @activities = @user.activities.order(created_at: :DESC).
        paginate page: params[:page], per_page: Settings.per_page
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "views.signup.success"
      redirect_to new_session_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "views.update.success"
      redirect_to @user
    else
      flash[:danger] = t "views.update.error"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :avatar, :password, :password_confirmation
  end

  def find_user
    @user = User.find params[:id]
  end
end
