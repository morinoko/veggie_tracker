class FarmsController < ApplicationController
  
  get '/farms/new' do
    if logged_in?
      erb :'farms/new'
    else
      flash[:notice] = "You need to be logged in to do that!"
      
      redirect to "/login"
    end
  end
  
  post '/farm' do
    
  end
  
  get '/farms/:slug' do
    @farm = Farm.find_by_slug(params[:slug])
    
    erb :'farms/show'
  end
end
