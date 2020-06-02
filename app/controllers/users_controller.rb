class UsersController < ApplicationController
  before_action :is_logged_in, only: [:show, :edit, :update]
  before_action :is_not_logged_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create

  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update

  end

  def show
    @user = User.find(session[:user_id])
  end

  private

  def is_logged_in
    
  end

  def is_not_logged_in

  end
end
