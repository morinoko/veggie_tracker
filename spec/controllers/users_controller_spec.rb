require 'spec_helper'
require 'pry'

RSpec.describe UsersController, :type => :controller do
  
  before do
    @locale = "en"
  end
  
  describe "Signup Page" do
    
    it "loads the signup page" do
      get "/#{@locale}/signup"
      
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Sign up")
    end
    
    context "successful signup" do
      it "redirects a new user to the homepage" do
        params = {
          :username => "Rider",
          :email => "howdy@aol.com",
          :password => "cowboy"
        }
        
        post "/#{@locale}/signup", params
        expect(last_response.redirect?).to be_truthy
        follow_redirect!
        expect(last_request.path).to eq("/#{@locale}/users/rider")
        expect(last_response.body).to include("Welcome Rider!")
      end
    end
    
    context "unsuccessful signup" do
      it "does not let user signup without a username" do
        params = {
          :username => "",
          :email => "howdy@aol.com",
          :password => "cowboy"
        }
        
        post "/#{@locale}/signup", params
        follow_redirect!
        expect(last_request.path).to eq("/#{@locale}/signup")
        expect(last_response.body).to include("Try the form again.")
      end
        
      it "does not let user signup without an email" do
        params = {
          :username => "Rider",
          :email => "",
          :password => "cowboy"
        }
        
        post "/#{@locale}/signup", params
        follow_redirect!
        expect(last_request.path).to eq("/#{@locale}/signup")
        expect(last_response.body).to include("Try the form again.")
      end
      
      it "does not let user signup without a password" do
        params = {
          :username => "Rider",
          :email => "howdy@aol.com",
          :password => ""
        }
        
        post "/#{@locale}/signup", params
        follow_redirect!
        expect(last_request.path).to eq("/#{@locale}/signup")
        expect(last_response.body).to include("Try the form again.")
      end
      
      it "does not let allow duplicate email sign-ups" do
        params = {
          :username => "Rider",
          :email => "howdy@aol.com",
          :password => "cowboy"
        }
        
        post "/#{@locale}/signup", params
        follow_redirect!
        expect(last_request.path).to eq("/#{@locale}/users/rider")
        expect(User.find_by(username: "Rider")).to be_truthy
        
        get '/logout'
        
        params_2 = {
          :username => "Duplicate Rider",
          :email => "howdy@aol.com",
          :password => "double"
        }
        
        post "/#{@locale}/signup", params_2
        follow_redirect!
        expect(last_request.path).to eq("/#{@locale}/signup")
        expect(User.find_by(username: "Duplicate Rider")).to be_nil
      end
      
      it "does not let allow duplicate username (slug) sign-ups" do
        params = {
          :username => "Rider",
          :email => "howdy@aol.com",
          :password => "cowboy"
        }
        
        post "/#{@locale}/signup", params
        follow_redirect!
        expect(last_request.path).to eq("/#{@locale}/users/rider")
        expect(User.find_by(username: "Rider")).to be_truthy
        
        get '/logout'
        
        params_2 = {
          :username => "rider",
          :email => "the_other_rider@aol.com",
          :password => "double"
        }
        
        post "/#{@locale}/signup", params_2
        follow_redirect!
        expect(last_request.path).to eq("/#{@locale}/signup")
        expect(User.find_by(email: "the_other_rider@aol.com")).to be_nil
      end


    end
  end
  
  describe "Logging out" do
    
    it 'redirects user to the homepage' do
      get "/#{@locale}/logout"
      
      follow_redirect!
      expect(last_request.path).to eq("/#{@locale}/")
      expect(last_response.body).to include("Login")
    end
  end
  
  describe "Signing in" do
    before do
      @user = User.create(:username => "Ria", :email => "ria@aol.com", :password => "meow")
    end
    
    context "logged out" do
      it "loads the login page" do
        get "/#{@locale}/login"
        
        expect(last_response.status).to eq(200)
        expect(last_request.path).to eq("/#{@locale}/login")
      end
    end
    
    context "logged in" do
      it "redirects user to their dashboard" do
        params = {
          :username => "Ria",
          :password => "meow"
        }
        
        post "/#{@locale}/login", params
        
        get "/#{@locale}/login"
        
        follow_redirect!
        expect(last_request.path).to eq("/#{@locale}/users/ria")
      end
    end
    
    context "successful sign in" do
      it 'redirects user to their dashboard' do
        params = {
          :username => "Ria",
          :password => "meow"
        }
        
        post "/#{@locale}/login", params
        
        follow_redirect!
        expect(last_request.path).to eq("/#{@locale}/users/ria")
      end
    end
    
    context "unsuccessful sign in" do
      it "does not user sign in with wrong username" do
        params = {
          :username => "Ria_xyz",
          :password => "meow"
        }
        
        post "/#{@locale}/login", params
        
        expect(last_response.location).to include("/#{@locale}/login")
      end
      
      it "does not user sign in with wrong password" do
        params = {
          :username => "Ria",
          :password => "meow_oops"
        }
        
        post "/#{@locale}/login", params
        
        expect(last_response.location).to include("/#{@locale}/login")
      end
    end
  end
  
  describe "User show page" do
    
    it "loads the user show page" do
      user = User.create(:username => "Ria", :email => "ria@aol.com", :password => "meow")
      
      get "/#{@locale}/users/ria"
      
      expect(last_response.status).to eq(200)
    end
    
  end
  
end