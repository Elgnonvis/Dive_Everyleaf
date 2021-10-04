FactoryBot.define do
  factory :user do
    email { "MyString" }
    password_digest { "MyString" }
    firstname { "MyString" }
    lastname { "MyString" }
    admin { false }
  end
end
