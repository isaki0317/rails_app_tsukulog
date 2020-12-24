require 'rails_helper'

# マイページでのフォロー解除・申請者に対するフォローのテストも時間あれば記述
describe 'フォローのテスト' do
  let!(:test_user_1) { create(:end_user, name: 'ユーザー1') }
  let!(:test_user_2) { create(:end_user, name: 'ユーザー2') }
  let!(:test_user_3) { create(:end_user, name: 'ユーザー3') }

  before do
    visit new_end_user_session_path
    fill_in 'end_user[email]', with: test_user_1.email
    fill_in 'end_user[password]', with: test_user_1.password
    click_button 'Log in'
  end

  describe 'フォローボタンのテスト' do
    before do
      visit end_user_path(test_user_2)
    end

    context 'フォローボタンクリック' do
      it 'フォローに成功', js: true do
        click_link 'rspec-create-follow'
      end
    end

    context 'フォローボタン2回クリック' do
      it 'フォローを解除', js: true do
        click_link 'rspec-create-follow'
        click_link 'rspec-destroy-follow'
      end
    end
  end

  describe 'end_user_1マイページ' do
    before do
      # 1と2が相互フォロー
      FactoryBot.create(:relationship, following_id: test_user_1.id, follower_id: test_user_2.id)
      FactoryBot.create(:relationship, following_id: test_user_2.id, follower_id: test_user_1.id)
      # 3が1をフォロー
      FactoryBot.create(:relationship, following_id: test_user_3.id, follower_id: test_user_1.id)
    end

    context 'アクションに伴う表示のテスト' do
      before do
        visit end_user_path(test_user_1)
      end

      it '相互フォローのユーザー2が表示される', js: true do
        click_link '友達'
        expect(page).to have_content 'ユーザー2'
      end
      it 'ユーザー3は表示されない' do
        click_link '友達'
        expect(page).to have_content 'ユーザー3'
      end
      it 'フォロー申請モーダル内にユーザー3が表示される' do
        click_link '友達'
        click_button 'フォロー申請一覧'
        expect(page).to have_content 'ユーザー3'
      end
      it 'ユーザー3をフォローすると「友達」に即時追加される', js: true do
        click_link '友達'
        click_button 'フォロー申請一覧'
        click_link 'create-follow'
        click_button '閉じる'
        expect(page).to have_content 'ユーザー3'
      end
    end

    context '他人(ユーザー2)のマイページ表示のテスト' do
      before do
        visit end_user_path(test_user_2)
      end

      it '相互フォローユーザーにユーザー1が表示される' do
        click_link '友達'
        expect(page).to have_content 'ユーザー1'
      end
      it 'ページトップで相互フォローを解除で即時反映', js: true do
        click_link '友達'
        expect(page).to have_content 'ユーザー1'
        click_link 'rspec-destroy-follow'
        expect(page).to have_no_content 'ユーザー1'
      end
    end
  end
end
