class Admin::EndUsersController < ApplicationController

  def index
    @end_users = EndUser.all
  end

  def show
    @end_user = EndUser.find(params[:id])
    @posts = Post.where(end_user_id: @end_user.id)
    @favorites = Favorite.where(end_user_id: @end_user.id)
    @bookmarks = Bookmark.where(end_user_id: @end_user.id)
    @mutual_follows = @end_user.matchers
    rooms = @end_user.user_rooms.pluck(:room_id)
    @user_rooms = UserRoom.where(room_id: rooms).where.not(end_user_id: @end_user.id)
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
