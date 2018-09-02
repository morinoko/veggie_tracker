class VegetablesController < ApplicationController
  
  get '/:locale/vegetables/new' do
    if logged_in?
      @user = current_user
      
      erb :'vegetables/new'
    else
     flash[:notice] = t('notices.login_required')
     
     redirect to "/#{I18n.locale}/login"
    end
  end
  
  post '/:locale/vegetables' do
    params[:vegetable][:planting_season] = params[:vegetable][:planting_season].join(" ")
    @vegetable = Vegetable.new(params[:vegetable])
    @vegetable.save
    
    redirect to "/#{I18n.locale}/users/#{current_user.slug}"
  end
  
  get '/:locale/vegetables/:id' do
    @vegetable = Vegetable.find_by(id: params[:id])
    
    if @vegetable
      erb :'vegetables/show'
    else
      flash[:notice] = t('notices.not_found.vegetable')
      
      redirect to "/#{I18n.locale}/"
    end
  end
  
  patch '/:locale/vegetables/:id' do
    params[:vegetable][:planting_season] = params[:vegetable][:planting_season].join(" ")
    @vegetable = Vegetable.find_by(id: params[:id])
    
    @vegetable.update(params[:vegetable])
    
    redirect to "/#{I18n.locale}/vegetables/#{@vegetable.id}"
  end
  
  delete '/:locale/vegetables/:id' do
    if logged_in?
      @vegetable = Vegetable.find_by(id: params[:id])
    
      if @vegetable.user == current_user
        @vegetable.destroy
        
        redirect to "/#{I18n.locale}/users/#{@user.slug}"
      else
        flash[:notice] = t('notices.not_authorized')
        
        redirect to "/#{I18n.locale}/"
      end
    else
      flash[:notice] = t('notices.login_required')
      
      redirect to "/#{I18n.locale}/login"
    end
  end
  
  get '/:locale/vegetables/:id/edit' do
    if logged_in?
      @vegetable = Vegetable.find_by(id: params[:id])
    
      if @vegetable.user == current_user
        @user = current_user
        erb :'vegetables/edit'
      else
        flash[:notice] = t('notices.not_authorized')
        
        redirect to "/#{I18n.locale}/"
      end
    else
      flash[:notice] = t('notices.login_required')
      
      redirect to "/#{I18n.locale}/login"
    end
  end
  
end