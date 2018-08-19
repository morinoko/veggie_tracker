RSpec.describe 'Farm' do
  before do
    @user = User.create(username: "Joe Farmer", email: "joe@aol.com", password: "farmer")
    @farm = Farm.create(name: "Joe's Farm", location: "Ohio", user_id: @user.id)
  end
  
  it "can make a slug from name" do
    expect(@farm.slug).to eq("joes-farm")
  end
  
  it "can find a farm with the slug" do
    slug = @farm.slug
    expect(Farm.find_by_slug(slug)).to eq(@farm)
  end
end