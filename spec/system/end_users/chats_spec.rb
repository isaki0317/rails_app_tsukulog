require 'rails_helper'

describe 'チャット機能のテスト' do
  let(:test_user) { create(:end_user) }
  let!(:test_user_room) { create(:user_room, end_user_id: test_user.id, room_id: test_room.id) }

  let(:test_user_2) { create(:end_user) }
  let!(:test_user_room_2) { create(:user_room, end_user_id: test_user_2.id, room_id: test_room.id) }
  # とりあえずpath(test_user_2)で遷移して、test_userがmessageを送信する想定で作成
  let(:test_room) { create(:room) }
  let(:test_chat) { build(:chat, end_user_id: test_user.id, room_id: test_room.id) }

  before do
    visit new_end_user_session_path
    fill_in 'end_user[email]', with: test_user.email
    fill_in 'end_user[password]', with: test_user.password
    click_button 'Log in'
  end

  describe 'メッセージ送信のテスト' do
    before do
      visit chat_path(test_user_2)
    end

    it 'メッセージ送信に成功する', js: true do
      fill_in 'chat[message]', with: Faker::Lorem.characters(number:5)
      find('#rspec_button').native.send_keys(:return)
    end

    it 'メッセージ送信に失敗する、エラーが出る', js: true do
      fill_in 'chat[message]', with: ''
      find('#rspec_button').native.send_keys(:return)
      expect(page).to have_content 'メッセージは1文字以上で入力してください'
    end
  end
  describe '送信されたmessageの確認(送信された側で確認)' do
    before do
      FactoryBot.create(:chat, end_user_id: test_user_2.id, room_id: test_room.id, message: 'こんにちわ')
      visit chat_path(test_user_2)
    end
    it '送信されたメッセージが確認できる', js: true do
      expect(page).to have_content 'こんにちわ'
    end
  end
end