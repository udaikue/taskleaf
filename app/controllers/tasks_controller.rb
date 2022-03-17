class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to @task, notice: "「#{@task.name}」を登録しました٩( 'ω' )و"
    else
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    task = current_user.tasks.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_path, notice: "#{task.name}を更新しました( ・∇・)"
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    redirect_to tasks_path, notice: "#{task.name}を削除しましたϵ( 'Θ' )϶"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
