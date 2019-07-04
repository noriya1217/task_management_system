require 'rails_helper'

RSpec.feature 'タスク管理システム(error)', type: :feature do

  background do
    page.driver.browser.authorize('hoge', 'piyo')
    visit root_path
  end

  scenario '404ページを表示するテスト' do
    visit '/tasks/404test'
    expect(page).to have_content '404 not found'
    expect(page.status_code).to eq 404
  end
  
  scenario '500ページを表示するテスト' do
    allow_any_instance_of(TasksController).to receive(:index).and_throw(Exception)
    FactoryBot.create(:user)
    fill_in 'session_email', with: 'hoge@example.com'
    fill_in 'session_password', with: 'password'
    fill_in 'session_password_confirmation', with: 'password'
    click_button 'ログイン'
    expect(page).to have_content '500 Internal Server Error'
    expect(page.status_code).to equal(500)
  end

  scenario 'admin/errorページを表示するテスト' do
    FactoryBot.create(:user)
    fill_in 'session_email', with: 'hoge@example.com'
    fill_in 'session_password', with: 'password'
    fill_in 'session_password_confirmation', with: 'password'
    click_button 'ログイン'
    visit admin_users_path
    expect(page).to have_content '管理者権限のないユーザーからアクセスがありました。'
  end
end