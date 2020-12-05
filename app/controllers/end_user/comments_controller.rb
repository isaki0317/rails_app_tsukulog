class EndUser::CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    @post = Post.find(params[:post_id])
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
    @post = Post.find(params[:post_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:post_id, :body, :end_user_id)
  end

end
