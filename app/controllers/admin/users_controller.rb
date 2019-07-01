class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :set_admin_user, only: [:edit, :update, :show, :destroy]

  def index
    @admins = Admin.all
    @users = User.latest
  end

  def new
    @user = User.new
    @user.build_admin
  end

  def create
    params[:user][:admin_attributes] = nil if params[:user][:admin_attributes][:user_id] == '無'
    @user = User.new(user_params)
    if @user.save
      # Admin.create(user_id: @user.id) unless params[:user][:admin].nil?
      redirect_to admin_users_path, notice: 'アカウント作成しました'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      # Admin.destroy(user_id: @user.id) unless params[:user][:admin].nil
      redirect_to admin_users_path, notice: "ID#{@user.id}番のユーザーを編集しました"
    else
      flash.now[:danger] = "ID#{@user.id}番のユーザーの編集に失敗しました"
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      admin_attributes: %i[id user_id]
      )
  end

  def set_admin_user
    @user = User.find(params[:id])
    @admin = Admin.find_by(user_id: params[:id])
  end

  def require_admin
    unless Admin.find_by(user_id: current_user.id)
      flash[:error] = 'このセクションにアクセス出来るのは、管理者権限のあるユーザーのみです'
      redirect_to tasks_path
    end
  end
end
