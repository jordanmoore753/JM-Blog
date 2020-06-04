class SessionsController < ApplicationController
  include SessionsHelper
  before_action :is_not_logged_in, only: [:new, :create]
  before_action :is_logged_in, only: [:destroy]

  def new
    if logged_in?
      flash[:now] = 'Cannot login if already logged in.'
      redirect_to profile_path
    end
  end

  def create
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])

    if user
      remember(user)
      flash[:success] = 'Welcome back!'
      redirect_to profile_path
    else
      flash.now[:danger] = 'Incorrect credentials.'
      render 'sessions/new'
    end
  end
<<<<<<< HEAD
  
=======

>>>>>>> rest
  def destroy
    flash[:success] = 'Successfully logged out.'
    forget
    redirect_to login_path
  end

  private

  def is_logged_in
    if !logged_in?
      flash[:danger] = 'You are not authorized to do this.'
      redirect_to login_path
    end
  end

  def is_not_logged_in
    if logged_in? 
      flash[:danger] = 'You are not authorized to do this.'
      redirect_to profile_path
    end
  end
end
