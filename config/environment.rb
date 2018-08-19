ENV['SINATRA_ENV'] ||= "development"
ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

# ActiveRecord::Base.establish_connection(
# 	:adapter => "sqlite3",
# 	:database => "db/#{ENV['SINATRA_ENV']}.sqlite"
# )

#set :database_file, 'database.yml'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || "db/#{ENV['SINATRA_ENV']}.sqlite")


require_all 'app'
