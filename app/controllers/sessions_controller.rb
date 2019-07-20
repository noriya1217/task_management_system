class SessionsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    # TODO: 仮で設定するので、動作確認したら正しいものにする
    @test_user = User.find_by(name: "test")
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && ((user.authenticate(params[:session][:password]) && user.authenticate(params[:session][:password_confirmation])) || params[:commit].eql?('テストユーザーでログイン'))
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました'
    else
      flash.now[:danger] = 'ログイン出来ませんでした'
      @test_user = User.find_by(name: "test")
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
