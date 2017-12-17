RSpec.describe Contact do
  it { is_expected.to have_attribute :name_first }
  it { is_expected.to have_attribute :name_last }
  it { is_expected.to have_attribute :city }
  it { is_expected.to have_attribute :state }
  it { is_expected.to have_attribute :country }

  it "validates presence of name_first" do
    subject.name_first = nil
    subject.valid?
    expect(subject.errors[:name_first]).to include "can't be blank"
  end

  it "validates presence of name_last" do
    subject.name_last = nil
    subject.valid?
    expect(subject.errors[:name_last]).to include "can't be blank"
  end

  it "validates presence of city" do
    subject.city = nil
    subject.valid?
    expect(subject.errors[:city]).to include "can't be blank"
  end

  it "validates presence of state" do
    subject.state = nil
    subject.valid?
    expect(subject.errors[:state]).to include "can't be blank"
  end

  it "validates presence of country" do
    subject.country = nil
    subject.valid?
    expect(subject.errors[:country]).to include "can't be blank"
  end

  it "has many phone_numbers" do
    expect(subject.phone_numbers).to eq []
  end
end
