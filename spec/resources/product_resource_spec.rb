RSpec.describe ProductResource do
  let :creatable_fields do
    [:name, :sold_out, :category, :under_sale, :price, :sale_price, :sale_text]
  end

  let :fetchable_fields do
    [:name, :sold_out, :category, :under_sale, :price, :sale_price, :sale_text]
  end

  subject do
    described_class.new(Product.new)
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
