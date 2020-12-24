require 'rails_helper'

RSpec.describe 'Contactモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:end_user) { create(:end_user) }
    let(:contact) { build(:contact, end_user_id: end_user.id) }

    context 'titleカラム' do
      let(:test_contact) { contact }

      it '空欄の場合はエラーが出る' do
        test_contact.title = ''
        test_contact.valid?
        expect(test_contact.errors[:title]).to include("を入力してください")
      end

      it '2文字以上でないとエラーが出る' do
        test_contact.title = Faker::Lorem.characters(number: 1)
        test_contact.valid?
        expect(test_contact.errors[:title]).to include("は2文字以上で入力してください")
      end

      it '30文字以内でないとエラーが出る' do
        test_contact.title = Faker::Lorem.characters(number: 31)
        test_contact.valid?
        expect(test_contact.errors[:title]).to include("は30文字以内で入力してください")
      end
    end

    context 'bodyカラム' do
      let(:test_contact) { contact }

      it '空欄の場合はエラーが出る' do
        test_contact.body = ''
        test_contact.valid?
        expect(test_contact.errors[:body]).to include("を入力してください")
      end

      it '2文字以下の場合はエラーが出る' do
        test_contact.body = Faker::Lorem.characters(number: 1)
        test_contact.valid?
        expect(test_contact.errors[:body]).to include("は2文字以上で入力してください")
      end

      it '200文字以上の場合はエラーが出る' do
        test_contact.body = Faker::Lorem.characters(number: 201)
        test_contact.valid?
        expect(test_contact.errors[:body]).to include("は200文字以内で入力してください")
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'N:1のモデルとの関係' do
      it 'EndUserモデルとの関係' do
        expect(Contact.reflect_on_association(:end_user).macro).to eq :belongs_to
      end
    end
  end
end
