require 'rails_helper'

# マイページでのフォロー解除・申請者に対するフォローのテストも時間あれば記述
describe 'フォローのテスト' do
  let(:test_user) { create(:end_user) }
  let(:test_user_2) { create(:end_user) }

  before do
    visit new_end_user_session_path
    fill_in 'end_user[email]', with: test_user.email
    fill_in 'end_user[password]', with: test_user.password
    click_button 'Log in'
  end

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