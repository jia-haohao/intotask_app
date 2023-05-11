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
  label = Faker::Games::Pokemon.name
  Label.create!(name: label)
end