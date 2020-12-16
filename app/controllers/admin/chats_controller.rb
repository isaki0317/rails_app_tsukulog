class Admin::ChatsController < ApplicationController

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
    # @user_room = UserRoom.where(id: @chat.room.id).first
    # @pair_user_id = @user_room.end_user_id
    # @chats = @user_room.room.chats
    @chat.destroy
    # redirect_to admin_end_user_chats_path(end_user_id: @chat.end_user.id, pair_user_id: @pair_user_id)
  end

end
