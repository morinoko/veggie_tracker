require 'spec_helper'

RSpec.describe ApplicationController, :type => :controller do
  describe "Homepage" do
    context "English" do
      it "loads the homepage" do
        get '/en/'
        
        expect(last_response.status).to eq(200)
        expect(last_response.body).to include("Welcome")
      end
    end
    
    context "Japanese" do
      it "loads the homepage" do
        get '/ja/'
        
        expect(last_response.status).to eq(200)
        expect(last_response.body).to include("ようこそ")
      end
    end

  end
end