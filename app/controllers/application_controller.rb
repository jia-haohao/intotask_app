class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  # helper_method :current_user
  before_action :login_required

  private

  def login_required
    redirect_to new_session_path unless current_user
  end

  def authenticate_user!
    redirect_to tasks_path if current_user
  end

  def mypage_user!
    if current_user == @user
      return
    else
      redirect_to tasks_path 
    end
  end
end
