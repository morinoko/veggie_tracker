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
			
			redirect to '/'
		else
			flash[:notice] = "Looks like something went wrong. Try the form again."
			
			redirect to '/signup'
		end
	end
end