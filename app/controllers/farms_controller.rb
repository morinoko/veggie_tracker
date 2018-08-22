class FarmsController < ApplicationController
  
  get '/farms/new' do
    if logged_in?
      erb :'farms/new'
    else
      flash[:notice] = "You need to be logged in to do that!"
      
      redirect to "/login"
    end
  end
  
  post '/farms' do
    @farm = Farm.new(name: params[:name], location: params[:location])
    
    if @farm.save
      @farm.user = current_user
      @farm.save
      
      redirect to "/farms/#{@farm.slug}"
    else
      flash[:notice] = "Please fill in all the fields."
      
      redirect to '/farms/new'
    end
  end
  
  get '/farms/:slug' do
    @farm = Farm.find_by_slug(params[:slug])
    
    erb :'farms/show'
  end
  
  patch '/farms/:slug' do
    @farm = Farm.find_by_slug(params[:slug])
    
    @farm.update(name: params[:name], location: params[:location])
    
    redirect to "/farms/#{@farm.slug}"
  end
  
  get '/farms/:slug/edit' do
    @farm = Farm.find_by_slug(params[:slug])
    
    if logged_in? && current_user == @farm.user
      erb :'farms/edit'
    else
      redirect to '/'
    end
  end
  
end
