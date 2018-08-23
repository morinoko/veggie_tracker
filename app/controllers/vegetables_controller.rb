require 'date'

class VegetablesController < ApplicationController
  
  get '/vegetables/new' do
    if logged_in?
      @user = current_user
      
      erb :'vegetables/new'
    else
     flash[:notice] = "You need to be logged in to do that!"
     
     redirect to '/login'
    end
  end
  
  post '/vegetables' do
    
  end
  
end