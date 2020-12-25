require 'rails_helper'

describe 'チャット管理側のテスト' do
  let(:admin) { create(:admin) }
  let!(:test_user_1) { create(:end_user, name: 'テスト1') }
  let!(:test_user_2) { create(:end_user, name: 'テスト2') }
  let!(:test_user_room_1) { create(:user_room, end_user_id: test_user_1.id, room_id: test_room.id) }
  let!(:test_user_room_2) { create(:user_room, end_user_id: test_user_2.id, room_id: test_room.id) }
  let(:test_room) { create(:room) }
  let!(:test_chat_1) { create(:chat, end_user_id: test_user_1.id, room_id: test_room.id, message: 'テストユーザー1です') }
  let!(:test_chat_2) { create(:chat, end_user_id: test_user_2.id, room_id: test_room.id, message: 'テストユーザー2です') }

  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'Log in'
    visit admin_end_user_chats_path(end_user_id: test_user_1.id, pair_user_id: test_user_2.id)
  end

  context 'トークルームにユーザーが表示される' do
    it 'ユーザーテスト1が表示される' do
      expect(page).to have_content 'テスト1'
    end
    it 'ユーザーテスト2が表示される' do
      expect(page).to have_content 'テスト2'
    end
  end
  context 'トーク内容が表示されている' do
    it '「テストユーザー1です」が表示されている' do
      expect(page).to have_content 'テストユーザー1です'
    end
    it '「テストユーザー2です」が表示されている' do
      expect(page).to have_content 'テストユーザー2です'
    end
  end
  context 'トークの削除' do
    it 'リンクが表示されている' do
      messagearea = find('.admin-chat-content')
      expect(messagearea).to have_content '削除'
    end
    it 'トークを削除できる(左サイド)' do
      find('.message-destroy-left').click
      expect(page).to have_no_content 'テストユーザー2です'
    end
    it 'トークを削除できる(右サイド)' do
      find('.message-destroy-right').click
      expect(page).to have_no_content 'テストユーザー1です'
    end
  end
  context 'トークルームの削除' do
    it '削除ボタンが表示されている' do
      roomarea = find('.admin-chat-rooms')
      expect(roomarea).to have_content '削除'
    end
    it '削除できる' do
      find('.btn-danger').click
      expect(current_path).to eq('/admin/end_users/' + test_user_1.id.to_s)
      click_link 'トークルーム'
      expect(page).to have_no_content 'テストユーザー2'
    end
  end
end