RSpec.describe Contact do
  it { is_expected.to have_attribute :name }
  it { is_expected.to have_attribute :mobile }

  it "validates presence of name" do
    subject.name = nil
    subject.valid?
    expect(subject.errors[:name]).to include "can't be blank"
  end

  it "validates presence of mobile" do
    subject.mobile = nil
    subject.valid?
    expect(subject.errors[:mobile]).to include "can't be blank"
  end

end
