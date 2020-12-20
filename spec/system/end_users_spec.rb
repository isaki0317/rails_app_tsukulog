require 'rails_helper'

describe 'ユーザーの認証のテスト' do
  describe 'ユーザーの新規登録' do
    before do
      visit new_end_user_registration_path
    end
    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        fill_in 'end_user[name]', with: Faker::Lorem.characters(number:5)
        fill_in 'end_user[email]', with: Faker::Internet.email
        fill_in 'end_user[password]', with: 'password'
        fill_in 'end_user[password_confirmation]', with: 'password'
        click_button 'Sign up'
      end

      it '新規登録に失敗する' do
        fill_in 'end_user[name]', with: ''
        fill_in 'end_user[email]', with: ''
        fill_in 'end_user[password]', with: 'password'
        fill_in 'end_user[password_confirmation]', with: 'password'
        click_button 'Sign up'
      end
    end
  end

  describe 'ユーザーログイン' do
    let(:end_user) { create(:end_user) }
    before do
      visit new_end_user_session_path
    end
    context 'ログイン画面に遷移' do
      let(:test_user) { end_user }
      it 'ログインに成功する' do
        fill_in 'end_user[email]', with: test_user.email
        fill_in 'end_user[password]', with: test_user.password
        click_button 'Log in'
      end

      it 'ログインに失敗する' do
        fill_in 'end_user[email]', with: ''
        fill_in 'end_user[password]', with: ''
        click_button 'Log in'
      end
    end
  end
end

describe 'ユーザーのテスト' do
  let(:test_user) { create(:end_user) }
  let(:test_user_2) { create(:end_user) }

  before do
    visit new_end_user_session_path
    fill_in 'end_user[email]', with: test_user.email
    fill_in 'end_user[password]', with: test_user.password
    click_button 'Log in'
  end

  describe 'プロフィール編集への遷移テスト' do
    context '自分の編集画面への遷移' do
      it '遷移できる' do
        visit edit_end_user_path(test_user)
        expect(current_path).to eq('/end_users/' + test_user.id.to_s + '/edit')
      end
    end

    context '他人の編集画面へ遷移' do
      it '遷移できない' do
        visit edit_end_user_path(test_user_2)
        expect(current_path).to eq('/posts')
      end
    end
  end
end