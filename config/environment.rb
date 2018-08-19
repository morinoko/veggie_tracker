ENV['SINATRA_ENV'] ||= "development"
ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

# ActiveRecord::Base.establish_connection(
# 	:adapter => "sqlite3",
# 	:database => "db/#{ENV['SINATRA_ENV']}.sqlite"
# )

set :database_file, 'database.yml'

require_all 'app'
