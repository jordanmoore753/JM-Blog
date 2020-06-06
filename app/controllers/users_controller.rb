class UsersController < ApplicationController
  include SessionsHelper

  before_action :is_logged_in, only: [:show, :edit, :update]
  before_action :is_not_logged_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params('post'))

    if @user.save
      flash[:success] = 'Successfully created user.'
      redirect_to login_path
    else
      flash.now[:danger] = 'Could not create user.'
      render 'new'
    end
  end

  def edit
    @user = User.find_by(id: cookies.encrypted[:user_id])
  end

  def update
    @user = User.find_by(id: cookies.encrypted[:user_id])

    if @user && @user.update(user_params('patch'))
      flash[:success] = 'User successfully updated.'
      redirect_to profile_path
    else
      flash.now[:danger] = 'User could not be updated.'
      render 'edit'
    end
  end

  def show
    @user = User.find_by(id: cookies.encrypted[:user_id])

    if @user.nil?
      flash[:danger] = 'Must be logged in to view profile.'
      redirect_to login_path
    end

    @posts = Post.where("user_id = '#{@user.id}'")
    @comments = Comment.where("user_id = '#{@user.id}'")

    @authors = {}

    @posts.each do |post| 
      @authors["#{post.id}"] = User.find_by(id: post.user_id).name
    end
  end

  private

  def is_logged_in
    if !logged_in?
      flash[:danger] = 'You are not authorized for this page.'
      redirect_to login_path
    end
  end

  def is_not_logged_in
    if logged_in?
      flash[:danger] = 'You are not authorized for this page.'
      redirect_to profile_path
    end
  end

  def user_params(method)
    if method == 'post'
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    elsif method == 'patch'
      params.require(:user).permit(:name, :email, :password)
    end
  end
end
