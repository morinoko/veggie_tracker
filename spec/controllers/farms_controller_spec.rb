require 'spec_helper'
require 'pry'

RSpec.describe FarmsController, :type => :controller do
  
  describe "farm show page" do
    before do
      @user = User.create(username: "Ria", email: "ria@gmail.com", password: "meow")
      @farm = Farm.create(name: "Cattail Farm", location: "Ohio", user_id: @user.id)
    end
    
    it "loads the farm page" do
      get '/farms/cattail-farm'
      
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include(@farm.name)
      expect(last_response.body).to include(@farm.location)
    end  
  end
  
  describe "farm create page" do
    before do
      @user = User.create(username: "Ria", email: "ria@gmail.com", password: "meow")
    end
    
    context "logged in" do
      it "loads the new farm form" do
        params = {
          :username => "Ria",
          :password => "meow"
        }
        
        post '/login', params
        
        get '/farms/new'
        
        expect(last_response.status).to eq(200)
        expect(last_response.body).to include("Create a new farm")
      end
    end
    
    context "logged out" do
      it "redirects the user to login" do
        get '/logout'
        get '/farms/new'
        
        expect(last_response.redirect?).to be_truthy
        follow_redirect!
        expect(last_request.path).to eq('/login')
        expect(last_response.body).to include("You need to be logged in to do that")
      end
    end
  end
  
end