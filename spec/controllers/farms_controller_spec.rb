require 'spec_helper'
require 'pry'

RSpec.describe FarmsController, :type => :controller do
  
  describe "farm show page" do
    before do
      @user = User.create(username: "Ria", email: "ria@gmail.com", password: "meow")
      @farm = Farm.create(name: "Cattail Farm", location: "Ohio", user_id: @user.id)
      
      visit '/login'
      
      fill_in(:username, with: "Ria")
      fill_in(:password, with: "meow")
      click_button 'submit'
    end
    
    it "loads the farm page" do
      get "/farms/#{@farm.id}/#{@farm.slug}"
      
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include(@farm.name)
      expect(last_response.body).to include(@farm.location)
    end  
  end
  
  describe "new farm page" do
    before do
      @user = User.create(username: "Ria", email: "ria@gmail.com", password: "meow")
    end
    
    context "logged in" do
      it "loads the new farm form" do
        visit '/login'
        
        fill_in(:username, with: "Ria")
        fill_in(:password, with: "meow")
        click_button 'submit'
        
        visit '/farms/new'
        
        expect(page.status_code).to eq(200)
        expect(page.body).to include("Create a new farm")
      end
    end
    
    context "logged out" do
      it "redirects the user to login" do
        get '/farms/new'
        
        expect(last_response.location).to include('/login')
      end
    end
  end
  
  describe "creating a new farm" do
    it "lets user create a new farm" do
      user = User.create(username: "Ria", email: "ria@gmail.com", password: "meow")
      
      visit '/login'
      
      fill_in(:username, with: "Ria")
      fill_in(:password, with: "meow")
      click_button 'submit'
      
      visit '/farms/new'
      
      fill_in(:name, with: "My Farm")
      fill_in(:location, with: "Catland")
      click_button 'submit'
      
      farm = Farm.find_by(name: "My Farm")
      expect(farm).to be_instance_of(Farm)
      expect(farm.user_id).to eq(user.id)
      
      visit "/farms/#{farm.id}/#{farm.slug}"
      expect(page.status_code).to eq(200)
    end
  end
  
  describe "editing a farm" do
    before do
      @user = User.create(username: "Ria", email: "ria@gmail.com", password: "meow")
      @farm = Farm.create(name: "Cattail Farm", location: "Ohio", user_id: @user.id)
      
      visit '/login'
      
      fill_in(:username, with: "Ria")
      fill_in(:password, with: "meow")
      click_button 'submit'
    end
    
    context "logged in" do
      it "lets user edit a farm" do
        visit "/farms/#{@farm.id}/#{@farm.slug}/edit"
        
        fill_in(:name, with: "Cattail Farm Edited")
        fill_in(:location, with: "Catlandia")
        click_button 'save'
        
        expect(Farm.find_by(name: "Cattail Farm Edited")).to be_instance_of(Farm)
        expect(Farm.find_by(name: "Cattail Farm")).to eq(nil)
      end
    end
    
    context "logged out" do
      it "does not allow logged out user to edit a farm" do
        get '/logout'
        get "/farms/#{@farm.id}/#{@farm.slug}/edit"
        
        expect(last_response.location).to include("/")
      end
      
      it "does not show the edit button on the farm page" do
        get '/logout'
        get "/farms/#{@farm.id}/#{@farm.slug}"
        
        expect(last_response.body).to_not include("Edit farm")
      end
    end
  end

  describe "deleting a farm" do
    it "lets users delete a farm" do
      @user = User.create(username: "Ria", email: "ria@gmail.com", password: "meow")
      @farm = Farm.create(name: "Cattail Farm", location: "Ohio", user_id: @user.id)
      
      visit '/login'
      
      fill_in(:username, with: "Ria")
      fill_in(:password, with: "meow")
      click_button 'submit'
      
      visit "/farms/#{@farm.id}/#{@farm.slug}/edit"
      
      click_button 'delete'
      expect(Farm.find_by(name: "Cattail Farm")).to eq(nil)
    end
  end
  
end