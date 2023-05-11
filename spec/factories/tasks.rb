FactoryBot.define do
  factory :task do
    title { 'task1' }
    content { 'content１' }
    deadline { '2020-04-01'}
    priority { '高' }
    status {'完了'}
  
  end
  factory :second_task, class: Task do
    title { 'task2' }
    content { 'content2' }
    deadline { '2020-04-02'}
    priority { '中' }
    status {'完了'}
    # user
  end
  factory :third_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル3' }
    content { 'Factoryで作ったデフォルトのコンテント3' }
    deadline { DateTime.now + 2 }
    priority { '低' }
    status { '完了' }
    # user
  end
end
