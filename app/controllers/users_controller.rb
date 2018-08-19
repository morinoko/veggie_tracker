class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/'
  else
      erb :'registration/signup'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if @user.save
      flash[:notice] = "You've successfully signed up! Welcome #{@user.username}!"

      session[:user_id] = @user.id

      redirect to "/users/#{@user.slug}"
    elsif User.find_by(email: params[:email])
       flash[:notice] = "This email is already taken."
       
       redirect to '/signup'
    else
      flash[:notice] = "Looks like something went wrong. Try the form again."

      redirect to '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect to "/users/#{current_user.slug}"
    else
      erb :'sessions/login'
    end
  end
  
  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, #{@user.username}!"

      redirect to "/users/#{@user.slug}"
    else
      flash[:notice] = "Your username or password was incorrect! Please try again."

      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/'
    else
      redirect to '/'
    end
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    
    erb :'users/show'
  end
end