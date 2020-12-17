class UserRoom < ApplicationRecord

  belongs_to :end_user
  belongs_to :room
  has_many :room_chats, through: :room, source: :chats

end
