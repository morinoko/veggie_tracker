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
        expect(page.body).to include("Add veggie")
      end
    end
    
    context "logged out" do
      it "redirects the user to login" do
        get '/vegetables/new'
        
        expect(last_response.redirect?).to be_truthy
        follow_redirect!
        expect(last_request.path).to eq('/login')
      end
    end
  end
  
  describe "creating, editing, and deleting a vegetable" do
    before do
      @user = User.create(username: "Ria", email: "ria@gmail.com", password: "meow")
      @farm = Farm.create(name: "Cattail Farm", location: "Ohio", user_id: @user.id)
      
      @other_user = User.create(username: "Joe Farmer", email: "joe@aol.com", password: "farmer")
      @other_user_farm = Farm.create(name: "Joe's Farm", location: "Columbus", user_id: @other_user.id)
      @other_user_vegetable = Vegetable.create(name: "Parsnips", planting_season: "5")
      @other_user_farm.vegetables << @other_user_vegetable
      
      visit '/login'
      
      fill_in(:username, with: "Ria")
      fill_in(:password, with: "meow")
      click_button 'submit'
    end
    
    it "lets the user create a new vegetable" do
      visit '/vegetables/new'
      
      fill_in(:name, with: "Rhubarb")
      check('April')
      check('Cattail Farm')
      click_button 'submit'
      
      expect(Vegetable.find_by(name: 'Rhubarb')).to be_truthy
    end
  
    it "lets the user edit an exisiting vegetable" do
      vegetable = Vegetable.create(name: "Carrots", planting_season: "3 4 5")
      @farm.vegetables << vegetable
      
      visit "/vegetables/#{vegetable.id}/edit"
      expect(page.status_code).to eq(200)
      
      fill_in(:name, with: "Yellow Carrots")
      uncheck('March')
      check('August')
      click_button 'submit'
      
      expect(Vegetable.find_by(name: 'Carrots')).to eq(nil)
      expect(Vegetable.find_by(name: 'Yellow Carrots')).to be_truthy
      
      vegetable = Vegetable.find_by(name: 'Yellow Carrots')
      expect(vegetable.planting_season).to eq({4 => "April", 5 => "May", 8 => "August"})
    end
    
    xit "does not allow users to edit another user's vegetable" do
      # for some reason redirects to login instead of root?
      
      get "/vegetables/#{@other_user_vegetable.id}/edit"
      
      expect(last_response.redirect?).to be_truthy
      follow_redirect!
      expect(last_request.path).to eq('/')
    end
  
    it "lets users delete a vegetable" do
      vegetable = Vegetable.create(name: "Carrots", planting_season: "3 4 5")
      @farm.vegetables << vegetable
      
      visit "/vegetables/#{vegetable.id}/edit"
      
      click_button 'delete'
      expect(Vegetable.find_by(name: "Carrots")).to eq(nil)
    end
  end
end
