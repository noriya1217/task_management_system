class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  def index
    # TODO: index画面にて表のNameをSortする機能を実装するにはUserテーブルの操作が必要
    # params[:q][:s] == 'name ask' || params[:q][:s] == 'name desk'
    # 要件には無いが、使えない状態はよくないので、後ほど実装方法考える。
    @q = Task.search_ransack(params[:q])
    if params[:q].nil?
      @tasks = params[:sort_key].present? ? Task.sorted_by(params[:sort_key], params[:page]) : Task.latest(params[:page])
    else
      # TODO: @q.resultをモデルに移行したいが、上手くいかない。余裕があれば考える。
      @tasks = @q.result(distinct: true).page(params[:page])
      @search_count = @q.result(distinct: true).count
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, notice: '新しいタスクを作成しました'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task.id), notice: 'タスクを編集しました'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'タスクを削除しました'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:subject, :content, :expired_at, :state, :priority, :user_id, label_ids: [], user_label_ids: [])
  end

  def require_login
    unless logged_in?
      flash[:error] = 'このセクションにアクセスするにはログインして下さい'
      redirect_to new_session_url
    end
  end
end
