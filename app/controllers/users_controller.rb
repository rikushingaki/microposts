class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user 
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to @user , notice:'メッセージを編集しました'
    else
      render 'edit'
    end
  end
  
  def followings
    render 'show_follow'
  end
  
  def followers
    render 'show_follow'
  end
  
  def followings
    @title = 'followings'
    @user = User.find(params[:id])
    @user = @user.following_users
    render 'show_follow'
  end
  
  def followers
    @title = 'followers'
    @user = User.find(params[:id])
    @user = @user.follower_users
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :location,
                                 :password_confirmation)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path if @user != current_user
  end
end

