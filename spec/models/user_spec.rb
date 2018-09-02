RSpec.describe 'User' do
  before do
    @user = User.create(username: "Joe Farmer", email: "joe@aol.com", password: "farmer")
  end
  
  it "can make a slug from own username" do
    expect(@user.slug).to eq("joe-farmer")
  end
  
  it "can find a user with the slug" do
    slug = @user.slug
    expect(User.find_by_slug(slug)).to eq(@user)
  end
  
  it "has a secure password" do
    expect(@user.authenticate("oops")).to eq(false)
    expect(@user.authenticate("farmer")).to eq(@user)
  end
  
  it "knows if it needs to plant this month" do
    farm = Farm.create(name: "My Farm", location: "Ohio", user_id: @user.id)
    peas = Vegetable.create(name: "Peas", planting_season: "3 4")
    daikon = Vegetable.create(name: "Peas", planting_season: "9")
    farm.vegetables << peas
    farm.vegetables << daikon
    
    date = Time.new(2018, 4, 14)
    allow(Time).to receive(:now).and_return(date)
    
    expect(@user.this_months_vegetables).to include(peas)
    expect(@user.this_months_vegetables).not_to include(daikon)
  end
end