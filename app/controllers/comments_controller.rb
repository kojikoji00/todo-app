class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    task = Task.find(params[:board_id])
    @comment = task.comments.build
  end

  def create
    task = Task.find(params[:board_id])
    @comment = task.comments.build(comment_params)
    if @comment.save
      redirect_to board_task_path(:board_id), notice: 'コメントを追加'
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
    params.require(:comment).permit(:name, :content)
  end
end