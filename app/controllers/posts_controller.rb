class PostsController < ApplicationController
  def index
    @posts = Post.all
    @authors = {}

    @posts.each do |post| 
      @authors["#{post.id}"] = User.find_by(id: post.user_id).name
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])

    if @post.nil? || @post.user_id != cookies.encrypted[:user_id]
      flash[:danger] = 'Post does not exist or access not allowed.'
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find_by(id: params[:id])

    if @post.update(post_params)
      @post.reload
      flash[:success] = 'Post successfully updated.'
      redirect_to post_path(@post)
    else
      flash.now[:danger] = 'Post could not be updated.'
      render 'edit'
    end
  end

  def show
    @post = Post.find_by(id: params[:id])

    if @post.nil?
      flash[:danger] = 'Post does not exist.'
      redirect_to posts_path
    end

    @authors = {}
    @comments = Comment.where("post_id = '#{@post.id}'")
    @comments.each { |comment| @authors["#{comment.id}"] = User.find_by(id: comment.user_id ).name }
  end

  def create
    params[:post][:user_id] = cookies.encrypted[:user_id]
    @post = Post.new(post_params)

    if @post.save
      flash[:success] = 'Post successfully created.'
      redirect_to posts_path
    else
      flash.now[:danger] = 'Post could not be saved.'
      render 'new'
    end
  end

  def new
    @post = Post.new
  end

  def destroy
    @post = Post.find_by(id: params[:id])

    if @post.nil? || @post.user_id != cookies.encrypted[:user_id]
      flash[:danger] = 'Post does not exist or access not allowed.'
    else
      Post.destroy(@post.id)
      flash[:success] = 'Post successfully deleted.' 
    end

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
