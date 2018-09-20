# frozen_string_literal: true

source 'https://rubygems.org'

gem 'sinatra'
gem 'activerecord'
gem 'sinatra-activerecord'
gem 'rake'
gem 'shotgun'
gem 'bcrypt'
gem 'rack-flash3'
gem 'require_all'
gem 'pry'
gem 'tux'
gem 'i18n'
gem 'dotenv'

group :development, :test do
  gem 'rubocop', '~> 0.58', require: false
  gem 'rubocop-rspec', '~> 1.28', require: false
  gem 'sqlite3'
end

group :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'capybara'
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
end
