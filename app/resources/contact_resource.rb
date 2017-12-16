class ContactResource < JSONAPI::Resource
  attributes :name_first, :name_last, :email, :city, :country, :state
  has_many :phone_numbers
end
