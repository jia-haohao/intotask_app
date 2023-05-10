FactoryBot.define do
  factory :user do
    name { "test" }
    email { "test@example.com" }
    password { "password" }
    # password_confirmation { "password" }
    admin { false }
  end
  factory :admin_user, class: User do
    name { "admin" }
    email { "admin@example.com" }
    password { "password" }
    # password_confirmation { "password" }
    admin { true }
  end
end
