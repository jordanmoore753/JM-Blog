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

    if @comment.user_id == cookies.encrypted[:user_id]
      if @comment.update(comment_params('patch'))
        flash[:success] = 'Successfully updated comment.'
        redirect_to post_path(@comment.post_id)
      else
        flash.now[:danger] = 'There was a problem while updating this comment.'
        render 'edit'
      end
    else
      flash[:danger] = 'You are not authorized to edit this comment.'
      redirect_to post_path(@comment.post_id)
    end
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      @comment.reload
      flash[:success] = 'Successfully created comment.'
      redirect_to post_path(@comment.post_id)
    else
      flash.now[:danger] = 'Could not create this comment.'
      render 'new'
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    post_id = @comment.post_id

    if !correct_user?(@comment) || !correct_post?(@comment)
      flash[:danger] = 'You are not authorized to perform that action.'
      return redirect_to post_path(@comment.post_id)
    end

    Comment.destroy(@comment.id)
    flash[:success] = 'Successfully deleted comment.'
    redirect_to post_path(post_id)
  end

  def new
    @comment = Comment.new
  end

  private

  def comment_params(method = 'post')
    if method == 'post'
      params.require(:comment).permit(:body, :user_id, :post_id)
    else
      params.require(:comment).permit(:body)
    end
  end

  def correct_user?(comment)
    post = Post.find_by(id: params[:post_id])

    comment.user_id == cookies.encrypted[:user_id] || post && post.user_id == cookies.encrypted[:user_id]
  end

  def correct_post?(comment)
    comment.post_id == params[:post_id]
  end
end
