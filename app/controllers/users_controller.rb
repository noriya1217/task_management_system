class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id), notice: 'アカウント作成しました'
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
end
