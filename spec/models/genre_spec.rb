require 'rails_helper'

RSpec.describe 'Genreモデルのテスト', type: :model do

  describe 'アソシエーションのテスト' do
    context '1:Nのモデルとの関係' do

      it 'Postモデルとの関係' do
        expect(Genre.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end
end