require 'rails_helper'

describe 'お問合せのテスト' do
  let(:test_user) { create(:end_user) }

  before do
    visit new_end_user_session_path
    fill_in 'end_user[email]', with: test_user.email
    fill_in 'end_user[password]', with: test_user.password
    click_button 'Log in'
    visit end_user_path(test_user)
  end

  it 'お問合せに成功する', js: true do
    click_button 'お問合せ'
    fill_in 'contact[title]', with: Faker::Lorem.characters(number: 5)
    fill_in 'contact[body]', with: Faker::Lorem.characters(number: 20)
    click_button '送信'
  end

  it 'お問合せに失敗する', js: true do
    click_button 'お問合せ'
    fill_in 'contact[title]', with: ''
    fill_in 'contact[body]', with: Faker::Lorem.characters(number: 20)
    click_button '送信'
    expect(page).to have_content 'タイトルを入力してください'
  end
end
