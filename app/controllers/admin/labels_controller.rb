class Admin::LabelsController < ApplicationController
  # TODO: admin/user_controllerも:require_adminメソッドがあるので、共通化出来ないか調べる→concernsフォルダ内に作成する？
  before_action :require_admin
  before_action :set_admin_label, only: [:edit, :update, :destroy]

  def index
    @labels = Label.latest
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to admin_labels_path, notice: 'ラベルを作成しました'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @label.update(label_params)
      redirect_to admin_labels_path, notice: "ID#{@label.id}番のラベルを編集しました"
    else
      flash.now[:danger] = "ID#{@label.id}番のユーザーの編集に失敗しました"
      render 'edit'
    end
  end

  def destroy
    @label.destroy
    redirect_to admin_labels_path, notice: "ID#{@label.id}番のラベルを削除しました"
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end

  def set_admin_label
    @label = Label.find(params[:id])
  end

  def require_admin
    if logged_in?
      unless Admin.find_by(user_id: current_user.id)
        # TODO: 直接URLを指定すれば飛べてしまう。
        flash[:error] = 'このセクションにアクセス出来るのは、管理者権限のあるユーザーのみです'
        render :layout => 'admin/error', action: 'error'
      end
    else
      flash[:error] = 'ログインしていたアカウントが見つかりません'
      redirect_to root_path
    end
  end
end
