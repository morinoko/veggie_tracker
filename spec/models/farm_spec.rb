RSpec.describe 'Farm' do
  before do
    @user = User.create(username: "Joe Farmer", email: "joe@aol.com", password: "farmer")
    @farm = Farm.create(name: "Joe's Farm", location: "Ohio", user_id: @user.id)
  end
  
  it "can make a slug from name" do
    expect(@farm.slug).to eq("joes-farm")
  end
end