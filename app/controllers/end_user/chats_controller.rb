class EndUser::ChatsController < ApplicationController

  def show
    @end_user = EndUser.find(params[:id])
    rooms = current_end_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(end_user_id: @end_user.id, room_id: rooms)
    if user_rooms.nil?
      @room = Room.new
      @room.save
      UserRoom.create(end_user_id: @end_user.id, room_id: @room.id)
      UserRoom.create(end_user_id: current_end_user.id, room_id: @room.id)
      rooms = current_end_user.user_rooms.pluck(:room_id)
    else
      @room = user_rooms.room
    end
    @user_rooms = UserRoom.where(room_id: rooms).where.not(end_user_id: current_end_user.id)
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_end_user.chats.new(chat_params)
    @chat.save
    @room = @chat.room
    @chat.create_notification_chat!(current_end_user, @room, @chat)
    respond_to :js
  end

  private
  def chat_params
    params.require(:chat).permit(:room_id, :message)
  end

end
