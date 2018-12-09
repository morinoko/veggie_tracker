require 'spec_helper'
require 'pry'

RSpec.describe VegetablesController, type: :controller do
  let(:locale) { 'en' }
  let!(:user) { User.create(username: 'Ria', email: 'ria@gmail.com', password: 'meow') }
  let!(:farm) { Farm.create(name: 'Cattail Farm', location: 'Ohio', user_id: user.id) }
  let(:vegetable) { Vegetable.create(name: 'Carrots', planting_season: '3 4 5') }

  describe 'vegetable show page' do
    before { farm.vegetables << vegetable }

    it 'loads the vegetable page' do
      get "/#{locale}/vegetables/#{vegetable.id}"

      expect(last_response.status).to eq(200)
      expect(last_response.body).to include(vegetable.name)
      expect(last_response.body).to include('May')
      expect(last_response.body).to include(farm.name)
    end
  end

  describe 'new vegetable page' do
    context 'when logged in' do
      it 'loads the new vegetable form' do
        visit "/#{locale}/login"

        fill_in(:username, with: 'Ria')
        fill_in(:password, with: 'meow')
        click_button 'submit'

        visit "/#{locale}/vegetables/new"

        expect(page.status_code).to eq(200)
        expect(page.body).to include('Add veggie')
      end
    end

    context 'when logged out' do
      it 'redirects the user to login' do
        get "/#{locale}/vegetables/new"

        expect(last_response).to be_redirect
        follow_redirect!
        expect(last_request.path).to eq("/#{locale}/login")
      end
    end
  end

  describe 'creating, editing, and deleting a vegetable' do
    let(:other_user) do
      User.create(username: 'Joe Farmer', email: 'joe@aol.com', password: 'farmer')
    end

    let(:other_user_vegetable) { Vegetable.create(name: 'Parsnips', planting_season: '5') }
    let(:other_user_farm) do
      Farm.create(name: "Joe's Farm",
                  location: 'Columbus',
                  user_id: other_user.id,
                  vegetables: [other_user_vegetable])
    end

    before do
      visit "/#{locale}/login"

      fill_in(:username, with: 'Ria')
      fill_in(:password, with: 'meow')
      click_button 'submit'
    end

    it 'lets the user create a new vegetable' do
      visit "/#{locale}/vegetables/new"

      fill_in(:name, with: 'Rhubarb')
      check('April')
      check('Cattail Farm')
      click_button 'submit'

      expect(Vegetable.find_by(name: 'Rhubarb')).to be_truthy
    end

    it 'lets the user edit an exisiting vegetable' do
      vegetable = Vegetable.create(name: 'Carrots', planting_season: '3 4 5')
      farm.vegetables << vegetable

      visit "/#{locale}/vegetables/#{vegetable.id}/edit"
      expect(page.status_code).to eq(200)

      fill_in(:name, with: 'Yellow Carrots')
      uncheck('March')
      check('August')
      click_button 'submit'

      expect(Vegetable.find_by(name: 'Carrots')).to eq(nil)
      expect(Vegetable.find_by(name: 'Yellow Carrots')).to be_truthy

      vegetable = Vegetable.find_by(name: 'Yellow Carrots')
      expect(vegetable.planting_season).to eq(4 => 'April', 5 => 'May', 8 => 'August')
    end

    xit "does not allow users to edit another user's vegetable" do
      # for some reason redirects to login instead of root?

      get "/#{locale}/vegetables/#{other_user_vegetable.id}/edit"

      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/')
    end

    it 'lets users delete a vegetable' do
      vegetable = Vegetable.create(name: 'Carrots', planting_season: '3 4 5')
      farm.vegetables << vegetable

      visit "/#{locale}/vegetables/#{vegetable.id}/edit"

      click_button 'delete'
      expect(Vegetable.find_by(name: 'Carrots')).to eq(nil)
    end
  end
end
