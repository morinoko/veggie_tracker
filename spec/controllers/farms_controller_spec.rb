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
  
end