class UsersController < ApplicationController

before_action :authenticate_user!
before_action :set_user, only: %I[show edit update destroy followings followers]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page]).reverse_order
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def followings
      @user  = User.find(params[:user_id])
      @title = @user.name + " さんがフォロー中"
      @users = @user.followings
      render 'show_follow'
  end

  def followers
      @user  = User.find(params[:user_id])
      @title = @user.name + " さんをフォロー中"
      @users = @user.followers
      render 'show_follow'
  end


   private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
