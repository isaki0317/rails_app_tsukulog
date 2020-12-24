require 'rails_helper'

describe 'コメントのテスト' do
  let(:test_user) { create(:end_user) }
  let(:test_genre) { create(:genre) }
  let!(:test_post) { create(:post, genre_id: test_genre.id, end_user_id: test_user.id) }
  let(:comment) { build(:comment, end_user_id: test_user.id, post_id: test_post.id) }

  before do
    visit new_end_user_session_path
    fill_in 'end_user[email]', with: test_user.email
    fill_in 'end_user[password]', with: test_user.password
    click_button 'Log in'
  end

  describe 'コメントの投稿(一覧画面)' do
    it 'コメント投稿に成功する', js: true do
      fill_in 'comment[body]', with: Faker::Lorem.characters(number: 5)
      click_button '投稿する'
    end

    it 'コメント投稿に失敗する', js: true do
      fill_in 'comment[body]', with: ''
      click_button '投稿する'
      expect(page).to have_content 'コメントを入力してください'
    end
  end

  describe 'コメント(投稿詳細画面)' do
    before do
      visit post_path(test_post)
    end

    it 'コメント投稿に成功する', js: true do
      fill_in 'comment[body]', with: Faker::Lorem.characters(number: 5)
      click_button '投稿する'
    end

    it 'コメント投稿に失敗する', js: true do
      fill_in 'comment[body]', with: ''
      click_button '投稿する'
      expect(page).to have_content 'コメントを入力してください'
    end

    it 'コメント削除に成功する', js: true do
      fill_in 'comment[body]', with: Faker::Lorem.characters(number: 5)
      click_button '投稿する'
      click_link '削除'
      expect(page).to have_content 'コメントはありません...'
    end
  end

  describe '他人のコメント' do
    let(:test_user_2) { create(:end_user) }
    let!(:test_comment) { create(:comment, end_user_id: test_user_2.id, post_id: test_post.id) }
    let!(:test_post_2) { create(:post, genre_id: test_genre.id, end_user_id: test_user_2.id) }

    context '他人の投稿詳細' do
      before do
        visit post_path(test_post_2)
      end

      it '削除リンク表示されない', js: true do
        expect(page).to have_no_content '削除'
      end
    end

    context '自分の投稿' do
      before do
        visit post_path(test_post)
      end

      it '削除リンク表示される', js: true do
        expect(page).to have_content '削除'
      end

      it '削除できる', js: true do
        click_link '削除'
        expect(page).to have_content 'コメントはありません...'
      end
    end
  end
end
