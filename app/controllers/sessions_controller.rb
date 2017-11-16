class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash_message
    end
  end

  def flash_message
    flash.now[:danger] = t "controllers.sessions.invalid"
    render :new
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
