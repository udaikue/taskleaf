class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page])
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      TaskMailer.creation_email(@task).deliver_now
      redirect_to @task, notice: "「#{@task.name}」を登録しました٩( 'ω' )و"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_path, notice: "#{@task.name}を更新しました( ・∇・)"
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "#{@task.name}を削除しましたϵ( 'Θ' )϶"
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :image)
  end
end
