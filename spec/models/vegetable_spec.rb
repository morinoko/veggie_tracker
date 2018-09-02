RSpec.describe 'Vegetable' do
  before do
    @user = User.create(username: "Joe Farmer", email: "joe@aol.com", password: "farmer")
    @farm = Farm.create(name: "Joe's Farm", location: "Ohio", user_id: @user.id)
    @vegetable = Vegetable.create(name: "Carrots", planting_season: "3 4 5")
    @farm.vegetables << @vegetable
  end
  
  it "knows its farms" do
    expect(@vegetable.farms).to include(@farm)
  end
  
  it "can find its user" do
    expect(@vegetable.user).to eq(@user)
  end
  
  it "can convert planting_season data to integers" do
    expect(@vegetable.planting_season).to eq({3 => "March", 4 => "April", 5 => "May"})
  end
  
  it "can convert planting_season data to month names" do
    expect(@vegetable.planting_season_month_names).to be_instance_of(Array)
    expect(@vegetable.planting_season_month_names.include?("March")).to be(true)
    expect(@vegetable.planting_season_month_names.include?("April")).to be(true)
    expect(@vegetable.planting_season_month_names.include?("May")).to be(true)
  end
end