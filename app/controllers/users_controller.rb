class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @user = User.find(params[:id])
    @posts = user.posts.order("created_at DESC")
    #ポスト数（投稿しているかどうか）
    if @posts.count === 0
      @count = 0
    end
  end

  def likesDisplay
    @user = User.find(params[:id])
  end
end
