require 'rails_helper'

RSpec.describe 'Genreモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:genre) { create(:genre) }
    let(:genre_2) { create(:genre) }

    context 'nameカラム' do
      let(:test_genre) { genre }
      let(:test_genre_2) { genre_2 }
      
      it '空だとエラーが出る' do
        test_genre.name = ''
        test_genre.valid?
        expect(test_genre.errors[:name]).to include("を入力してください")
      end

      it '12文字以上の場合はエラーが出る' do
        test_genre.name = Faker::Lorem.characters(number:13)
        test_genre.valid?
        expect(test_genre.errors[:name]).to include("は12文字以内で入力してください")
      end

      it '一意であること' do
        test_genre.name = "テスト"
        test_genre.save
        test_genre_2.name = "テスト"
        test_genre_2.save
        test_genre_2.valid?
        expect(test_genre_2).not_to be_valid
      end

      it '一意でないとエラーが出る' do
        test_genre.name = "テスト"
        test_genre.save
        test_genre_2.name = "テスト"
        test_genre_2.save
        test_genre_2.valid?
        expect(test_genre_2.errors[:name]).to include("はすでに存在します")
      end
    end
  end


  describe 'アソシエーションのテスト' do
    context '1:Nのモデルとの関係' do

      it 'Postモデルとの関係' do
        expect(Genre.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end
end