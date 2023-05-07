class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # @title = Task.group(:title).pluck(:title).sort
    @tasks = Task.order(created_at: :desc)
    if params[:sort_expired]
      @tasks = Task.order(deadline: :desc)
    end

  end

  def new
    @task = Task.new 
  end

  def create 
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save 
        redirect_to tasks_path, notice: "タスク「#{@task.name}」を作成しました!"
      else
        render :new 
      end
    end
  end

  def show
  end

  def edit
  end

  def update 
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました!"
    else
      render :edit 
    end
  end

  def destroy 
    @task.destroy 
    redirect_to tasks_path, notice: "タスクを削除しました！"
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  private 

  def set_task 
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :priority, :status)
  end
end
