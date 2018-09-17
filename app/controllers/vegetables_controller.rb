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

    if @vegetable.save
      @vegetable.user = current_user 
      @vegetable.save

      redirect to "/#{I18n.locale}/vegetables/#{@vegetable.id}"
    else
      flash[:notice] = t('notices.general_error')

      redirect_to "/#{I18n.locale}/vegetables/new"
    end
  end

  get '/:locale/vegetables/months' do
    @user = current_user
    @vegetables_for_each_month = {}

    months = (1..12).to_a
    months.each do |month|
      @vegetables_for_each_month[month] = Vegetable.vegetables_for_month(month: month, user: @user)
    end

    erb :'vegetables/months-index'
  end

  get '/:locale/vegetables/months/:month' do
    @user = current_user
    @month = params[:month].to_i
    @vegetables_to_plant = Vegetable.vegetables_for_month(month: @month, user: @user)

    erb :'vegetables/months'
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

    #temp check farms.first.user to account for late addition of user_id to vegetables
    if @vegetable.user.nil?
      @vegetable.user = current_user
      @vegetable.save
    end

    redirect to "/#{I18n.locale}/vegetables/#{@vegetable.id}"
  end

  delete '/:locale/vegetables/:id' do
    if logged_in?
      @vegetable = Vegetable.find_by(id: params[:id])

      #temp check farms.first.user to account for late addition of user_id to vegetables
      if @vegetable.user == current_user || @vegetable.farms.first.user = current_user 
        @user = current_user
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

      #temp check farms.first.user to account for late addition of user_id to vegetables
      if @vegetable.user == current_user || @vegetable.farms.first.user = current_user
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
