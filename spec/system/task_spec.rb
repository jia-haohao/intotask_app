require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task_title", with: 'task'
        fill_in "task_content", with: '卒業発表会'
        click_on 'Create Task'
        expect(page).to have_content 'task'
        expect(page).to have_content '卒業発表会'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '登録済みのタスク一覧が表示される' do
        FactoryBot.create(:task, title: 'タイトル',  content: '書類作成')
        visit tasks_path
        expect(page).to have_content '書類作成'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        @task = FactoryBot.create(:task, title: 'task', content: '卒業発表会')
        visit task_path(@task.id)
        expect(page).to have_content '詳細'
      end
    end
  end
end