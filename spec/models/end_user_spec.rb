require 'rails_helper'

RSpec.describe 'EndUserモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { test_user.valid? }

    let(:end_user) { create(:end_user) }
    let(:end_user_2) { create(:end_user) }

    context 'nameカラム' do
      let(:test_user) { end_user }

      it '空欄でないこと' do
        test_user.name = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        test_user.name = ''
        test_user.valid?
        expect(test_user.errors[:name]).to include("を入力してください")
      end
      it '2文字以上であること' do
        test_user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '20文字以下であること' do
        test_user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      let(:test_user) { end_user }
      let(:test_user_2) { end_user_2 }

      it '空欄でないこと' do
        test_user.email = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        test_user.email = ''
        test_user.valid?
        expect(test_user.errors[:email]).to include("を入力してください")
      end
      it '一意であること' do
        test_user.email = 'testmail@test.com'
        test_user.save
        test_user_2.email = 'testmail@test.com'
        test_user_2.save
        test_user_2.valid?
        expect(test_user_2).not_to be_valid
      end
      it '一意でない場合はエラーが出る' do
        test_user.email = 'testmail@test.com'
        test_user.save
        test_user_2.email = 'testmail@test.com'
        test_user_2.save
        test_user_2.valid?
        expect(test_user_2.errors[:email]).to include("はすでに存在します")
      end
    end

    context 'introductionカラム' do
      let(:test_user) { end_user }

      it '50文字以下であること' do
        test_user.introduction = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
      it '50文字以上の場合はエラーが出る' do
        test_user.introduction = Faker::Lorem.characters(number: 51)
        test_user.valid?
        expect(test_user.errors[:introduction]).to include("は50文字以内で入力してください")
      end
    end

    context 'addressカラム' do
      let(:test_user) { end_user }

      it '50文字以下であること' do
        test_user.address = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
      it '50文字以上の場合はエラーが出る' do
        test_user.address = Faker::Lorem.characters(number: 51)
        test_user.valid?
        expect(test_user.errors[:address]).to include("は50文字以内で入力してください")
      end
    end

    context 'passwordカラム' do
      let(:test_user) { end_user }

      it '空欄でないこと' do
        test_user.password = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        test_user.password = ''
        test_user.valid?
        expect(test_user.errors[:password]).to include("を入力してください")
      end
      it '6文字以上であること' do
        test_user.password = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '６文字未満の場合はエラーが出る' do
        test_user.password = Faker::Lorem.characters(number: 1)
        test_user.valid?
        expect(test_user.errors[:password]).to include("は6文字以上で入力してください")
      end
      it 'パスワードが不一致だとエラーが出る' do
        test_user.password = 'password1'
        test_user.password_confirmation = 'password2'
        test_user.valid?
        expect(test_user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context '1:Nのモデルとの関係' do
      it 'Postモデルとの関係' do
        expect(EndUser.reflect_on_association(:posts).macro).to eq :has_many
      end

      it 'Contactモデルとの関係' do
        expect(EndUser.reflect_on_association(:contacts).macro).to eq :has_many
      end

      it 'Commentモデルとの関係' do
        expect(EndUser.reflect_on_association(:comments).macro).to eq :has_many
      end

      it 'Favoriteモデルとの関係' do
        expect(EndUser.reflect_on_association(:favorites).macro).to eq :has_many
      end

      it 'Postモデルとの関係' do
        expect(EndUser.reflect_on_association(:favorite_posts).macro).to eq :has_many
      end

      it 'Bookmarkモデルとの関係' do
        expect(EndUser.reflect_on_association(:bookmarks).macro).to eq :has_many
      end

      it 'Postモデルとの関係' do
        expect(EndUser.reflect_on_association(:bookmark_posts).macro).to eq :has_many
      end

      it 'UserRoomモデルとの関係' do
        expect(EndUser.reflect_on_association(:user_rooms).macro).to eq :has_many
      end

      it 'Roomモデルとの関係' do
        expect(EndUser.reflect_on_association(:rooms).macro).to eq :has_many
      end

      it 'Chatモデルとの関係' do
        expect(EndUser.reflect_on_association(:chats).macro).to eq :has_many
      end

      it 'Relationshipモデル：フォローする側から見たrilashonships' do
        expect(EndUser.reflect_on_association(:active_relationships).macro).to eq :has_many
      end

      it 'EndUserモデル：followerを集める定義' do
        expect(EndUser.reflect_on_association(:followings).macro).to eq :has_many
      end

      it 'Relationshipモデル：フォローされる側から見たrilashonships' do
        expect(EndUser.reflect_on_association(:passive_relationships).macro).to eq :has_many
      end

      it 'EndUserモデル：followingを集める定義' do
        expect(EndUser.reflect_on_association(:followers).macro).to eq :has_many
      end

      it 'Notificationモデル：通知を送る側からみたnotifications' do
        expect(EndUser.reflect_on_association(:active_notifications).macro).to eq :has_many
      end

      it 'Notificationモデル：通知を受け取る側からみたnotifications' do
        expect(EndUser.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end

      it 'Blockモデル：ブロックするユーザーから見たblocks' do
        expect(EndUser.reflect_on_association(:active_blocks).macro).to eq :has_many
      end

      it 'EndUserモデル：blockedを集める定義' do
        expect(EndUser.reflect_on_association(:blockers).macro).to eq :has_many
      end

      it 'Blockモデル：ブロックされるユーザーから見たblocks' do
        expect(EndUser.reflect_on_association(:passive_blocks).macro).to eq :has_many
      end
    end
  end
end
