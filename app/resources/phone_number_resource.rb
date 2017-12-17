class PhoneNumberResource < JSONAPI::Resource
  attributes :name, :mobile
  has_one :contact

  filter :contact
  filter :name, :mobile
end
