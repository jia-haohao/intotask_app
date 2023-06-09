class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_admin

  def index
    @users = User.all.includes(:tasks)
  end

  def show 
  end
  
  def new
    @user =User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save 
       redirect_to admin_users_path, notice: " #{@user.name}さんを登録しました! "
    else
      render :new
    end
  end

  def edit 
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path, notice: " #{@user.name}さんを更新しました! "
    else
      render :edit
    end
  end

  def destroy 
    if @user.destroy
      redirect_to admin_users_path, notice: " #{@user.name}さんを削除しました! "
    else
      redirect_to admin_users_path, notice: "最低一人の管理者が必要なため#{@user.name}さんを削除できません"
    end
  end

  private 

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password,
                                 :password_confirmation)
  end

  def require_admin 
    unless current_user.admin?
      flash[:notice] = '管理者以外はアクセスできない'
      redirect_to root_path
    end
  end
end
