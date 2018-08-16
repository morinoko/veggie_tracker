require 'spec_helper'

RSpec.describe ApplicationController, :type => :controller do
  describe "Homepage" do
    it "loads the homepage" do
      get '/'
      
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Veggie Tracker")
    end
  end
end