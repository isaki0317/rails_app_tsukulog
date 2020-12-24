require 'rails_helper'

describe 'チャット管理側のテスト' do
  let(:admin) { create(:admin) }

  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'Log in'
    visit admin_genres_path
  end
  
  context ''
end