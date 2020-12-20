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
  describe 'コメントの投稿' do
    it '投稿に成功する', js: true do
      comment.body = Faker::Lorem.characters(number:5)
      click_button '投稿する'
    end

    it '投稿に失敗する', js: true do
      comment.body = ''
      click_button '投稿する'
      expect(page).to have_content 'コメントを入力してください'
    end
  end
end

# hidden_fieldの取得に失敗したので方法を変えた

# describe 'コメントのテスト' do
#   let!(:test_user) { create(:end_user) }
#   let(:test_genre) { create(:genre) }
#   # let(:materials) { build(:material, post_id: test_post.id) }
#   # let(:works) { build(:work, post_id: test_post.id) }
#   let!(:test_post) { create(:post, genre_id: test_genre.id, end_user_id: test_user.id) }
#   # let(:test_comment) { build(:comment, end_user_id: test_user.id, post_id: test_post.id) }
#   before do
#     visit new_end_user_session_path
#     fill_in 'end_user[email]', with: test_user.email
#     fill_in 'end_user[password]', with: test_user.password
#     click_button 'Log in'
#   end
#   describe 'コメントの投稿' do
#     it '投稿に成功する', js: true do
#       fill_in 'comment[body]', with: 'aaaa'
#       # visible: false
#       fill_in 'comment[post_id]', with: test_post.id
#       fill_in 'comment[end_user_id]', with: test_user.id
#       click_button '投稿する' #commit?
#     end
#   end
# end