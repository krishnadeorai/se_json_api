require "api_documentation_helper"

RSpec.resource "ContactsDoc" do
  header "Content-Type", "application/vnd.api+json"

  shared_context :contacts_parameters_description do

    parameter :type, <<-DESC, required: true
      Should always be set to <strong>contacts</strong>.
    DESC

    parameter "name-first", <<-DESC, scope: :attributes, require: true
      First Name of person.
    DESC

    parameter "name-last", <<-DESC, scope: :attributes, require: true
      Last Name of person.
    DESC

    parameter :email, <<-DESC, scope: :attributes
      Email of person.
    DESC

    parameter :city, <<-DESC, scope: :attributes, require: true
      Current City Of Person.
    DESC

    parameter :state, <<-DESC, scope: :attributes, require: true
      Current State of person.
    DESC

    parameter :country, <<-DESC, scope: :attributes, require: true
      Current Country of person.
    DESC

    parameter :phone_numbers, <<-DESC, scope: :relationships
      Phone Number of Person.
    DESC

  end

  post "/contacts" do

    include_context :contacts_parameters_description

    let(:type) { :contacts }

    let("name-first") { "Test" }
    let("name-last") { "last" }
    let("email") { "test@gmail.com" }
    let("city") { "Nagpur" }
    let("state") { "Maharastra" }
    let("country") { "India" }

    example_request "Create a contact" do
      expect(status).to eq 201
    end
  end

  post "/contacts" do

    include_context :contacts_parameters_description

    let(:type) { :contacts }

    let("name-first") { nil }
    let("name-last") { nil }
    let("city") { nil }
    let("state") { nil }
    let("country") { nil }

    example_request "Create a contact and receive an error" do
      expect(status).to eq 422
    end
  end

  get "/contacts/:id" do
    parameter :id, <<-DESC, required: true
      ID of the contact to be retrieved.
    DESC

    let(:id) do
      FactoryGirl.create(:contact).id
    end

    example_request "Get a contact" do
      expect(status).to eq 200
    end
  end

  get "/contacts" do
    before do
      FactoryGirl.create(:contact, name_first: "Abhilash", name_last: "Gupta", city: "Chennai", state: "Tamil Naidu", country: "India")
      FactoryGirl.create(:contact, name_first: "Sachin", name_last: "Mishra", city: "Chennai", state: "Tamil Naidu", country: "India")
    end
    example_request "List contacts" do
      expect(status).to eq 200
    end
  end

  get "/contacts?include=phone-numbers" do
    before do
      p1 = FactoryGirl.create(:contact, name_first: "Abhilash", name_last: "Gupta", city: "Chennai", state: "Tamil Naidu", country: "India")
      p2 = FactoryGirl.create(:contact, name_first: "Sachin", name_last: "Mishra", city: "Chennai", state: "Tamil Naidu", country: "India")
      phone_number1 = FactoryGirl.create(:phone_number, contact_id: p1.id, name: "home", mobile: "9667167600")
      phone_number2 = FactoryGirl.create(:phone_number, contact_id: p2.id, name: "home", mobile: "9667167600")
      p1.phone_numbers << phone_number1
      p2.phone_numbers << phone_number2
    end
    example_request "List contacts and include phone_numbers" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["included"].size).to eq 11
    end
  end

  get "/contacts?sort=name_first" do
    before do
      p1 = FactoryGirl.create(:contact, name_first: "Abhilash", name_last: "Gupta", city: "Chennai", state: "Tamil Naidu", country: "India")
      p2 = FactoryGirl.create(:contact, name_first: "Sachin", name_last: "Mishra", city: "Chennai", state: "Tamil Naidu", country: "India")
    end
    example_request "List contacts and sort by name_first ascending" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"][0]["attributes"]["name-first"]).to eq "Abhilash"
    end
  end

  get "/contacts?fields[contacts]=city" do
    before do
      p1 = FactoryGirl.create(:contact, name_first: "Abhilash", name_last: "Gupta", city: "Chennai", state: "Tamil Naidu", country: "India")
      p2 = FactoryGirl.create(:contact, name_first: "Sachin", name_last: "Mishra", city: "Chennai", state: "Tamil Naidu", country: "India")
    end
    example_request "List contacts and only fetch the city attribute" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"][0]["attributes"].size).to eq 1
    end
  end

  get "/contacts" do
    let! :p1 do
      FactoryGirl.create(:contact, name_first: "Abhilash", name_last: "Gupta", city: "Chennai", state: "Tamil Naidu", country: "India")
    end
    let! :p2 do
      FactoryGirl.create(:contact, name_first: "Sachin", name_last: "Mishra", city: "Chennai", state: "Tamil Naidu", country: "India")
    end
    let! :p3 do
      FactoryGirl.create(:contact, name_first: "Sachin", name_last: "Pathak", city: "Delhi", state: "Delhi", country: "India")
    end
    example "List contacts with the id 1 or 2" do
      do_request(filter: { id: "#{p1.id},#{p2.id}"})
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 2
    end
  end

  get "contacts?page[limit]=4" do
    before do
      5.times do |n|
        FactoryGirl.create(:contact, name_first: "Abhilash #{n}", name_last: "Gupta #{n}", city: "Chennai", state: "Tamil Naidu", country: "India")
      end
    end
    example_request "List contacts 4 at a time" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 4
    end
  end

  get "contacts?page[offset]=4" do
    before do
      5.times do |n|
        FactoryGirl.create(:contact, name_first: "Abhilash #{n}", name_last: "Gupta #{n}", city: "Chennai", state: "Tamil Naidu", country: "India")
      end
    end
    example_request "List the second page of contacts" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 4
    end
  end
end
