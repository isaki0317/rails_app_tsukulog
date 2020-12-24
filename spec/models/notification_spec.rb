require 'rails_helper'

RSpec.describe 'Notificationモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'N:1のモデルとの関係' do
      it 'Postモデルとの関係' do
        expect(Notification.reflect_on_association(:post).macro).to eq :belongs_to
      end

      it 'Commentモデルとの関係' do
        expect(Notification.reflect_on_association(:comment).macro).to eq :belongs_to
      end

      it 'EndUserモデルとの関係：通知を送る側との関係' do
        expect(Notification.reflect_on_association(:visitor).macro).to eq :belongs_to
      end

      it 'EndUserモデルとの関係：通知を受ける側との関係' do
        expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
      end

      it 'Roomモデルとの関係' do
        expect(Notification.reflect_on_association(:room).macro).to eq :belongs_to
      end

      it 'Chatモデルとの関係' do
        expect(Notification.reflect_on_association(:chat).macro).to eq :belongs_to
      end
    end
  end
end
