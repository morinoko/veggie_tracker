require 'rack-flash'
require 'date'
require 'i18n'
require 'i18n/backend/fallbacks'

class ApplicationController < Sinatra::Base
	
	configure do
		set :views, 'app/views'
		set :public_dir, 'public'
		
		enable :sessions
		set :session_secret, 'yasai'
		
		use Rack::Flash, :sweep => true
		
		I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
    I18n.load_path = Dir[File.join('config/locales', '*.yml')]
    I18n.backend.load_translations
    I18n.available_locales = [:en, :ja]
	end
	
	before '/:locale/*' do
    I18n.locale       =       params[:locale]
    request.path_info = '/' + params[:splat ][0]
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
		
		def t(*args)
  		I18n.t(*args)
    end
    
    def l(*args)
  		I18n.l(*args)
    end
		
		def find_template(views, name, engine, &block)
      I18n.fallbacks[I18n.locale].each { |locale|
        super(views, "#{name}.#{locale}", engine, &block) }
      super(views, name, engine, &block)
    end
	end
end