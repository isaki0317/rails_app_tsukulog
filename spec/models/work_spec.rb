require 'rails_helper'

RSpec.describe 'Workモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:end_user) { create(:end_user) }
    let(:genre) { create(:genre) }
    let(:post) { build(:post, end_user_id: end_user.id, genre_id: genre.id) }
    let(:works) { build(:work, post_id: post.id) }

    context 'detailカラム' do
      let(:test_works) { works }
      it '空だとエラーが出る' do
        test_works.detail = ''
        test_works.valid?
        expect(test_works.errors[:detail]).to include("を入力してください")
      end

      it '56文字以上だとエラーが出る' do
        test_works.detail =  Faker::Lorem.characters(number:57)
        test_works.valid?
        expect(test_works.errors[:detail]).to include("は56文字以内で入力してください")
      end
    end
  end


  describe 'アソシエーションのテスト' do
    context 'N:1のモデルとの関係' do

      it 'Postモデルとの関係' do
        expect(Work.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end
