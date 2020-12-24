require 'rails_helper'

describe 'ジャンル作成のテスト' do
  let(:admin) { create(:admin) }

  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'Log in'
    visit admin_genres_path
  end
  context '有効なジャンル作成' do
    it '成功する', js: true do
      fill_in 'genre[name]', with: 'インテリア'
      within '#genre_is_active' do
        find("option[value='true']").click
      end
      click_button 'rspec-genre-create'
      expect(page).to have_content 'インテリア'
      expect(page).to have_content '有効'
    end
    it '失敗するとエラーが出る', js: true do
      fill_in 'genre[name]', with: ''
      within '#genre_is_active' do
        find("option[value='true']").click
      end
      click_button 'rspec-genre-create'
      expect(page).to have_content 'ジャンルの名前を入力してください'
    end
  end

  context '無効なジャンル作成', js: true do
    it '成功する', js: true do
      fill_in 'genre[name]', with: 'インテリア'
      within '#genre_is_active' do
        find("option[value='false']").click
      end
      click_button 'rspec-genre-create'
      expect(page).to have_content 'インテリア'
      expect(page).to have_content '無効'
    end
    it '失敗するとエラーが出る', js: true do
      fill_in 'genre[name]', with: ''
      within '#genre_is_active' do
        find("option[value='false']").click
      end
      click_button 'rspec-genre-create'
      expect(page).to have_content 'ジャンルの名前を入力してください'
    end
  end
end