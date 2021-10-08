# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require 'faker'
# User.create!(
    #     name: "tom",
    #     email: "tom@gmail.com",
    #     name: "admin",
    #     email: "admin@admin.com",
    #     password: "123456",
    #     admin: true
    # )

User.create(
    username: "Love",
    email:"admin@gmail.com", 
    password:"GrandAdmin",
    password_confirmation:"GrandAdmin", 
    admin: true
)
# status = ['Unstarted', 'In progress', 'Completed']

# 5.times do |n|
#     User.create(
#         email: Faker::Internet.unique.email,
#         password: "password",
#         password_confirmation: "password"
#     )
# end

@taskss=Task.where(user_id: nil)
@taskss.each do |e|
e.update(user_id:1)
end

# Alphabet phonétique de l'OTAN
Label.create(label_name: 'Equipe Alpha')
Label.create(label_name: 'Equipe Bravo')
Label.create(label_name: 'Equipe Charlie')
Label.create(label_name: 'Equipe Delta')
Label.create(label_name: 'Equipe Echo')
Label.create(label_name: 'Equipe Foxtrot')
Label.create(label_name: 'Equipe Lima')
Label.create(label_name: 'Equipe Tango')





# 12.times do |n| 
#     Task.create(
#         task_name: Faker::Lorem.unique.word,
#         task_details: Faker::Lorem.sentence(word_count: 8),
#         status: status[Faker::Number.between(from: 0, to: 2)],
#         deadline: Faker::Date.between(from: '2021-10-06', to: '2021-12-31'),
#         priority: Faker::Number.between(from: 1, to: 3),
#         user_id: Faker::Number.between(from: 1, to: 6)
#     )
# end


