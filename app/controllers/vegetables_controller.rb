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
    params[:planting_season] = params[:planting_season].join(" ")
    @vegetable = Vegetable.new(params)
    @vegetable.save
    
    redirect to "/users/#{current_user.slug}"
  end
  
  get '/vegetables/:id' do
    @vegetable = Vegetable.find_by(id: params[:id])
    
    erb :'vegetables/show'
  end
  
end