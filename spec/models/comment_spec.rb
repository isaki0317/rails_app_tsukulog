require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:end_user) { create(:end_user) }
    let(:test_post) { create(:post) }
    let(:comment) { create(:comment, end_user_id: end_user.id, post_id: test_post.id) }

    context 'bodyカラム' do
      let(:test_comment) { comment }
      it '空欄の場合はエラーが出る' do
        test_comment.body = ''
        test_comment.valid?
        expect(test_comment.errors[:body]).to include("を入力してください")
      end

      it '50文字以上の場合はエラーが出る' do
        test_comment.body = Faker::Lorem.characters(number:51)
        test_comment.valid?
        expect(test_comment.errors[:body]).to include("は50文字以内で入力してください")
      end
    end
  end

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