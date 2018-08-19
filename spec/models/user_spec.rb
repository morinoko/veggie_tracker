RSpec.describe 'User' do
  before do
    @user = User.create(:username => "Joe Farmer", :email => "joe@aol.com", :password => "farmer")
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
end