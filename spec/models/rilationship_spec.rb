require 'rails_helper'

RSpec.describe 'Relationshipモデルのテスト', type: :model do

  describe 'アソシエーションのテスト' do
    context 'N:1のモデルとの関係' do

      it 'EndUserモデルとの関係：フォローする側の見たend_user' do
        expect(Relationship.reflect_on_association(:following).macro).to eq :belongs_to
      end

      it 'EndUserモデルとの関係：フォローされる側の見たend_user' do
        expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
      end
    end
  end
end
