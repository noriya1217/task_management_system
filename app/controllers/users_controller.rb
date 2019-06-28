class UsersController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_user_path, notice: 'アカウント作成しました'
    else
      render 'new'
    end
  end

  def show
    if current_user.id == params[:id].to_i
      @user = User.find(params[:id])
    else
      flash[:error] = '他ユーザーのProfileは閲覧出来ません'
      redirect_to tasks_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def require_login
    if logged_in?
      flash[:error] = 'このセクションにアクセスするにはログアウトして下さい'
      redirect_to tasks_path
    end
  end
end
