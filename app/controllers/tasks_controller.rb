class TasksController < ApplicationController
  
  before_action :set_task, except: [ :index, :new, :create ]
  
  def index
    @tasks = current_user.tasks.order(updated_at: :desc)

    if params[:status].present? && params[:status] != "All"
      @tasks = @tasks.where(status: params[:status])
    end

    @hash = {}
    @tasks.group_by(&:status).each do |ele| @hash.merge!(ele[0]=> ele[1].count)  end
    @total_count = @tasks.count

    @tasks = @tasks.paginate(:page => params[:page], :per_page => 8)
  end

  def new
    @task = Task.new()
  end

  def create
    @task = Task.new(task_params.merge(user_id: current_user.id))
    
    if @task.save
      flash[:notice] = "Successfully created the task."
      redirect_to task_path(@task)
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
      flash[:notice] = "Successfully updated the task."
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  def mark_inprogress
    @task.update(status: "inprogress")
    flash[:notice] = "Successfully moved the task to inprogress."
    redirect_to task_path(@task)
  end

  def mark_done
    @task.update(status: "done")
    flash[:notice] = "Successfully moved the task to inprogress."
    redirect_to task_path(@task)
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :deadline)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
    authorize @task
  end
end
