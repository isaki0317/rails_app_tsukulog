require 'rails_helper'

RSpec.describe 'Contactモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:end_user) { create(:end_user) }
    let(:contact) { build(:contact, end_user_id: end_user.id) }

    context 'titleカラム' do
      let(:test_contact) { contact }
      it '空欄の場合はエラーが出ること' do
        test_contact.title = ''
        test_contact.valid?
        expect(test_contact.errors[:title]).to include("を入力してください")
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