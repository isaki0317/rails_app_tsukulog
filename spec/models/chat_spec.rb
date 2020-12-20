require 'rails_helper'

RSpec.describe 'Chatモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:end_user) { create(:end_user) }
    let(:room) { create(:room) }
    let(:chat) { build(:chat, end_user_id: end_user.id, room_id: room.id) }

    context 'messageカラム' do
      let(:test_chat) { chat }
      it '空欄の場合はエラーが出る' do
        test_chat.message = ''
        test_chat.valid?
        expect(test_chat.errors[:message]).to include("は1文字以上で入力してください")
      end

      it '60文字以上の場合はエラーが出る' do
        test_chat.message = Faker::Lorem.characters(number:61)
        test_chat.valid?
        expect(test_chat.errors[:message]).to include("は60文字以内で入力してください")
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'N:1のモデルとの関係' do
      it 'EndUserモデルとの関係' do
        expect(Chat.reflect_on_association(:end_user).macro).to eq :belongs_to
      end

      it 'Roomモデルとの関係' do
        expect(Chat.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end

    context '1:Nのモデルとの関係' do
      it 'Notificationモデルとの関係' do
        expect(Chat.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end