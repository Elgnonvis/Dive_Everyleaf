FactoryBot.define do
  factory :user do
    username { "Not Admin" }
    email { "no.admin@gmail.com" }
    password { "no.admin" }
    # admin { false }
  end

  factory :user2, class: User do
    username { "Allow" }
    email { "no.admin2@gmail.com" }
    password { "no.admin" }
    # admin { false }
  end

  factory :user_admin, class: User do
    username { "Star" }
    email { "admin@gmail.com" }
    password { "password" }
    admin { true }
  end

end
