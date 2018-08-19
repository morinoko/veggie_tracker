class FarmsController < ApplicationController
  
  get '/farms/:slug' do
    @farm = Farm.find_by_slug(params[:slug])
    
    erb :'farms/show'
  end
end
