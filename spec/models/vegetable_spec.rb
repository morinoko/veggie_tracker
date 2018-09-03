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
  
  it "knows if it needs to be planted this month" do
    peas = Vegetable.create(name: "Peas", planting_season: "3 4")
    daikon = Vegetable.create(name: "Peas", planting_season: "9")
    
    date = Time.new(2018, 4, 14)
    allow(Time).to receive(:now).and_return(date)
    
    expect(peas.plant_this_month?).to be_truthy
    expect(daikon.plant_this_month?).to be_falsey
  end
  
  it "knows what vegetables should be planted for a user this month" do
    peas = Vegetable.create(name: "Peas", planting_season: "3 4")
    daikon = Vegetable.create(name: "Peas", planting_season: "9")
    @farm.vegetables << peas
    @farm.vegetables << daikon
    
    date = Time.new(2018, 4, 14)
    allow(Time).to receive(:now).and_return(date)
    
    expect(Vegetable.this_months_vegetables_for(@user)).to include(peas)
    expect(Vegetable.this_months_vegetables_for(@user)).not_to include(daikon)
  end
end