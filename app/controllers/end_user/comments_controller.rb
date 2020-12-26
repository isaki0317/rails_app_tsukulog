class EndUser::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    if @comment.save
      @post.create_notification_comment!(current_end_user, @comment.id, @post.end_user.id)
    end
    # 必要なくなった
    comments = @post.comments
    @comments = Post.block_posts(comments, current_end_user)
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
    @post = Post.find(params[:post_id])
    comments = @post.comments
    @comments = Post.block_posts(comments, current_end_user)
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :body, :end_user_id)
  end
end
