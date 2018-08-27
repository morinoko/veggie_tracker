require 'rack-flash'
require 'date'

class ApplicationController < Sinatra::Base
	
	configure do
		set :views, 'app/views'
		set :public_dir, 'public'
		enable :sessions
		set :session_secret, 'yasai'
		use Rack::Flash, :sweep => true
	end
	
	get '/' do
  	if logged_in?
    	@user = current_user
    end
    
		erb :index
	end
	
	helpers do
		def current_user
			@current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
		end
		
		def logged_in?
			!!current_user
		end
	end
end