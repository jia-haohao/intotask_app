User.create!(name:  "管理者",
            email: "admin@example.com",
            password:  "abcdef",
            password_confirmation: "abcdef",
            admin: true)

10.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               )
end

10.times do |n|
  title = "task_#{n}"
  content = "content_#{n}"
  status = Task.statuses.keys.sample
  priority = 1
  deadline = "2021-11-13"
  user_id = User.all.sample.id
  Task.create!(title: title,
                content: content,
                status: status,
                priority: priority,
                deadline: deadline,
                user_id: user_id
  )            
end    

10.times do |n|
  label = Faker::Name.name
  Label.create!(name: label)
end

# 10.times do |n|
#   label = Faker::Games::Pokemon.name
#   Label.create!(name: label)
# end

# 10.times do |n|
#   name = "test#{n}"
#   email = "test#{n}@test.com"
#   password = "password"

#   User.create!(name: name, email: email, password: password, admin:false)
# end

# 10.times do |n|
#   name = "tag#{n}"

#   Tag.create!(name: name)
# end

# 100.times do |n|
#   title = "タスク#{n}"
#   content = "タスクの内容#{n}"
#   priority = rand(1..3)
#   status = rand(1..3)
#   expired_at = DateTime.new(2021,5, rand(1..30) )
#   user_id = rand(2..10)

#   Task.create!(title: title, content: content, priority: priority, status: status, expired_at: expired_at, user_id: user_id)
# end

# taggings_list = []
# Task.all.ids.each do |task_id|
#   taggings_list << { task_id: task_id, tag_id: rand(1..10) }
# end
# Tagging.create!(taggings_list)
end
