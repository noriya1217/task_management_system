class Admin::LabelsController < ApplicationController
  # TODO: admin/user_controllerも:require_adminメソッドがあるので、共通化出来ないか調べる→concernsフォルダ内に作成する？
  before_action :require_admin

  def index
    @labels = Label.all
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

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
