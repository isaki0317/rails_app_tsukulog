require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:end_user) { create(:end_user) }
    let(:genre) { create(:genre) }
    let(:post) { build(:post, end_user_id: end_user.id, genre_id: genre.id) }

    context 'titleカラム' do
      let(:test_post) { post }
      it '空欄の場合はエラーが出る' do
        test_post.title = ''
        test_post.valid?
        expect(test_post.errors[:title]).to include("を入力してください")
      end

      it '24文字以上の場合はエラーが出る' do
        test_post.title = Faker::Lorem.characters(number:25)
        test_post.valid?
        expect(test_post.errors[:title]).to include("は24文字以内で入力してください")
      end
    end

    context 'subtitleカラム' do
      let(:test_post) { post }
      it '空欄の場合はエラーが出る' do
        test_post.subtitle = ''
        test_post.valid?
        expect(test_post.errors[:subtitle]).to include("を入力してください")
      end

      it '40文字以上の場合はエラーが出る' do
        test_post.subtitle = Faker::Lorem.characters(number:41)
        test_post.valid?
        expect(test_post.errors[:subtitle]).to include("は40文字以内で入力してください")
      end
    end

    context 'imagesカラム' do
      let(:test_post) { post }
      it '空の場合はエラーが出る' do
        test_post.images = ''
        test_post.valid?
        expect(test_post.errors[:images]).to include("を入力してください")
      end
    end
  end


  describe 'アソシエーションのテスト' do
    context 'N:1のモデルとの関係' do
      it 'EndUserモデルとの関係' do
        expect(Post.reflect_on_association(:end_user).macro).to eq :belongs_to
      end

      it 'Genreモデルとの関係' do
        expect(Post.reflect_on_association(:genre).macro).to eq :belongs_to
      end
    end

    context '1:Nのモデルとの関係' do
      it 'Notificationモデルとの関連' do
        expect(Post.reflect_on_association(:notifications).macro).to eq :has_many
      end

      it 'Commentモデルとの関連' do
        expect(Post.reflect_on_association(:comments).macro).to eq :has_many
      end

      it 'Favoriteモデルとの関連' do
        expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
      end

      it 'EndUserモデルとの関連' do
        expect(Post.reflect_on_association(:favorite_end_user).macro).to eq :has_many
      end

      it 'Bookmarkモデルとの関連' do
        expect(Post.reflect_on_association(:bookmarks).macro).to eq :has_many
      end

      it 'EndUserモデルとの関連' do
        expect(Post.reflect_on_association(:bookmark_end_user).macro).to eq :has_many
      end

      it 'Materialモデルとの関連' do
        expect(Post.reflect_on_association(:materials).macro).to eq :has_many
      end

      it 'Workモデルとの関連' do
        expect(Post.reflect_on_association(:works).macro).to eq :has_many
      end
    end
  end
end