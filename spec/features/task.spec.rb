require 'rails_helper'

RSpec.feature 'タスク管理システム', type: :feature do

  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end

  scenario 'タスク一覧のテスト' do
    visit tasks_path
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'
  end

  scenario 'タスク作成のテスト' do
    visit new_task_path
    fill_in 'Subject', with: 'タスクの件名を入力する'
    fill_in 'Content', with: 'タスクの内容を入力する'

    click_button '登録する'
    expect(page).to have_content 'タスクの件名を入力する'
    expect(page).to have_content 'タスクの内容を入力する'

  end

  scenario 'タスク詳細のテスト' do
    visit tasks_path
    all('tr')[1].click_link '詳細'
    expect(page).to have_content 'samplesample'
  end

  scenario 'タスク編集のテスト' do
    visit tasks_path
    all('tr')[1].click_link '編集'
    fill_in 'Subject', with: 'test_task_edit'
    fill_in 'Content', with: 'test_edit_content'
    click_button '更新する'

    expect(page).to have_content 'test_task_edit'
    expect(page).to have_content 'test_edit_content'
  end

  scenario 'タスク削除のテスト' do
    visit tasks_path
    all('tr')[1].click_link '削除'
    expect(page).to have_no_content 'test_task_02'
    expect(page).to have_no_content 'samplesample'
  end

  scenario 'タスクが作成日時の降順に並んでいるかのテスト' do
    visit tasks_path
    # save_and_open_page
    trs = page.all('tr')
    # テーブル最初の行には、'Subject'と'Content'が入っているため、最初のレコードが入るのは2行目から
    expect(trs[1]).to have_content 'test_task_02'
    expect(trs[1]).to have_content 'samplesample'
  end

end