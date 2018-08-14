class UsersController < ApplicationController
	
	get '/signup' do
		erb :'registration/signup'
	end
end