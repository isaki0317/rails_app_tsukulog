require 'rails_helper'

# マイページでのフォロー解除・申請者に対するフォローのテストも時間あれば記述
describe 'ユーザーのテスト' do
  let(:test_user) { create(:end_user) }
  let(:test_user_2) { create(:end_user) }

  before do
    visit new_end_user_session_path
    fill_in 'end_user[email]', with: test_user.email
    fill_in 'end_user[password]', with: test_user.password
    click_button 'Log in'
  end

  describe 'フォローのテスト' do
    before do
      visit end_user_path(test_user_2)
    end
    context '他人のマイページでのフォローのテスト' do
      it 'フォローに成功する', js: true do
        click_link 'rspec-create-follow'
      end

      it 'フォローを解除する', js: true do
        click_link 'rspec-create-follow'
        click_link 'rspec-destroy-follow'
      end
    end
  end
end