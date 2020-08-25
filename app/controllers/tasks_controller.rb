class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  
  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end
    
  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params)
    if @task.save
      redirect_to board_path(board), notice: 'コメントを追加'
    else
      flash.now[:error] = '更新できませんでした'
      render :new
    end
  end
  
  def show
    @board = Board.find(params[:board_id])
    @task = board.tasks.find(params[:id])
    @comments = @task.comments
  end


  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    redirect_to board_task_path, notice: 'タスクを更新しました'
  end

  private
  def task_params
    params.require(:task).permit(:name, :content, :eyecatch)
  end
end