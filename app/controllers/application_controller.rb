class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper

  def logged_in_user
    unless logged_in?
      flash[:danger] = t "views.login.notice"
      redirect_to new_session_path
    end
  end

  def verify_admin
    unless current_user.admin?
      flash[:danger] = t "admin.flash.permission"
      redirect_to root_url
    end
  end
end
