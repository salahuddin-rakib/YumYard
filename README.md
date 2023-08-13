# README

These steps needs to follow to run and operate this project. 

Things you need to follow:

## 1. Installation:
****
** You can skip this part if you already have ruby 3.2.2 and rails 7 installed in you machine. ** 

You need to install ruby programming language, Ruby on Rails and Postgresql Database.
For windows pc you can follow https://gorails.com/setup/windows/11. For ubuntu pc you
can follow https://gorails.com/setup/ubuntu/22.04. For macOS you can follow
https://gorails.com/setup/macos/13-ventura. Note: You have to install ruby 3.2.2 and rails
7 version for this project. You also need to configure postgresql to make it runnable.
****

## 2. Configuration:
****

### 2.1 Server running port configuration:
****

** You can skip this part if you don't want to change rails server running port. **

When we will run rails server by default it will run on 4000 post. You can change port by following these steps. 
* Go to `./YumYard/config/puma.rb` file.
* See there is a line `port ENV.fetch("PORT") { 4000 }`. Change `port ENV.fetch("PORT") { 4000 }`
  to `port ENV.fetch("PORT") { your_specific_port_number }`.
****

### 2.2 Configuration for database:
****
You need to create a super admin in postgres. Then:
* Go to `./YumYard/config/database.yml` file.
* Change `your_postgresql_username` and `your_postgresql_password` with your postgres super admin `username` and `password`.
****
****

## 3. Database creation:
****
Go to the project folder(`YumYard`) in terminal. After that run `rails db:create:all` command.
****

## 3. Run rails server:
****
Go to the project folder(`YumYard`) in terminal. After that run `rails s` command. That's it, your rails server will run.
****

## 4. Run test suite:
****
To run test suite just run `rspec spec` in the project folder terminal.
****
