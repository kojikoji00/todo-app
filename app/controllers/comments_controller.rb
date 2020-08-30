class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def new
    @task = Task.find(params[:id])
    @comments = @task.comments.build
  end

  def create
    @task = Task.find(params[:id])
    @comments = @task.comments.build(comment_params)
    if @comments.save
      redirect_to board_task_path(board_id: @task.board_id, id: @task.id), notice: 'コメントを追加'
    else
      flash.now[:error] = '更新できませんでした'
      render :new
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy!
    redirect_to root_path, notice: '削除に成功しました'
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
