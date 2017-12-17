RSpec.describe ContactResource do
  let :creatable_fields do
    [:name_first, :name_last, :city, :state, :country, :phone_numbers]
  end

  let :fetchable_fields do
    [:id, :name_first, :name_last, :email, :city, :state, :country, :created_at, :updated_at, :phone_numbers]
  end

  subject do
    described_class.new(Contact.new)
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
