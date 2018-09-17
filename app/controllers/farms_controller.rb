class FarmsController < ApplicationController

  get '/:locale/farms/new' do
    if logged_in?
      erb :'farms/new'
    else
      flash[:notice] = t('notices.login_required')

      redirect to "/#{I18n.locale}/login"
    end
  end

  post '/:locale/farms' do
    @farm = Farm.new(params[:farm])

    if @farm.save
      @farm.user = current_user
      @farm.save

      redirect to "/#{I18n.locale}/farms/#{@farm.id}/#{@farm.slug}"
    else
      flash[:notice] = t('notices.missing_fields')

      redirect to "/#{I18n.locale}/farms/new"
    end
  end

  get '/:locale/farms/:id/:slug' do
    @farm = Farm.find_by(id: params[:id])

    if @farm
      erb :'farms/show'
    else
      flash[:notice] = t('notices.not_found.farm')

      redirect to "/#{I18n.locale}/"
    end
  end

  patch '/:locale/farms/:id/:slug' do
    @farm = Farm.find_by(id: params[:id])

    @farm.update(params[:farm])

    redirect to "/#{I18n.locale}/farms/#{@farm.id}/#{@farm.slug}"
  end

  delete '/:locale/farms/:id/:slug' do
    @farm = Farm.find_by(id: params[:id])
    @user = @farm.user

    if current_user == @user
      @farm.destroy

      redirect to "/#{I18n.locale}/users/#{@user.slug}"
    else
      flash[:notice] = t('notices.not_authorized')

      redirect to "/#{I18n.locale}/"
    end
  end

  get '/:locale/farms/:id/:slug/edit' do
    if logged_in?
      @farm = Farm.find_by(id: params[:id])

      if current_user == @farm.user
        erb :'farms/edit'
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
