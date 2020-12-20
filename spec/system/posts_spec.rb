require 'rails_helper'

describe '投稿のテスト' do
  let(:test_user) { create(:end_user) }
  let(:test_genre) { create(:genre) }
  let!(:test_post) { create(:post, genre_id: test_genre.id, end_user_id: test_user.id) }
  before do
    visit new_end_user_session_path
    fill_in 'end_user[email]', with: test_user.email
    fill_in 'end_user[password]', with: test_user.password
    click_button 'Log in'
  end

  describe 'DIYの新規投稿' do
    before do
      visit new_post_path
      click_link 'new-post-link'
    end
    it '新規投稿に成功する' do
      test_post.title = Faker::Lorem.characters(number:5)
      test_post.subtitle = Faker::Lorem.characters(number:10)
      test_post.images = File.new("#{Rails.root}/spec/factories/test.jpg")
      click_button '送信'
    end

    it '新規投稿に失敗する' do
      test_post.title = ''
      test_post.subtitle = Faker::Lorem.characters(number:10)
      test_post.images = File.new("#{Rails.root}/spec/factories/test.jpg")
      click_button '送信'
      expect(page).to have_content 'タイトルを入力してください'
    end
  end

  describe 'DIY投稿の編集' do
    before do
      visit edit_post_path(test_post)
    end

    it '編集に成功する', js: true do
      fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
      click_button '送信'
    end

    it '編集に失敗する', js: true do
      fill_in 'post[title]', with: ''
      click_button '送信'
      expect(page).to have_content 'タイトルを入力してください'
    end
  end
end