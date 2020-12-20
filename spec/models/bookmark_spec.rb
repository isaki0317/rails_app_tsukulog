require 'rails_helper'

RSpec.describe 'Bookmarkモデルのテスト', type: :model do

  describe 'アソシエーションのテスト' do

    context 'N:1のモデルとの関係' do
      it 'EndUserモデルとの関係' do
        expect(Bookmark.reflect_on_association(:end_user).macro).to eq :belongs_to
      end

      it 'EndUserモデルとの関係' do
        expect(Bookmark.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end