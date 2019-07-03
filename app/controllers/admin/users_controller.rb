class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :set_admin_user, only: [:edit, :update, :show, :destroy]

  def index
    @users = User.latest
  end

  def new
    @user = User.new
    @user.build_admin
  end

  def create
    params[:user][:admin_attributes] = nil if params[:user][:admin_attributes][:user_id] == '無'
    @user = User.new(user_params)
    # TODO: ユーザー新規登録にて管理者権限を'有'の時User.last.id + 1をparams[:user][:admin_attributes][:user_id]に入れてみたが、Admin.newに入れるのに失敗する。
    # しかし、@user.saveを実行すると対応Adminテーブルにもsaveしたuserのidが入っている。これはreferencesされているから？要調査。
    if @user.save
      redirect_to admin_users_path, notice: 'アカウント作成しました'
    else
      @user.build_admin
      render 'new'
    end
  end

  def edit; end

  def update
    if params[:user][:admin_attributes][:user_id] == '無'
      @user.admin.destroy 
      params[:user][:admin_attributes] = nil
    end

    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ID#{@user.id}番のユーザーを編集しました"
    else
      flash.now[:danger] = "ID#{@user.id}番のユーザーの編集に失敗しました"
      render 'edit'
    end
  end

  def show
    @tasks = Task.user_task_list(@user.id)
  end

  def destroy
    flash[:notice] = "ID#{@user.id}番のユーザーを削除しました"
    @user.destroy
    redirect_to admin_users_path
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
    if @user.admin.nil?
      @user.build_admin
      @user.admin.user_id = nil
    end
  end

  def require_admin
    if logged_in?
      unless Admin.find_by(user_id: current_user.id)
        flash[:error] = 'このセクションにアクセス出来るのは、管理者権限のあるユーザーのみです'
        render :layout => 'admin/error', action: 'error'
      end
    else
      flash[:error] = 'ログインしていたアカウントが見つかりません'
      redirect_to root_path
    end
  end
end
