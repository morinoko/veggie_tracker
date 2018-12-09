RSpec.describe User do
  subject do
    described_class.create(username: 'Joe Farmer', email: 'joe@aol.com', password: 'farmer')
  end

  it 'can make a slug from own username' do
    expect(subject.slug).to eq('joe-farmer')
  end

  it 'can find a user with the slug' do
    slug = subject.slug
    expect(described_class.find_by_slug(slug)).to eq(subject)
  end

  it 'has a secure password' do
    expect(subject.authenticate('oops')).to eq(false)
    expect(subject.authenticate('farmer')).to eq(subject)
  end
end
