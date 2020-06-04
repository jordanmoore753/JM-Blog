class CommentsController < ApplicationController
  def edit
    @comment = Comment.find_by(id: params[:id])

    if @comment.nil? || @comment.user_id != cookies.encrypted[:user_id]
      flash[:danger] = 'Comment or authorization does not exist.'
      redirect_to post_path(params[:post_id])
    end
  end

  def update
    @comment = Comment.find_by(id: params[:id])
  end

  def create
    @comment = Comment.new(comment_params)
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])


  end

  def new
    @comment = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end

  def correct_user?(comment)
    comment.user_id == cookies.encrypted[:user_id]
    # modify this to also check for post user_id is the current user
  end

  def correct_post?(comment)
    comment.post_id == params[:post_id]
  end
end
