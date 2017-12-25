require 'rails_helper'

RSpec.describe Product, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  it { is_expected.to have_attribute :name }
  it { is_expected.to have_attribute :category }
  it { is_expected.to have_attribute :sold_out }
  it { is_expected.to have_attribute :price }
  it { is_expected.to have_attribute :under_sale }
  it { is_expected.to have_attribute :sale_price }
  it { is_expected.to have_attribute :sale_text }

  it "validates presence of name" do
    subject.name = nil
    subject.valid?
    expect(subject.errors[:name]).to include "can't be blank"
  end

  it "validates presence of category" do
    subject.category = nil
    subject.valid?
    expect(subject.errors[:category]).to include "can't be blank"
  end

  it "validates presence of sold_out" do
    subject.sold_out = nil
    subject.valid?
    expect(subject.errors[:sold_out]).to include "is not included in the list"
  end

  it "validates presence of under_sale" do
    subject.under_sale = nil
    subject.valid?
    expect(subject.errors[:under_sale]).to include "is not included in the list"
  end

  it "validates presence of price" do
    subject.price = nil
    subject.valid?
    expect(subject.errors[:price]).to include "Price should be greater than 0"
  end

  it "validates presence of sale_price with respect to value of under sale" do
    subject.under_sale = true
    subject.sale_price = 0
    subject.valid?
    expect(subject.errors[:sale_price]).to include "Sale Price should be greater than 0 if under_sale is true"
  end

  it "validates presence of sale_text with respect to value of under sale" do
    subject.under_sale = true
    subject.sale_text = nil
    subject.valid?
    expect(subject.errors[:sale_text]).to include "Sale Text should be present if under_sale is true"
  end

end
