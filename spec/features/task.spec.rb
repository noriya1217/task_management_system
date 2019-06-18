require 'rails_helper'

RSpec.feature 'タスク管理システム', type: :feature do

  scenario 'タスク一覧のテスト' do
    Task.create!(subject: 'test_task_01', content: 'testtesttest')
    Task.create!(subject: 'test_task_02', content: 'samplesample')

    visit tasks_path
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'

  end

  scenario 'タスク作成のテスト' do
    visit new_task_path
    fill_in 'Subject', with: 'タスクの件名を入力する'
    fill_in 'Content', with: 'タスクの内容を入力する'
    # save_and_open_page
    click_button '登録する'
    expect(page).to have_content 'タスクの件名を入力する'
    expect(page).to have_content 'タスクの内容を入力する'

  end

  scenario 'タスク詳細のテスト' do
    Task.create!(subject: 'test_task_show', content: 'test_show_content')

    visit tasks_path
    click_link '詳細'
    expect(page).to have_content 'test_task_show'
    expect(page).to have_content 'test_show_content'
  end

  scenario 'タスク編集のテスト' do
    Task.create!(subject: 'test_task_new', content: 'test_new_content')
    visit tasks_path
    click_link '編集'
    fill_in 'Subject', with: 'test_task_edit'
    fill_in 'Content', with: 'test_edit_content'
    click_button '更新する'

    expect(page).to have_content 'test_task_edit'
    expect(page).to have_content 'test_edit_content'
  end

  scenario 'タスク削除のテスト' do
    Task.create!(subject: 'test_task_destroy', content: 'test_destroy_content')
    visit tasks_path
    click_link '削除'
    expect(page).to have_no_content 'test_task_destroy'
    expect(page).to have_no_content 'test_destroy_content'
  end

end