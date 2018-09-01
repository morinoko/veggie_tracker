class VegetablesController < ApplicationController
  
  get '/vegetables/new' do
    if logged_in?
      @user = current_user
      
      erb :'vegetables/new'
    else
     flash[:notice] = "You need to be logged in to do that!"
     
     redirect to "/#{I18n.locale}/login"
    end
  end
  
  post '/vegetables' do
    params[:planting_season] = params[:planting_season].join(" ")
    @vegetable = Vegetable.new(params)
    @vegetable.save
    
    redirect to "/#{I18n.locale}/users/#{current_user.slug}"
  end
  
  get '/vegetables/:id' do
    @vegetable = Vegetable.find_by(id: params[:id])
    
    if @vegetable
      erb :'vegetables/show'
    else
      flash[:notice] = "This veggie doesn't seem to exist..."
      
      redirect to "/#{I18n.locale}/"
    end
  end
  
  patch '/vegetables/:id' do
    params[:vegetable][:planting_season] = params[:vegetable][:planting_season].join(" ")
    @vegetable = Vegetable.find_by(id: params[:id])
    
    @vegetable.update(params[:vegetable])
    
    redirect to "/#{I18n.locale}/vegetables/#{@vegetable.id}"
  end
  
  delete '/vegetables/:id' do
    if logged_in?
      @vegetable = Vegetable.find_by(id: params[:id])
    
      if @vegetable.user == current_user
        @vegetable.destroy
        
        redirect to "/#{I18n.locale}/users/#{@user.slug}"
      else
        flash[:notice] = "You aren't permitted to do that!"
        
        redirect to "/#{I18n.locale}/"
      end
    else
      flash[:notice] = "You need to login to do that!"
      
      redirect to "/#{I18n.locale}/login"
    end
  end
  
  get '/vegetables/:id/edit' do
    if logged_in?
      @vegetable = Vegetable.find_by(id: params[:id])
    
      if @vegetable.user == current_user
        @user = current_user
        erb :'vegetables/edit'
      else
        flash[:notice] = "You can only edit your own vegetables!"
        
        redirect to "/#{I18n.locale}/"
      end
    else
      flash[:notice] = "You need to login to do that!"
      
      redirect to "/#{I18n.locale}/login"
    end
  end
  
end