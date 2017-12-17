require "api_documentation_helper"

RSpec.resource "PhoneNumbers" do
  header "Content-Type", "application/vnd.api+json"

  post "/phone-numbers" do
    parameter :type, <<-DESC, required: true
      Should always be set to <strong>phone_number</strong>.
    DESC

    parameter "name", <<-DESC, scope: :attributes, required: true
      Name of group of which phone number belongs
    DESC

    parameter "mobile", <<-DESC, scope: :attributes, required: true
      Mobile No
    DESC

    parameter "contact", <<-DESC, scope: :relationships
      The contacts assigned to the phone_number.
    DESC

    let(:type) { :phone_numbers }

    let("name") { "home" }
    let("mobile") { "1231231231" }

    let(:contact) do
      p1 = FactoryGirl.create(:contact, name_first: "Abhilash", name_last: "Gupta", city: "Chennai", state: "Tamil Naidu", country: "India")
      { data: {id: p1.id, type: "contacts"} }
    end

    example_request "Create a phone_number" do
      expect(status).to eq 201
    end
  end

  get "/phone-numbers/:id" do
    parameter :id, <<-DESC, required: true
      ID of the phone_number to be retrieved.
    DESC

    let(:id) do
      contact_id = FactoryGirl.create(:contact, name_first: "Abhilash", name_last: "Gupta", city: "Chennai", state: "Tamil Naidu", country: "India").id
      FactoryGirl.create(:phone_number, contact_id: contact_id, name: "home", mobile: "9667167600").id
    end

    example_request "Get a phone_number" do
      expect(status).to eq 200
    end
  end

  get "/phone-numbers" do
    before do
      contact_id = FactoryGirl.create(:contact, name_first: "Abhilash", name_last: "Gupta", city: "Chennai", state: "Tamil Naidu", country: "India").id
      FactoryGirl.create(:phone_number, contact_id: contact_id, name: "home", mobile: "9667167600")
      FactoryGirl.create(:phone_number, contact_id: contact_id, name: "office", mobile: "9667167612")
    end
    example_request "List phone_numbers" do
      expect(status).to eq 200
    end
  end

end
