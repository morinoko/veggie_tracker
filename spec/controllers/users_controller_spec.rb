require 'spec_helper'

RSpec.describe UsersController, :type => :controller do
  
  describe "Signup Page" do
    
    it "loads the signup page" do
      get '/signup'
      
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Signup")
    end
    
    context "successful signup" do
      it "redirects a new user to the homepage" do
        params = {
          :username => "Rider",
          :email => "howdy@aol.com",
          :password => "cowboy"
        }
        
        post '/signup', params
        expect(last_response.redirect?).to be_truthy
        follow_redirect!
        expect(last_request.path).to eq('/')
        expect(last_response.body).to include("Welcome Rider!")
      end
    end
    
    context "unsucessful signup" do
      it "does not let user signup without a username" do
        params = {
          :username => "",
          :email => "howdy@aol.com",
          :password => "cowboy"
        }
        
        post '/signup', params
        follow_redirect!
        expect(last_request.path).to eq('/signup')
        expect(last_response.body).to include("Try the form again.")
      end
        
      it "does not let user signup without an email" do
        params = {
          :username => "Rider",
          :email => "",
          :password => "cowboy"
        }
        
        post '/signup', params
        follow_redirect!
        expect(last_request.path).to eq('/signup')
        expect(last_response.body).to include("Try the form again.")
      end
      
      it "does not let user signup without a password" do
        params = {
          :username => "Rider",
          :email => "howdy@aol.com",
          :password => ""
        }
        
        post '/signup', params
        follow_redirect!
        expect(last_request.path).to eq('/signup')
        expect(last_response.body).to include("Try the form again.")
      end
    end
  end
  
  describe "Logging out" do
    
    it 'redirects user to the homepage' do
      get '/logout'
      
      follow_redirect!
      expect(last_request.path).to eq('/')
      expect(last_response.body).to include("Login")
    end
  end
  
  describe "Signing in" do
    
    context "successful sign in" do
      it 'redirects user to homepage' do
        user = User.create(:username => "Ria", :email => "ria@aol.com", :password => "meow")
        
        params = {
          :username => "Ria",
          :password => "meow"
        }
        
        post '/login', params
        
        follow_redirect!
        expect(last_request.path).to eq('/')
        expect(last_response.body).to include("Welcome, Ria!")
      end
    end
    
  end
end