FactoryBot.define do
  factory :user do
    email { "no.admin@gmail.com" }
    password { "no.admin" }
    firstname { " " }
    lastname { "" }
    admin { false }
  end

  # factory :user do
  #   email { "no.admin@gmail.com" }
  #   password { "password" }
  #   admin {false}
  # end

  factory :user_admin, class: User do
    email { "admin@gmail.com" }
    password { "password" }
    firstname { "Admin" }
    admin { true }
  end


end
