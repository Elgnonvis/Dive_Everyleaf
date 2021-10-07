class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    # @tasks = Task.all().order(created_at: :desc)
    @tasks = current_user.tasks.all.order(created_at: :desc)
    if params[:sort_expired].present? && params[:sort_expired] == 'true'
			@tasks = Task.all().order(deadline: :desc)
    end

    if params[:sort_priority].present? && params[:sort_priority] == 'true'
      @tasks = Task.all.order(priority: :asc)
    end
    
		if params[:task_name].present?
			if params[:status].present? 
				@tasks = Task.task_name_search(params[:task_name]).status_search(params[:status])
			else
				@tasks = Task.task_name_search(params[:task_name])
			end
		elsif params[:status].present?
			@tasks = Task.status_search(params[:status])
		end
    @tasks = current_user.tasks.page(params[:page])
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = current_user.tasks.build(task_params)
      if @task.save
        flash[:success] = "Task was successfully created."
          redirect_to tasks_url
      else
        render :new
      end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
   
      if @task.update(task_params)
        flash[:warning] = "Task was successfully updated."
        redirect_to tasks_url
      else
        render :edit
      end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
      flash[:danger] = "Task was successfully destroyed !"
      redirect_to tasks_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:task_name, :task_details, :priority, :deadline, :status)
    end
end