class FarmsController < ApplicationController
  
  get '/farms/new' do
    if logged_in?
      erb :'farms/new'
    else
      flash[:notice] = "You need to be logged in to do that!"
      
      redirect to "/#{I18n.locale}/login"
    end
  end
  
  post '/farms' do
    @farm = Farm.new(name: params[:name], location: params[:location])
    
    if @farm.save
      @farm.user = current_user
      @farm.save
      
      redirect to "/#{I18n.locale}/farms/#{@farm.id}/#{@farm.slug}"
    else
      flash[:notice] = "Please fill in all the fields."
      
      redirect to "/#{I18n.locale}/farms/new"
    end
  end
  
  get '/farms/:id/:slug' do
    @farm = Farm.find_by(id: params[:id])
    
    if @farm
      erb :'farms/show'
    else
      flash[:notice] = "This farm doesn't seem to exist..."
      
      redirect to "/#{I18n.locale}/"
    end
  end
  
  patch '/farms/:id/:slug' do
    @farm = Farm.find_by(id: params[:id])
    
    @farm.update(name: params[:name], location: params[:location])
    
    redirect to "/#{I18n.locale}/farms/#{@farm.id}/#{@farm.slug}"
  end
  
  delete '/farms/:id/:slug' do
    @farm = Farm.find_by(id: params[:id])
    @user = @farm.user
    
    if current_user == @user
      @farm.destroy
    
      redirect to "/#{I18n.locale}/users/#{@user.slug}"
    else
      flash[:notice] = "You aren't permitted to do that!"
      
      redirect to "/#{I18n.locale}/"
    end
  end
  
  get '/farms/:id/:slug/edit' do
    if logged_in?
      @farm = Farm.find_by(id: params[:id])
    
      if current_user == @farm.user
        erb :'farms/edit'
      else
        flash[:notice] = "You aren't permitted to do that!"
        redirect to "/#{I18n.locale}/"
      end
    else
      flash[:notice] = "You need to login to edit farms!"
      redirect to "/#{I18n.locale}/login"
    end
  end
  
end
