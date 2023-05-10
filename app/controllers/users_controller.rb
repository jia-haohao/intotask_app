class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :mypage_user!, only: [:show]
  before_action :authenticate_user!, only: [:new, :create]
  skip_before_action :login_required, only: [:new, :create]

  def new
    if logged_in?
      flash[:notice] = 'ログアウトしてから新規ユーザーを登録して下さい'
      redirect_to new_session_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      render :new
    end
  end

  def show
    @tasks = @user.tasks.all
    # unless params[:admin].present?
    #   return redirect_to tasks_path if current_user.id != @user.id
    # end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,:email,:password,
                                              :password_confirmation)
  end
end
