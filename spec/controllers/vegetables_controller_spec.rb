require 'spec_helper'
require 'pry'

RSpec.describe VegetablesController, :type => :controller do
  
  describe "vegetable show page" do
    before do
      @user = User.create(username: "Joe Farmer", email: "joe@aol.com", password: "farmer")
      @farm = Farm.create(name: "Joe's Farm", location: "Ohio", user_id: @user.id)
      @vegetable = Vegetable.create(name: "Carrots", planting_season: "3 4 5")
      @farm.vegetables << @vegetable
    end
    
    it "loads the vegetable page" do
      get "/vegetables/#{@vegetable.id}"
      
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include(@vegetable.name)
      expect(last_response.body).to include("May")
      expect(last_response.body).to include(@farm.name)
    end  
  end
  
  describe "new vegetable page" do
    before do
      @user = User.create(username: "Ria", email: "ria@gmail.com", password: "meow")
      @farm = Farm.create(name: "Cattail Farm", location: "Ohio", user_id: @user.id)
    end
    
    context "logged in" do
      it "loads the new vegetable form" do
        visit '/login'
        
        fill_in(:username, with: "Ria")
        fill_in(:password, with: "meow")
        click_button 'submit'
        
        visit '/vegetables/new'
        
        expect(page.status_code).to eq(200)
        expect(page.body).to include("Add a vegetable")
      end
    end
    
    context "logged out" do
      it "redirects the user to login" do
        get '/farms/new'
        
        expect(last_response.location).to include('/login')
      end
    end
  end
  
  describe "creating a vegetable" do
    it "lets the user create a new vegetable" do
      @user = User.create(username: "Ria", email: "ria@gmail.com", password: "meow")
      @farm = Farm.create(name: "Cattail Farm", location: "Ohio", user_id: @user.id)
      
      visit '/login'
      
      fill_in(:username, with: "Ria")
      fill_in(:password, with: "meow")
      click_button 'submit'
    end
  end
  
  describe "editing a vegetable" do
    it "lets the user edit a new vegetable" do
      @user = User.create(username: "Ria", email: "ria@gmail.com", password: "meow")
      @farm = Farm.create(name: "Cattail Farm", location: "Ohio", user_id: @user.id)
      @vegetable = Vegetable.create(name: "Carrots", planting_season: "3 4 5")
      @farm.vegetables << @vegetable
      
      visit '/login'
      
      fill_in(:username, with: "Ria")
      fill_in(:password, with: "meow")
      click_button 'submit'
      
      visit "/vegetables/#{@vegetable.id}/edit"
      expect(page.status_code).to eq(200)
    end
    
  end
  
end
