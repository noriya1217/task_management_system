class SessionsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) && user.authenticate(params[:session][:password_confirmation])
      session[:user_id] = user.id
      redirect_to user_path(user.id), notice: 'ログインしました'
    else
      flash.now[:danger] = 'ログイン出来ませんでした'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end

  private

  def require_login
    if logged_in?
      flash[:error] = 'このセクションにアクセスするにはログアウトして下さい'
      redirect_to tasks_path
    end
  end
end
