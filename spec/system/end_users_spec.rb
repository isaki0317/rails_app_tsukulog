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

  describe 'マイページのテスト' do
    context 'プロフィール編集に関するテスト' do
      before do
        visit end_user_path(test_user)
      end

      it 'プロフィールを編集ボタンがある' do
        expect(page).to have_content 'プロフィールを編集'
      end

      it '遷移できる' do
        click_link 'プロフィールを編集'
        expect(current_path).to eq('/end_users/' + test_user.id.to_s + '/edit')
      end
    end

    context '他人の編集画面へ遷移' do
      it '遷移できない' do
        visit edit_end_user_path(test_user_2)
        expect(current_path).to eq('/posts')
      end
    end

    context 'ボタン各種の確認' do
      before do
        visit end_user_path(test_user)
      end

      it 'ブロック一覧ボタンがある' do
        expect(page).to have_content 'ブロック一覧'
      end

      it 'ブロック一覧へ遷移できる' do
        click_link 'ブロック一覧'
        expect(current_path).to eq('/end_users/blockers')
      end

      it 'お問合せボタンがある' do
        expect(page).to have_content 'お問合せ'
      end

      it 'お問合せボタンを押してモーダルが起動する', js: true do
        click_button 'お問合せ'
        expect(page).to have_content '送信フォーム'
      end

      it 'フォロー申請一覧ボタンがある' do
        expect(page).to have_content 'フォロー申請一覧'
      end

      it 'フォロー申請一覧ボタンを押してモーダルが起動する', js: true do
        click_link '友達'
        click_button 'フォロー申請一覧'
        expect(page).to have_content 'フォロー申請一覧'
      end

      it 'ブロックするボタンがない' do
        expect(page).to have_no_link 'ブロックする'
      end

      it 'メッセージを送るボタンがない' do
        expect(page).to have_no_link 'メッセージを送る'
      end

      it 'フォローボタンが表示されない' do
        expect(page).to have_no_link 'rspec-create-follow'
      end
    end
  end


  describe 'プロフィール編集ページ' do
    before do
      visit edit_end_user_path(test_user)
    end
    context '変更を更新' do

      it '更新できる' do
        fill_in 'end_user[name]', with: Faker::Lorem.characters(number:5)
        click_button '変更する'
        expect(current_path).to eq('/end_users/' + test_user.id.to_s)
      end

      it '更新に失敗する' do
        fill_in 'end_user[name]', with: ''
        click_button '変更する'
        expect(page).to have_content '名前を入力してください'
      end
    end

    context 'サインアウト' do

      it 'サインアウトボタンがある' do
        expect(page).to have_button 'サインアウトする'
      end

      it 'サインアウトボタンを押してモーダルが起動する', js: true do
        click_button 'サインアウトする'
        expect(page).to have_content '確認事項'
      end

      # it 'サインアウトできる(論理削除)', js: true do
      #   click_button 'サインアウトする'
      #   click_link 'サインアウト'
      #   expect(page).to have_content 'DIYを通じてあなたの心と生活を豊かに'
      # end
    end
  end

  describe '他人のマイページのテスト' do
    before do
      visit end_user_path(test_user_2)
    end

    context 'フォローボタン' do
      it 'フォローボタンがある' do
        expect(page).to have_link 'rspec-create-follow'
      end
    end

    context 'メッセージを送るボタン' do
      it 'メッセージを送るがある' do
        expect(page).to have_link 'メッセージを送る'
      end
    end

    context 'ブロックするボタン' do
      it 'ブロックするボタンがある' do
        expect(page).to have_link 'ブロックする'
      end
    end

    context '下書きタブ' do
      it '下書きタブがない' do
        expect(page).to have_no_link '下書き'
      end
    end
  end
end