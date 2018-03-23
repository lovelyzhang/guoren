class LoginController < ApplicationController
  def init
    if logged_in?
      redirect_to main_path
    else
      render 'init'
    end

  end

  def login
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in(user)
      redirect_to main_path
    else
      flash.now[:danger] = "用户名或者密码错误"
      render 'init'
    end
  end

  def logout
    log_out
    redirect_to login_path
  end

end
