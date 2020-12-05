class EndUser::FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    favorite = current_end_user.favorites.new(post_id: params[:post_id])
    favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_end_user.favorites.find_by(post_id: params[:post_id])
    favorite.destroy
  end

end
