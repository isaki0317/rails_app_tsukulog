require 'rails_helper'

RSpec.describe 'Chatモデルのテスト', type: :model do

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