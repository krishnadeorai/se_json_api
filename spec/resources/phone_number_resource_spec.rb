RSpec.describe PhoneNumberResource do
  let :creatable_fields do
    [:name, :mobile, :contacts]
  end

  let :fetchable_fields do
    [:id, :name, :mobile, :created_at, :updated_at, :contacts]
  end

  subject do
    described_class.new(PhoneNumber.new)
  end

  it "has the correct set of creatable fields" do
    expect(described_class.creatable_fields(nil).sort).to eq creatable_fields.sort
  end

  it "has the correct set of updatable fields" do
    expect(described_class.updatable_fields(nil).sort).to eq creatable_fields.sort
  end

  it "has the correct set of fetchable fields" do
    expect(subject.fetchable_fields.sort).to eq fetchable_fields.sort
  end
end
