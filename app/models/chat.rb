class Chat < ApplicationRecord

  belongs_to :end_user
  belongs_to :room
  has_many :notifications, dependent: :destroy

  validates :message, length: {in: 1..60}

  def create_notification_chat!(current_end_user, room, chat)
    roommembernotme = UserRoom.where("room_id = ?", room.id).where.not("end_user_id = ?", current_end_user.id)
    theid = roommembernotme.find_by(room_id: room.id)
    notification = current_end_user.active_notifications.new(
      room_id: room.id,
      chat_id: chat.id,
      visited_id: theid.end_user_id,
      visitor_id: current_end_user.id,
      action: 'dm'
    )
    notification.save if notification.valid?
  end
end
