require 'rails_helper'

RSpec.describe 'Blockモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'N:1のモデルとの関係' do
      it 'Blockモデル：自分がブロックしてるユーザーとの関係' do
        expect(Block.reflect_on_association(:blocker).macro).to eq :belongs_to
      end

      it 'Blockモデル：自分をブロックしてるユーザーとの関係' do
        expect(Block.reflect_on_association(:blocked).macro).to eq :belongs_to
      end
    end
  end
end
