require "api_documentation_helper"

RSpec.resource "ProductsApiDoc" do
  header "Content-Type", "application/vnd.api+json"

  shared_context :products_parameters_description do

    parameter :type, <<-DESC, required: true
      Should always be set to <strong>products</strong>.
    DESC

    parameter :name, <<-DESC, scope: :attributes, require: true
      Name of product.
    DESC

    parameter :category, <<-DESC, scope: :attributes, require: true
      Category of product.
    DESC

    parameter "sold-out", <<-DESC, scope: :attributes, require: true
      Product is out of stock or not. Enter value as 0 or 1. 0 means product is available and 1 means product is not available.
    DESC

    parameter :price, <<-DESC, scope: :attributes, require: true
      Price of product.
    DESC

    parameter "under-sale", <<-DESC, scope: :attributes
      Product is under sale or not. Enter value as 0 or 1. 0 means product is not under sale and 1 means product is under sale. 
    DESC

    parameter "sale-price", <<-DESC, scope: :attributes
      Selling Price of product. Required when under-sale value is 1.
    DESC

    parameter "sale-text", <<-DESC, scope: :attributes
      Offer on product. Required when under-sale value is 1.
    DESC

  end

  post "/products" do

    include_context :products_parameters_description

    let(:type) { :products }

    let("name") { "Test" }
    let("category") { "Makeup" }
    let("sold-out") { 0 }
    let("under-sale") { 1 }
    let("price") { 1000 }
    let("sale-price") { 500 }
    let("sale-text") { "50% Off" }

    example_request "Create a product" do
      expect(status).to eq 201
    end
  end

  post "/products" do

    include_context :products_parameters_description

    let(:type) { :products }

    let("name") { nil }
    let("category") { nil }
    let("sold-out") { nil }
    let("under-sale") { nil }

    example_request "Create a product and receive an error" do
      expect(status).to eq 422
    end
  end

  get "/products/:id" do
    parameter :id, <<-DESC, required: true
      ID of the product to be retrieved.
    DESC

    let(:id) do
      FactoryGirl.create(:product).id
    end

    example_request "Get a product" do
      expect(status).to eq 200
    end
  end

  get "/products" do
    before do
      FactoryGirl.create(:product, name: "Test", category: "Makeup", sold_out: 0, under_sale: 1, price: 1000, sale_price: 500, sale_text: "50% Off")
      FactoryGirl.create(:product, name: "Test1", category: "Makeup", sold_out: 0, under_sale: 1, price: 1000, sale_price: 500, sale_text: "50% Off")
    end
    example_request "List products" do
      expect(status).to eq 200
    end
  end

  get "/products?sort=price" do
    before do
      FactoryGirl.create(:product, name: "Test", category: "Makeup", sold_out: 0, under_sale: 1, price: 1000, sale_price: 500, sale_text: "50% Off")
    end
    example_request "List products and sort by price ascending" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"][0]["attributes"]["name"]).to eq "Test"
    end
  end

  get "/products?fields[products]=category" do
    before do
      FactoryGirl.create(:product, name: "Test", category: "Makeup", sold_out: 0, under_sale: 1, price: 1000, sale_price: 500, sale_text: "50% Off")
    end
    example_request "List products and only fetch the category attribute" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"][0]["attributes"].size).to eq 1
    end
  end

  get "products?page[limit]=4" do
    before do
      5.times do |n|
        FactoryGirl.create(:product, name: "Test #{n}", category: "Makeup #{n}", sold_out: 0, under_sale: 1, price: 1000, sale_price: 500, sale_text: "50% Off")
      end
    end
    example_request "List products 4 at a time" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 4
    end
  end
end
