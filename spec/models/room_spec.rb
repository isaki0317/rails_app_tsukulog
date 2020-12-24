require 'rails_helper'

RSpec.describe 'Roomモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context '1:Nのモデルとの関係' do
      it 'Chatモデルとの関係' do
        expect(Room.reflect_on_association(:chats).macro).to eq :has_many
      end

      it 'UserRoomモデルとの関係' do
        expect(Room.reflect_on_association(:user_rooms).macro).to eq :has_many
      end

      it 'Notificationモデルとの関係' do
        expect(Room.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end
