# README

# bundle install --path vendor/bundle
# Model: Task

* id : integer

* task_name : string

* task_details : text

# How to deploy this App to heroku ?
1. Gem version : 3.2.28
2. Execute heroku create Appname
3. execute rails assets:precompile RAILS_ENV=production (compile the assets)
4. git add -A
5. git commit -m "init for deploying to heroku app"
6. Execute heroku buildpacks:set heroku/ruby
7. Execute heroku buildpacks:add --index 1 heroku/nodejs
8. git push heroku step2:master (if you have an error, comment the ruby version in your gemfile and start from 2 to 10)
9. heroku run rails db:migrate     'for db migration'
10. heroku open 'to access the app'
