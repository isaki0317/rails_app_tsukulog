require 'rails_helper'

RSpec.describe 'Materialモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:end_user) { create(:end_user) }
    let(:genre) { create(:genre) }
    let(:post) { build(:post, end_user_id: end_user.id, genre_id: genre.id) }
    let(:materials) { build(:material, post_id: post.id) }

    context 'material_nameカラム' do
      let(:test_materials) { materials }

      it '空だとエラーが出る' do
        test_materials.material_name = ''
        test_materials.valid?
        expect(test_materials.errors[:material_name]).to include("を入力してください")
      end

      it '20文字以上だとエラーが出る' do
        test_materials.material_name = Faker::Lorem.characters(number: 21)
        test_materials.valid?
        expect(test_materials.errors[:material_name]).to include("は20文字以内で入力してください")
      end
    end

    context 'shopカラム' do
      let(:test_materials) { materials }

      it '空だとエラーが出る' do
        test_materials.shop = ''
        test_materials.valid?
        expect(test_materials.errors[:shop]).to include("は1文字以上で入力してください")
      end

      it '20文字以上だとエラーが出る' do
        test_materials.shop = Faker::Lorem.characters(number: 21)
        test_materials.valid?
        expect(test_materials.errors[:shop]).to include("は20文字以内で入力してください")
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'N:1のモデルとの関係' do
      it 'Postモデルとの関係' do
        expect(Material.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end
