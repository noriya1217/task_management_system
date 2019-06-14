class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
  end

  def show
  end

  def edit
  end
end
