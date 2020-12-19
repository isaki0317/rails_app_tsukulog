require 'rails_helper'

RSpec.describe 'Workモデルのテスト', type: :model do

  describe 'アソシエーションのテスト' do
    context 'N:1のモデルとの関係' do

      it 'Postモデルとの関係' do
        expect(Work.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end
