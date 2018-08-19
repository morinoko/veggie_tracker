# frozen_string_literal: true
source "https://rubygems.org"

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

group :development, :test do
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
