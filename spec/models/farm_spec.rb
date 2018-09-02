RSpec.describe 'Farm' do
  before do
    @user = User.create(username: "Joe Farmer", email: "joe@aol.com", password: "farmer")
    @farm = Farm.create(name: "Joe's Farm", location: "Ohio", user_id: @user.id)
    @peas = Vegetable.create(name: "Peas", planting_season: "3 4")
    @daikon = Vegetable.create(name: "Peas", planting_season: "9")
    @farm.vegetables << @peas
    @farm.vegetables << @daikon
  end
  
  it "can make a slug from name" do
    expect(@farm.slug).to eq("joes-farm")
  end
  
  it "knows which user owns it" do
    expect(@farm.user).to eq(@user)
  end
  
  it "know what vegetables are on the farm" do
    expect(@farm.vegetables).to include(@peas)
    expect(@farm.vegetables).to include(@daikon)
    expect(@farm.vegetables.count).to eq(2)
  end
end