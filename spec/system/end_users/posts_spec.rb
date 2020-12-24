require 'rails_helper'

describe '投稿のテスト' do
  let(:test_user) { create(:end_user) }
  let(:test_user_2) { create(:end_user) }
  let(:test_genre) { create(:genre) }
  let(:test_work) { create(:work, post_id: test_post.id) }
  let!(:test_post) { create(:post, genre_id: test_genre.id, end_user_id: test_user.id) }
  let!(:test_post_2) { create(:post, genre_id: test_genre.id, end_user_id: test_user_2.id) }

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

    context '新規投稿に成功する', js: true do
      it '新規投稿に成功する' do
        fill_in 'post[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'post[subtitle]', with: Faker::Lorem.characters(number: 10)
        find('#user_img', visible: false).set("#{Rails.root}/spec/factories/test.jpg")
        fill_in 'post[materials_attributes][0][material_name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'post[materials_attributes][0][shop]', with: Faker::Lorem.characters(number: 5)
        fill_in 'post[works_attributes][0][detail]', with: Faker::Lorem.characters(number: 20)
        within '#post_genre_id' do
          find("option[value='1']").click
        end
        find('#works_img', visible: false).set("#{Rails.root}/spec/factories/test.jpg")
        click_button '送信'
        post = Post.last
        expect(current_path).to eq('/posts/' + post.id.to_s)
      end

      it '下書きに成功する', js: true do
        fill_in 'post[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'post[subtitle]', with: Faker::Lorem.characters(number: 10)
        find('#user_img', visible: false).set("#{Rails.root}/spec/factories/test.jpg")
        fill_in 'post[materials_attributes][0][material_name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'post[materials_attributes][0][shop]', with: Faker::Lorem.characters(number: 5)
        fill_in 'post[works_attributes][0][detail]', with: Faker::Lorem.characters(number: 20)
        find('#works_img', visible: false).set("#{Rails.root}/spec/factories/test.jpg")
        within '#post_genre_id' do
          find("option[value='1']").click
        end
        within '#post_post_status' do
          find("option[value='false']").click
        end
        click_button '送信'
        post = Post.last
        expect(current_path).to eq('/end_users/' + post.end_user.id.to_s)
      end
    end

    context '投稿に失敗する' do
      it 'titleが空白：投稿に失敗する' do
        fill_in 'post[title]', with: ''
        click_button '送信'
        expect(page).to have_content 'タイトルを入力してください'
      end

      it 'material_nameが空白：投稿に失敗する' do
        test_post
        fill_in 'post[materials_attributes][0][material_name]', with: ''
        click_button '送信'
        expect(page).to have_content '材料名を入力してください'
      end
    end

    context 'Jsのテスト(クリックで追加・削除)' do
      it '材料：タブ追加できる', js: true do
        find('#rspec-add-material').click
        elements = all('.js-material-group')
        expect(elements.size).to eq 2
      end

      xit '材料：タブを削除できる', js: true do
        find('#rspec-add-material').click
        click '削除ボタンが同じ・親のindex番号だけ違う'
      end

      it '工程：タブ追加できる', js: true do
        find('#rspec-add-work').click
        elements = all('.js-work-group')
        expect(elements.size).to eq 2
      end

      xit '工程：タブを削除できる', js: true do
        click 'rspec-add-work'
        click '削除ボタンが同じ・親のindex番号だけ違う'
      end
    end
  end

  describe '投稿詳細：各ボタン・遷移' do
    context '自分の投稿詳細：編集への遷移' do
      it '遷移できる' do
        visit edit_post_path(test_post)
        expect(current_path).to eq('/posts/' + test_post.id.to_s + '/edit')
      end
    end

    context '自分の投稿詳細' do
      before do
        visit post_path(test_post)
      end

      it '編集するボタンが表示される' do
        expect(page).to have_content '編集する'
      end

      it '編集するボタンから遷移' do
        click_link '編集する'
        expect(current_path).to eq('/posts/' + test_post.id.to_s + '/edit')
      end

      it 'twwiteするボタン表示される' do
        expect(page).to have_content 'Twitterに投稿'
      end
    end

    context '他人の投稿詳細' do
      before do
        visit post_path(test_post_2)
      end

      it '編集するボタン表示されない' do
        expect(page).to have_no_content '編集する'
      end

      it '遷移できない(url直打ち)' do
        visit edit_post_path(test_post_2)
        expect(current_path).to eq('/posts')
      end

      it 'twwiteするボタン表示されない' do
        expect(page).to have_no_content 'Twitterに投稿'
      end
    end
  end

  describe 'DIY投稿の編集' do
    before do
      visit edit_post_path(test_post)
    end

    context '編集に成功する' do
      it '編集に成功する', js: true do
        fill_in 'post[title]', with: Faker::Lorem.characters(number: 5)
        click_button '送信'
      end
    end

    context '投稿に失敗する' do
      it '編集に失敗する', js: true do
        fill_in 'post[title]', with: ''
        click_button '送信'
        expect(page).to have_content 'タイトルを入力してください'
      end
    end
  end

  describe '投稿の削除' do
    context '自分の投稿の削除' do
      before do
        visit post_path(test_post)
      end

      it '削除に成功する', js: true do
        click_link 'rspec-post-destroy'
      end
    end

    context '他人の投稿の場合' do
      before do
        visit post_path(test_post_2)
      end

      it '削除ボタン表示されない' do
        expect(page).to have_no_content '削除する'
      end
    end
  end
end
