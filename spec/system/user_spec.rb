require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'ユーザ登録のテスト' do
    context 'ログインしていないユーザがタスク一覧画面にアクセスした場合' do
      it 'ログイン画面に遷移すること' do
        visit tasks_path
        expect(page).to have_content 'Log in'
      end
    end
    context 'ユーザが新規登録した場合' do
      it '新規登録ができること' do
        visit new_user_path
        fill_in '名前', with: 'test_user'
        fill_in 'メールアドレス', with: 'test_user@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_button 'Create my account'
        expect(page).to have_content 'タスク一覧'
      end
    end   

    it '管理者はユーザを新規登録できること' do
      visit new_user_path
      fill_in '名前', with: 'admin'
      fill_in 'メールアドレス', with: 'admin@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in '確認用パスワード', with: 'password'
      click_on 'Create my account'
      expect(page).to have_content 'タスク一覧'
    end
  end

  describe 'セッション機能のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:admin_user) { FactoryBot.create(:admin_user) }
    before do
      visit new_session_path
      fill_in 'session[email]', with: 'test@example.com'
      fill_in 'session[password]', with: 'password'
      click_button 'ログイン'
    end

    context 'ログインした場合' do
      it 'ログイン情報を入力してログインボタンを押したらタスク一覧画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'タスク一覧'
      end

      it '自分の詳細画面(マイページ)にアクセスできること' do
        visit user_path(user.id)
        expect(page).to have_content 'test'
      end

      it '一般ユーザが他人の詳細画面にアクセスした場合、タスク一覧画面に遷移すること' do
        number = user.id + 1
        visit tasks_path
        visit user_path(number)
        expect(page).to have_content 'タスク'
      end

      it '一般ユーザは管理画面にアクセスできないこと' do
        visit admin_users_path
        expect(current_path).to eq root_path
      end

      it 'ログアウトができること' do
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました!'
      end
    end
  end

  describe '管理者機能のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:admin_user) { FactoryBot.create(:admin_user) }
    before do
      visit new_session_path
      fill_in 'session[email]', with:'admin@example.com'
      fill_in 'session[password]', with: 'password'
      click_button 'ログイン'
    end
    context '管理ユーザでログインした場合' do
      it '管理画面にアクセスできること' do
        visit admin_users_path
        expect(page).to have_content 'ユーザー管理画面'
      end

      it '管理者はユーザの詳細画面にアクセスできること' do
        visit admin_user_path(user)
        expect(page).to have_content 'test'
      end

      it '管理者はユーザの編集画面からユーザを編集できること' do
        visit edit_admin_user_path(user)
        fill_in '名前', with: 'text-rename'
        click_button '登録する'
        expect(page).to have_content 'text-rename'
      end

      it '管理者はユーザの削除をできること' do
        click_on '管理画面'
        user_list = all('.user_row')
        user_list[1].click_on '削除'
        # page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'test'
      end
    end
  end
end

      
