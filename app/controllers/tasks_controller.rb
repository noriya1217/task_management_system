class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired].present?
      @tasks = Task.sort_expired
    else
      @tasks = Task.latest
    end
    if params[:q].nil?

    elsif params[:q][:state_eq] == '指定無し'
      params[:q][:state_eq] = nil
      params[:q] = nil if params[:q][:subject_cont].blank?
    end

    @q = Task.search_ransack(params[:q])
    @searchs = @q.result(distinct: true)
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

  def show
  end

  def edit
  end

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
    params.require(:task).permit(:subject, :content, :expired_at, :state)
  end
end
