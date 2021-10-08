class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index

    @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).includes(:user)
    @tasks = current_user.tasks.order(deadline: :desc).page(params[:page]) if params[:sort_expired]
    @tasks = current_user.tasks.order(priority: :asc).page(params[:page]) if params[:sort_priority]
    @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))

    if params[:task_name].present?
			if params[:status].present? 
				@tasks = Task.task_name_search(params[:task_name]).status_search(params[:status]).page params[:page]
			else
				@tasks = Task.task_name_search(params[:task_name]).page(params[:page])
			end
		else
      if params[:status].present?
			  @tasks = Task.status_search(params[:status]).page(params[:page])
      elsif params[:label_id].present?
        @tasks = Task.label_search(params[:label_id]).page params[:page]
      end
		end
  end
  # label = Label.find(params[:task][:label_id].to_i)
  # @tasks = label.tasks.where(user_id: current_user.id).page params[:page]

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @label = @task.task_label_relations.build
    @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
  end

  # GET /tasks/1/edit
  def edit
    @labels = Label.all
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
    params.require(:task).permit(:task_name, :task_details, :priority, :deadline, :status, :label_ids)
  end
end

# def search_by_name_or_status(status, task_name)
#   if status && name == ''
#     @tasks = current_user.tasks.search_by_status(status)
#   elsif task_name && status == ''
#     @tasks = current_user.tasks.search_by_name(task_name.strip)
#   else task_name && status
#     @tasks = current_user.tasks.search_by_name_and_status(task_name.strip, status)
#   end
# end




#  @tasks = Task.all().order(created_at: :desc)
#     # @tasks = current_user.tasks.all.default_order
#     # all_tasks= Task.user_task_list(current_user.id)
#     @tasks = current_user.tasks.all.order(created_at: :desc)
#     # @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
#     if params[:sort_expired].present? && params[:sort_expired] == 'true'
# 			@tasks = Task.all().order(deadline: :desc)
#     end

#     if params[:sort_priority].present? && params[:sort_priority] == 'true'
#       @tasks = Task.all.order(priority: :asc)
#     end

#     if params[:label_id].present? && params[:label_id] == 'true'
#       @tasks = Task.all.order(label: :desc)
#       # @tasks = Tasks.all.label_task_search(params[:label_id]).order(label_id: :asc)
#     end
    

# 		if params[:task_name].present?
# 			if params[:status].present? 
# 				@tasks = Task.task_name_search(params[:task_name]).status_search(params[:status])
# 			else
# 				@tasks = Task.task_name_search(params[:task_name])
# 			end
# 		elsif params[:status].present?
# 			@tasks = Task.status_search(params[:status])
# 		end
#     @tasks = current_user.tasks.page(params[:page])
# if params[:sort_priority].present? && params[:sort_priority] == 'true'
    #   # @tasks = all_tasks.priority_ordered.page(params[:page])
    #   @tasks = all_tasks.order(priority: :asc).page(params[:page])
    # end
    
    # if params[:label_id].present? && params[:label_id] == 'true'
    #   @tasks = all_tasks.(params[:label_id]).page(params[:page])
    # end

		# elsif params[:task_name].present?
		# 	if params[:status].present?
		# 		@tasks = all_tasks.task_name_search(params[:task_name]).status_search(params[:status]).page params[:page]
		# 	else
		# 		@tasks = all_tasks.task_name_search(params[:task_name]).page(params[:page])
		# 	end
		# elsif params[:status].present?
		# 	@tasks = all_tasks.status_search(params[:status]).page(params[:page]
		# elsif params[:label_id].present?
		# 	@tasks = all_tasks.label_task_search(params[:label_id]).page params[:page]
		# elsif params[:sort_priority]
		# 	@tasks = all_tasks.priority_ordered.page(params[:page])
		# else
			# @tasks = all_tasks.order(created_at: :desc).page(params[:page])
		# end

    # @tasks = current_user.tasks.all().order(created_at: :desc)
    # @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))

    # if params[:sort_expired].present? && params[:sort_expired] == 'true'
		# 	@tasks = current_user.tasks.all().order(deadline: :desc)
    # end

    # if params[:sort_priority].present? && params[:sort_priority] == 'true'
    #   @tasks = current_user.tasks.all().order(priority: :asc)
    # end
    
		# if params[:task_name].present?
		# 	if params[:status].present? 
		# 		@tasks = Task.task_name_search(params[:task_name]).status_search(params[:status])
		# 	else
		# 		@tasks = Task.task_name_search(params[:task_name])
		# 	end
		# elsif params[:status].present?
		# 	@tasks = Task.status_search(params[:status])
		# end
    # @tasks = current_user.tasks.page(params[:page])

    # @tasks = current_user.tasks.order("created_at desc").page(params[:page]).includes(:user)
    # @tasks = current_user.tasks.order_by_deadline.page(params[:page]) if params[:sort_expired]
    # @tasks = current_user.tasks.order_by_priority.page(params[:page]) if params[:sort_priority]
    # @tasks = search_by_name_or_status(params[:task][:status], params[:task][:task_name]).page(params[:page]) if params[:task].present?
    #