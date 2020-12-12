class Room < ApplicationRecord

  has_many :chats
  has_many :user_rooms
  has_many :notifications, dependent: :destroy

end
