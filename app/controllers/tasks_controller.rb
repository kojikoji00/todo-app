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
    @task = @board.tasks.find(params[:id])
    @comments = @task.comments
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy!
    redirect_to board_path(board), notice: '削除に成功しました'
  end

  private
  def task_params
    params.require(:task).permit(:name, :content, :eyecatch)
  end
end