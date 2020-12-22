require 'rails_helper'

RSpec.describe 'Favoriteモデルのテスト', type: :model do

  describe 'アソシエーションのテスト' do
    context 'N:1のモデルとの関係' do

      it 'EndUserモデルとの関係' do
        expect(Favorite.reflect_on_association(:end_user).macro).to eq :belongs_to
      end

      it 'postモデルとの関係' do
        expect(Favorite.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end