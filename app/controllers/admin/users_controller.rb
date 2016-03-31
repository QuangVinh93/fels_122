class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_user, except: [:index, :new, :create]

  def index
    name = params[:s_name].present? ? params[:s_name] : ""

    condition = if(params[:s_admin].present? && params[:s_user].present?)
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
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "views.update.success"
      redirect_to admin_users_path
    else
      flash[:danger] = t "views.update.error"
      render :edit
    end
  end

  def destroy
    unless current_user? @user
      @user.destroy
      flash_for_destroy @user
    else
      flash[:warning] = t "admin.flash.user_cannot"
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :avatar, :admin, :password, :password_confirmation
  end

  def find_user
    @user = User.find params[:id]
  end

  def flash_for_destroy params
    if params.destroyed?
      flash[:success] = t "admin.flash.deleted_success"
    else
      flash[:danger] = t "admin.flash.deleted_fails"
    end
  end
end
