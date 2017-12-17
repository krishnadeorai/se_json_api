class PhoneNumber < ApplicationRecord
  belongs_to :contact

  ## Validations
  validates :name, presence: true
  validates :mobile, presence: true
end
