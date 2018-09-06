require 'rack-flash'
require 'date'
require 'i18n'
require 'i18n/backend/fallbacks'

class ApplicationController < Sinatra::Base
	
	configure do
		set :views, 'app/views'
		set :public_dir, 'public'
		
		enable :sessions
		set :session_secret, ENV['SESSION_SECRET']
		
		use Rack::Flash, :sweep => true
		
		I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
    I18n.load_path = Dir[File.join('config/locales', '*.yml')]
    I18n.backend.load_translations
    I18n.available_locales = [:en, :ja]
    I18n.default_locale = :en
	end
	
	before '/:locale/*' do
    I18n.locale = params[:locale]
  end
	
	get '/:locale/' do
  	
  	if logged_in?
    	@user = current_user
    	    	
    	redirect to "/#{I18n.locale}/users/#{@user.slug}"
    end
    
		erb :index
	end
	
	get '/' do
  	redirect to "/#{I18n.default_locale}/"
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
		
		def this_month
  		month = Time.now.month
  		I18n.t('date.month_names')[month]
    end
    
    def month_name(month)
      I18n.t('date.month_names')[month]
    end
    
    def next_month_number(month)
      if month == 12
        1
      else
        month + 1
      end
    end
    
    def previous_month_number(month)
      if month == 1
        12
      else
        month - 1
      end
    end
    
    def next_month_name(month)
      if month == 12
        I18n.t('date.month_names')[1]
      else
        I18n.t('date.month_names')[month + 1]
      end
    end
    
    def previous_month_name(month)
      if month == 1
        I18n.t('date.month_names')[12]
      else
        I18n.t('date.month_names')[month - 1]
      end
    end
	end
end