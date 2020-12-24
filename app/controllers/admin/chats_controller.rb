class Admin::ChatsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @end_user = EndUser.find(params[:end_user_id])
    pair_user_id = params[:pair_user_id]
    # 下記で@end_userのトークルームを全て取得
    rooms = @end_user.user_rooms.pluck(:room_id)
    @user_rooms = UserRoom.where(room_id: rooms).where.not(end_user_id: @end_user.id)
    # @pair_userとのルームとDM内容の取得
    @user_room = @user_rooms.find_by(end_user_id: pair_user_id)
    @pair_user = @user_room.end_user
    @room = @user_room.room
    @chats = @room.chats
  end

  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    end_user = @chat.end_user
    pair_user = EndUser.find(params[:end_user_id])
    user = params[:user]
    if user == 'chat-left'
      redirect_to admin_end_user_chats_path(end_user_id: pair_user.id, pair_user_id: end_user.id)
    else
      redirect_to admin_end_user_chats_path(end_user_id: end_user.id, pair_user_id: pair_user.id)
    end
  end

  def room_destroy
    @end_user = EndUser.find(params[:end_user_id])
    pair_user = params[:pair_user]
    @pair_user = EndUser.find_by(id: pair_user)
    @end_user.user_room_delete(@end_user, @pair_user)
    redirect_to admin_end_user_path(@end_user.id)
  end
end
