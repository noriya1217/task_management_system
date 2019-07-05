class Admin::LabelsController < ApplicationController
  # TODO: admin/user_controllerも:require_adminメソッドがあるので、共通化出来ないか調べる→concernsフォルダ内に作成する？
  before_action :require_admin

  def index
    @labels = Label.all
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

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def label_params
    params.require(:label).permit(:name)
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
