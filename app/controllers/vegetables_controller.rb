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
  
  patch '/vegetables/:id' do
    params[:vegetable][:planting_season] = params[:vegetable][:planting_season].join(" ")
    @vegetable = Vegetable.find_by(id: params[:id])
    
    @vegetable.update(params[:vegetable])
    
    redirect to "/vegetables/#{@vegetable.id}"
  end
  
  delete '/vegetables/:id' do
    if logged_in?
      @vegetable = Vegetable.find_by(id: params[:id])
    
      if @user = current_user
        @vegetable.destroy
        
        redirect to "/users/#{@user.slug}"
      else
        flash[:notice] = "You aren't permitted to do that!"
        
        redirect to "/"
      end
    else
      flash[:notice] = "You need to login to do that!"
      
      redirect to "/login"
    end
  end
  
  get '/vegetables/:id/edit' do
    if logged_in?
      @vegetable = Vegetable.find_by(id: params[:id])
    
      if current_user == @vegetable.user
        @user = current_user
        
        erb :'vegetables/edit'
      else
        flash[:notice] = "You can only edit your own vegetables!"
        
        redirect to "/"
      end
    else
      flash[:notice] = "You need to login to do that!"
      
      redirect to '/login'
    end
  end
  
end