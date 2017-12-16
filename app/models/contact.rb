class Contact < ApplicationRecord
  has_many :phone_numbers

  ### Validations
  validates :name_first, presence: true
  validates :name_last, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
end
