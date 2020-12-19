require 'rails_helper'

RSpec.describe 'Materialモデルのテスト', type: :model do

  describe 'アソシエーションのテスト' do
    context 'N:1のモデルとの関係' do

      it 'Postモデルとの関係' do
        expect(Material.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end