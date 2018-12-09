RSpec.describe Vegetable do
  subject do
    described_class.create(name: 'Carrots', planting_season: '3 4 5', user_id: user.id)
  end

  let(:user) do
    User.create(username: 'Joe Farmer', email: 'joe@aol.com', password: 'farmer')
  end
  let(:farm) do
    Farm.create(name: "Joe's Farm", location: 'Ohio', user_id: user.id, vegetables: [subject])
  end

  let(:peas) { described_class.create(name: 'Peas', planting_season: '3 4') }
  let(:daikon) { described_class.create(name: 'Peas', planting_season: '9') }

  it 'knows its farms' do
    expect(subject.farms).to include(farm)
  end

  it 'can find its user' do
    expect(subject.user).to eq(user)
  end

  it 'can convert planting_season data to integers' do
    expect(subject.planting_season).to eq(3 => 'March', 4 => 'April', 5 => 'May')
  end

  it 'can convert planting_season data to month names' do
    expect(subject.planting_season_month_names).to be_instance_of(Array)
    expect(subject.planting_season_month_names.include?('March')).to be(true)
    expect(subject.planting_season_month_names.include?('April')).to be(true)
    expect(subject.planting_season_month_names.include?('May')).to be(true)
  end

  it 'knows if it needs to be planted this month' do
    date = Time.new(2018, 4, 14)
    allow(Time).to receive(:now).and_return(date)

    expect(peas).to be_plant_this_month
    expect(daikon).not_to be_plant_this_month
  end

  it 'knows what vegetables should be planted for a user this month' do
    farm.vegetables << peas
    farm.vegetables << daikon

    date = Time.new(2018, 4, 14)
    allow(Time).to receive(:now).and_return(date)

    expect(described_class.this_months_vegetables_for(user)).to include(peas)
    expect(described_class.this_months_vegetables_for(user)).not_to include(daikon)
  end
end
