class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!

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
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to admin_end_user_path(@end_user)
    else
      render 'edit'
    end
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :images, :address, :experience, :sex, :date_of_birth)
  end
end
