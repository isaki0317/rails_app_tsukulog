require 'rails_helper'

# マイページでのフォロー解除・申請者に対するフォローのテストも時間あれば記述
describe '通知のテスト' do
  # 通知を送る側
  let!(:test_user_1) { create(:end_user, name: 'ユーザー1') }
  # 通知を送られる側
  let!(:test_user_2) { create(:end_user, name: 'ユーザー2') }
  # 通知を送られる側の作成した投稿
  let!(:test_post) { create(:post, end_user_id: test_user_2.id) }
  # 通知を送る側が上記投稿にコメント、いいね
  let!(:test_favorite) { create(:favorite, post_id: test_post.id, end_user_id: test_user_1.id) }
  let!(:test_comment) { create(:comment, end_user_id: test_user_1.id, post_id: test_post.id) }
  # 通知のためのchatを定義
  let(:room) { create(:room) }
  let!(:user_room_1) { create(:user_room, room_id: room.id, end_user_id: test_user_1.id) }
  let!(:user_room_2) { create(:user_room, room_id: room.id, end_user_id: test_user_2.id) }
  let(:test_chat) { create(:chat, end_user_id: test_user_1.id, room_id: room.id, message: 'こんにちわ') }

  before do
    visit new_end_user_session_path
    fill_in 'end_user[email]', with: test_user_2.email
    fill_in 'end_user[password]', with: test_user_2.password
    click_button 'Log in'
  end
  context 'いいね！通知のテスト' do
    before do
      FactoryBot.create(:notification, visitor_id: test_user_1.id, visited_id: test_user_2.id, post_id: test_post.id, action: 'favorite')
    end
    it 'いいねの通知が来ている' do
      visit notifications_path
      expect(page).to have_content 'ユーザー1があなたの投稿にいいね！しました'
    end
    it 'いいねされた投稿へ通知のリンクから遷移' do
      visit notifications_path
      click_link 'あなたの投稿'
      expect(current_path).to eq('/posts/' + test_post.id.to_s)
    end
    it '通知したユーザーへリンクから遷移', js: true do
      visit notifications_path
      click_link 'ユーザー1'
      expect(current_path).to eq('/end_users/' + test_user_1.id.to_s)
    end
  end

  context 'コメントの通知テスト' do
    before do
      FactoryBot.create(:notification, visitor_id: test_user_1.id, visited_id: test_user_2.id, post_id: test_post.id, comment_id: test_comment.id, action: 'comment')
    end
    it 'コメントの通知が来ている' do
      visit notifications_path
      expect(page).to have_content 'ユーザー1があなたの投稿にコメントしました'
    end
    it 'コメントされた投稿へリンクから遷移&コメント確認' do
      visit notifications_path
      click_link 'あなたの投稿'
      expect(current_path).to eq('/posts/' + test_post.id.to_s)
      expect(page).to have_content 'ユーザー1'
    end
    it '通知したユーザーへリンクから遷移', js: true do
      visit notifications_path
      click_link 'ユーザー1'
      expect(current_path).to eq('/end_users/' + test_user_1.id.to_s)
    end
  end

  context 'フォローの通知' do
    before do
      FactoryBot.create(:relationship, following_id: test_user_1.id, follower_id: test_user_2.id)
      FactoryBot.create(:notification, visitor_id: test_user_1.id, visited_id: test_user_2.id, action: 'follow')
    end
    it 'フォローの通知が来ている' do
      visit notifications_path
      expect(page).to have_content 'ユーザー1があなたをフォローしました'
    end
    it '通知したユーザーへリンクから遷移', js: true do
      visit notifications_path
      click_link 'ユーザー1'
      expect(current_path).to eq('/end_users/' + test_user_1.id.to_s)
    end
  end

  context 'DMの通知' do
    before do
      FactoryBot.create(:notification, visitor_id: test_user_1.id, visited_id: test_user_2.id, room_id: room.id, chat_id: test_chat.id, action: 'dm')
    end
    it 'dmの通知が来ている' do
      visit notifications_path
      expect(page).to have_content 'ユーザー1からDMが届いてます'
    end
    it 'リンクから該当のdmページへ遷移&送信内容の確認' do
      visit notifications_path
      click_link 'DM'
      expect(current_path).to eq('/chats/' + test_user_1.id.to_s)
      expect(page).to have_content 'こんにちわ'
    end
    it '通知したユーザーへリンクから遷移', js: true do
      visit notifications_path
      click_link 'ユーザー1'
      expect(current_path).to eq('/end_users/' + test_user_1.id.to_s)
    end
  end
end