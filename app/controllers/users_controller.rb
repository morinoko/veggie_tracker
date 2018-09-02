class UsersController < ApplicationController
  
  get '/signup' do
    if logged_in?
      redirect to "/#{I18n.locale}/"
    else
      erb :'registration/signup'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if @user.save
      flash[:notice] = t('notices.signup.welcome', username: @user.username)

      session[:user_id] = @user.id

      redirect to "/#{I18n.locale}/users/#{@user.slug}"
    elsif User.find_by(email: params[:email])
      flash[:notice] = t('notices.signup.email_taken')
       
      redirect to "/#{I18n.locale}/signup"
    elsif User.find_by_slug(@user.slug)
      flash[:notice] = t('notices.signup.name_taken')
      
      redirect to "/#{I18n.locale}/signup"
    else
      flash[:notice] = t('notices.signup.error')

      redirect to "/#{I18n.locale}/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect to "/#{I18n.locale}/users/#{current_user.slug}"
    else
      erb :'sessions/login'
    end
  end
  
  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, #{@user.username}!"

      redirect to "/#{I18n.locale}/users/#{@user.slug}"
    else
      flash[:notice] = t('notices.login.param_error')

      redirect to "/#{I18n.locale}/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to "/#{I18n.locale}/"
    else
      redirect to "/#{I18n.locale}/"
    end
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    
    if @user
      erb :'users/show'
    else
      flash[:notice] = t('notices.not_found.user')
      
      redirect to "/#{I18n.locale}/"
    end
  end
end
