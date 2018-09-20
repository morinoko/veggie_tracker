RSpec.describe Farm do
  subject do
    described_class.create(name: "Joe's Farm",
                           location: 'Ohio',
                           user_id: user.id,
                           vegetables: [peas, daikon])
  end

  let(:user) { User.create(username: 'Joe Farmer', email: 'joe@aol.com', password: 'subjecter') }
  let(:peas) { Vegetable.create(name: 'Peas', planting_season: '3 4') }
  let(:daikon) { Vegetable.create(name: 'Peas', planting_season: '9') }

  it 'can make a slug from name' do
    expect(subject.slug).to eq('joes-farm')
  end

  it 'knows which user owns it' do
    expect(subject.user).to eq(user)
  end

  it 'know what vegetables are on the farm' do
    expect(subject.vegetables).to include(peas)
    expect(subject.vegetables).to include(daikon)
    expect(subject.vegetables.count).to eq(2)
  end
end
