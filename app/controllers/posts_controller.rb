class PostsController < ApplicationController

  before_action :set_post, only: [:show, :destroy]

  def index
    @user = User.find_by(id: current_user.id)
    @users = @user.followings
    @like = Like.new
    @posts = []
    @users.each do |user|
      posts = Post.where(user_id: user.id).order(created_at: :desc)
      @posts.concat(posts)
    end
    myposts = Post.where(user_id: current_user.id)
    @posts.concat(myposts)
    @posts.sort_by!{|post| post.created_at}.reverse!
    if @posts.nil?
      flash[:notice]="まだ投稿がありません…"
      redirect_to("/")
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      flash[:notice] = "新しい投稿をしました"
      redirect_to root_path
    else
      flash[:alert] = "画像を選択してください"
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
    @like = Like.find_by(post_id: params[:id])
    @likes = @post.likes.includes(:user)
  end

  def destroy
    if current_user.id == @post.user_id
      @post.destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to root_path
    else
      flash[:alert] = "その操作はできません"
      redirect_to root_path
    end
  end

  def search
    return nil if params[:keyword] == ""
    @users = User.where(['name LIKE ?', "%#{params[:keyword]}%"] ).where.not(id: current_user.id).limit(10)
    respond_to do |format|
      format.html
      format.json
    end
  end

  private
  def post_params
    params.require(:post).permit(:contents, :image).merge(user_id:current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
