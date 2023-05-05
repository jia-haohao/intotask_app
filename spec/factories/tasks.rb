# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    title { 'task_title' }
    content { 'task_content' }
    # priority { 'task_priority' }
    # status { 'task_status' }
    # deadline { 'task_deadline' }
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title { 'task_title1' }
    content { 'task_content1' }
    # priority { 2 }
  #   status { '着手' }
  #   deadline { '2013-5-30' }
  end
end