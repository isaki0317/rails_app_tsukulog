require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do

  describe 'アソシエーションのテスト' do

    context 'N:1のモデルとの関係' do
      it 'EndUserモデルとの関係' do
        expect(Comment.reflect_on_association(:end_user).macro).to eq :belongs_to
      end

      it 'Postモデルとの関係' do
        expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end