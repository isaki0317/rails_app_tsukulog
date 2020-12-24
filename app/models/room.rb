class Room < ApplicationRecord
  has_many :chats
  has_many :user_rooms, dependent: :destroy
  has_many :notifications, dependent: :destroy
end
