class LabelsController < ApplicationController
  # TODO: 他のControllerも:require_loginメソッドがあるので、共通化出来ないか調べる→concernsフォルダ内に作成する？
  before_action :require_login, only: [:new, :create]
  before_action :set_user_label, only: [:edit, :update, :destroy]

  def index
    @user_labels = UserLabel.latest
  end

  def new
    @user_label = UserLabel.new
  end

  def create
    @user_label = UserLabel.new(user_label_params)
    if @user_label.save
      redirect_to labels_path, notice: 'ラベルを作成しました'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user_label.update(user_label_params)
      redirect_to labels_path, notice: "ID#{@user_label.id}番のラベルを編集しました"
    else
      flash.now[:danger] = "ID#{@user_label.id}番のユーザーの編集に失敗しました"
      render 'edit'
    end
  end

  def destroy
    @user_label.destroy
    redirect_to labels_path, notice: "ID#{@user_label.id}番のラベルを削除しました"
  end

  private

  def user_label_params
    params.require(:user_label).permit(:name, :user_id)
  end

  def set_user_label
    @user_label = UserLabel.find(params[:id])
  end

  def require_login
    unless logged_in?
      flash[:error] = 'このセクションにアクセスするにはログインして下さい'
      redirect_to tasks_path
    end
  end
end
