class EndUser::FavoritesController < ApplicationController

  def create
    favorite = current_end_user.favorites.new(post_id: params[:post_id])
    favorite.save
    @post = Post.find(params[:post_id])
    @post.create_notification_favorite!(current_end_user)
    respond_to :js
  end

  def destroy
    favorite = current_end_user.favorites.find_by(post_id: params[:post_id])
    favorite.destroy
    @post = Post.find(params[:post_id])
  end

end
