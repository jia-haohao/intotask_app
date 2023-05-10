require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  before do
    visit new_session_path
    fill_in 'session[email]', with: 'test@example.com'
    fill_in 'session[password]', with: 'password'
    click_button 'ログイン'
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task_title", with: 'task'
        fill_in "task_content", with: '卒業発表会'
        select '低', from: 'task_priority'
        select '完了', from: 'task_status'
        select '2022',from: 'task_deadline_1i'
        select '11',from: 'task_deadline_2i'
        select '3',from: 'task_deadline_3i'
        click_on '登録する'
        expect(page).to have_content 'task'
        expect(page).to have_content '卒業発表会'
        expect(page).to have_content '低'
        expect(page).to have_content '完了'
        expect(page).to have_content '2022'
        expect(page).to have_content '11'
        expect(page).to have_content '3'
      end
    end
  end
  
    before do
      FactoryBot.create(:task, title: "task", user: user)
      FactoryBot.create(:second_task, title: "task2", user: user)
    end
    describe '優先順位での並び変え' do
      context '優先順位でソートするボタンを押した場合' do
        it '優先順位の昇順で表示される' do
          visit tasks_path
          click_on '優先度'
          sleep 0.5
          task_list = all('.task_row')
          expect(task_list[0]).to have_content '高'
          expect(task_list[1]).to have_content '高'
        end
      end
    end

    context '終了期限でソートするボタンを押した場合' do
      it '終了期限の降順で表示される' do
        visit tasks_path
        click_on '終了期限'
        sleep 0.5
        task_list = all('.task_limit')
        expect(task_list[0]).to have_content '2020-04-02'
        expect(task_list[1]).to have_content '2020-04-01'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        # binding.pry
        task_list = all('.task_li')
        expect(task_list[0]).to have_content 'task2'
        expect(task_list[1]).to have_content 'task'
      end
    end

    describe '検索機能' do
      context 'タイトルであいまい検索をした場合' do
        it "検索キーワードを含むタスクで絞り込まれる" do
          visit tasks_path
          click_on '検索'
          expect(page).to have_content 'task'
        end
      end
      context 'ステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          visit tasks_path
          select '未着手', from: '検索'
          expect(page).to have_select('検索', selected: '未着手')
        end
      end
      context 'タイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          visit tasks_path
          # binding.pry
          fill_in "検索", with: 'task2'
          select '着手', from: '検索'
          click_on '検索'
          expect(page).to have_select('検索', selected: '着手')
        end
      end
    end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '登録済みのタスク一覧が表示される' do
        FactoryBot.create(:task, title: 'タイトル',  content: '書類作成', user: user)
        visit tasks_path
        expect(page).to have_content '書類作成'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        @task = FactoryBot.create(:task, title: 'task', content: '卒業発表会', user: user)
        visit task_path(@task.id)
        expect(page).to have_content '詳細'
      end
    end
  end
end