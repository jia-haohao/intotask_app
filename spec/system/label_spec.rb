require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, title: 'task', status: '着手', priority: '高', user: user ) }
  let!(:label_1) { FactoryBot.create(:label_1) }
  let!(:label_2) { FactoryBot.create(:label_2) }
  describe 'ラベル機能' do 
    before do 
      visit tasks_path
      fill_in 'session[email]', with: 'test@example.com'
      fill_in 'session[password]', with: 'password'
      click_button 'ログイン'
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '貼られているラベルの内容が表示される' do
        visit tasks_path
        click_on '詳細'
        expect(page).to have_content 'ラベル１'
      end
    end
    context 'タスクを新規作成する場合' do
      it 'タスクにラベルを貼ることができる' do
        visit new_task_path
        fill_in "task_title", with: 'task'
        fill_in "task_content", with: 'content'
        select '低', from: 'task_priority'
        select '完了', from: 'task_status'
        select '2022',from: 'task_deadline_1i'
        select '11',from: 'task_deadline_2i'
        select '3',from: 'task_deadline_3i'
        check 'ラベル２'
        click_on '登録する'
        click_on '登録する'
        task_list = all('.task_all').first
        task_list.click_on '詳細'
        expect(page).to have_content 'ラベル２'
      end
      it 'タスクにラベルを複数貼ることができる' do
        visit new_task_path
        fill_in "task_title", with: 'task'
        fill_in "task_content", with: 'content'
        select '低', from: 'task_priority'
        select '完了', from: 'task_status'
        select '2022',from: 'task_deadline_1i'
        select '11',from: 'task_deadline_2i'
        select '3',from: 'task_deadline_3i'
        check 'ラベル２'
        click_on '登録する'
        click_on '登録する'
        task_list = all('.task_all').first
        task_list.click_on '詳細'
        expect(page).to have_content 'ラベル１'
        expect(page).to have_content 'ラベル２'
      end
    end
    context 'タスクを編集する場合' do
      it 'ラベルを変更できる' do
        visit tasks_path
        click_on '編集'
        check 'ラベル２'
        click_on '更新する'
        expect(page).to have_content 'ラベル２'
      end
    end

    context 'ラベルで検索した場合' do
      it 'ラベルを含むタスクで絞り込まれる' do
        visit tasks_path
        select "ラベル１", from: 'ラベル検索'
        click_on '検索'
        task_list = all('.task_all')
        expect(page).to have_content 'ラベル１'
      end
    end
  end
end