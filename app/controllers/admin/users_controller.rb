class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_user, except: [:index, :new, :create]

  def index
    @users = User.paginate page: params[:page]
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
    params.require(:user).permit :name, :email, :password, :password_confirmation
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
