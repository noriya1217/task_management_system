class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @admins = Admin.all
    @users = User.all
  end

  def new
    @admin = Admin.new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      unless params[:user][:admin] == '無'
        Admin.create(user_id: @user.id)
      end
      redirect_to admin_users_path, notice: 'アカウント作成しました'
    else
      render 'new'
    end
  end

  def edit

  end

  def update

  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def require_admin
    unless Admin.find_by(user_id: current_user.id)
      flash[:error] = 'このセクションにアクセス出来るのは、管理者権限のあるユーザーのみです'
      redirect_to tasks_path
    end
  end
end
