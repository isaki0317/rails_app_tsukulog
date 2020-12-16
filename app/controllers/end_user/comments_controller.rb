class EndUser::CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    if @comment.save
      @post.create_notification_comment!(current_end_user, @comment.id, @post.end_user.id)
      # respond_to :js
    else
      @genres = Genre.all
      @comment_new = Comment.new
      render 'end_user/posts/show'
    end
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
