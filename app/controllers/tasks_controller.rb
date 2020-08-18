class TasksController < ApplicationController

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

  def destroy
    board = current_user.boards.find(params[:id])
    task = board.task
    task.destroy!
    redirect_to board_path(board), notice: '削除に成功しました'
  end

  private
  def task_params
    params.require(:task).permit(:name, :content, :eyecatch)
  end
end