RSpec.describe 'Vegetable' do
  before do
    @user = User.create(username: "Joe Farmer", email: "joe@aol.com", password: "farmer")
    @farm = Farm.create(name: "Joe's Farm", location: "Ohio", user_id: @user.id)
    @vegetable = Vegetable.create(name: "Carrots", planting_season: "3 4 5")
    @farm.vegetables << @vegetable
  end
  
  it "can find its user" do
    expect(@vegetable.user).to eq(@user)
  end
  
  it "can convert planting_season data to integers" do
    expect(@vegetable.planting_months_as_numbers).to eq([3, 4, 5])
    expect(@vegetable.planting_months_as_numbers).to be_instance_of(Array)
    expect(@vegetable.planting_months_as_numbers.first).to be_instance_of(Integer)
  end
  
  it "can convert planting_season data to month names" do
    expect(@vegetable.planting_months_as_names).to be_instance_of(Array)
    expect(@vegetable.planting_months_as_names.include?("March")).to be(true)
    expect(@vegetable.planting_months_as_names.include?("April")).to be(true)
    expect(@vegetable.planting_months_as_names.include?("May")).to be(true)
  end
end