class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  PER = 10
  def index
    if params[:sort_expired]
      @tasks = Task.order(deadline: :desc).page(params[:page]).per(PER)
      # binding.irb 
    elsif params[:sort_priority]
      @tasks = Task.order(priority: :asc).page(params[:page]).per(PER)
      # @tasks = Tasks.sort_priority.paginate(params)
    elsif
      @tasks = Task.order(created_at: :desc).page(params[:page]).per(PER)
    end

    if params[:search].present?
      if params[:title].present? && params[:status].present?
        @tasks = Task.get_by_title(params[:title]).get_by_status(params[:status]).page(params[:page]).per(PER)
      elsif params[:title].present?
          @tasks = Task.get_by_title(params[:title]).page(params[:page]).per(PER)
      elsif params[:status].present?
          @tasks = Task.get_by_status(params[:status]).page(params[:page]).per(PER)
      end
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
        redirect_to tasks_path, notice: "タスクを作成しました!"
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
