class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      flash[:success] = t "views.session.success"
      redirect_to current_user.admin? ? admin_root_path : root_url
    else
      flash[:danger] = t "views.session.error"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
