class EndUser::FavoritesController < ApplicationController
  before_action :authenticate_end_user!

  def create
    favorite = current_end_user.favorites.new(post_id: params[:post_id])
    favorite.save
    @post = Post.find(params[:post_id])
    @favorite_users = Post.block_action(@post.favorite_end_user, current_end_user)
    unless @post.end_user == favorite.end_user
      @post.create_notification_favorite!(current_end_user, @post.end_user)
    end
  end

  def destroy
    favorite = current_end_user.favorites.find_by(post_id: params[:post_id])
    favorite.destroy
    @post = Post.find(params[:post_id])

    favorite_users = @post.favorite_end_user
    @favorite_users = Post.block_action(favorite_users, current_end_user)
  end
end
