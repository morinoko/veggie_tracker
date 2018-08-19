ENV['SINATRA_ENV'] ||= "development"
ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

# ActiveRecord::Base.establish_connection(
# 	:adapter => "sqlite3",
# 	:database => "db/#{ENV['SINATRA_ENV']}.sqlite"
# )

ActiveRecord::Base.establish_connection(
  ENV['DATABASE_URL'] ||  { :adapter => "sqlite3",
                            :database => "db/#{ENV['SINATRA_ENV']}.sqlite" }
)

require_all 'app'
