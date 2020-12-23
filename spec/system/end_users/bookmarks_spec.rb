require 'rails_helper'

describe 'ブックマークのテスト' do
  let(:test_user) { create(:end_user) }
  let(:test_genre) { create(:genre) }
  let!(:test_post) { create(:post, end_user_id: test_user.id, genre_id: test_genre.id) }
  before do
    visit new_end_user_session_path
    fill_in 'end_user[email]', with: test_user.email
    fill_in 'end_user[password]', with: test_user.password
    click_button 'Log in'
  end
  describe 'ブックマークのテスト(一覧画面)' do
    it 'ブックマークに成功する', js: true do
      click_link 'rspec-bookmark-create'
    end

    it 'ブックマークの解除', js: true do
      click_link 'rspec-bookmark-create'
      click_link 'rspec-bookmark-destroy'
    end
  end

  describe 'ブックマークのテスト(投稿詳細)' do
    before do
      visit post_path(test_post)
    end

    it 'ブックマークに成功する', js: true do
      click_link 'rspec-bookmark-create'
    end

    it 'ブックマークの解除', js: true do
      click_link 'rspec-bookmark-create'
      click_link 'rspec-bookmark-destroy'
    end
  end
end