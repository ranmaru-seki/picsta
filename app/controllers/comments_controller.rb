class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.json
      end
    else
      @comments = @post.comments.includes(:user)
      flash.now[:alert] = 'メッセージを入力してさい'
      redirect_to post_path(@post)
    end
  end


  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id:current_user.id)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end


end
