class ApplicationController < ActionController::Base
  before_action :get_current_chat_room
  def get_current_chat_room
    if end_user_signed_in?
      rooms = current_end_user.user_rooms.pluck(:room_id)
      @user_chat_rooms = UserRoom.where(room_id: rooms).where.not(end_user_id: current_end_user.id)
    end
  end
end
