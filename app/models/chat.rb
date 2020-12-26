class Chat < ApplicationRecord
  belongs_to :end_user
  belongs_to :room
  has_many :notifications, dependent: :destroy

  validates :message, length: { in: 1..60 }

  def create_notification_chat(end_user, room, chat)
    user_rooms = UserRoom.where("room_id = ?", room.id).where.not("end_user_id = ?", end_user.id)
    user_room = user_rooms.find_by(room_id: room.id)
    notification = end_user.active_notifications.new(
      room_id: room.id,
      chat_id: chat.id,
      visited_id: user_room.end_user_id,
      visitor_id: end_user.id,
      action: 'dm'
    )
    notification.save
  end
end
