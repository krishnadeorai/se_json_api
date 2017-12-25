class Product < ApplicationRecord

  ## Validations
   validates :name, :category, presence: true
   validates :sold_out, :under_sale, :inclusion => {:in => [true, false]}
   validates :sale_text, presence: { message: "Sale Text should be present if under_sale is true" }, if: :get_under_sale_value?
   validates :price, numericality: {
     greater_than: 0,
     message: "Price should be greater than 0" }

  validates :sale_price, numericality: {
     greater_than: 0,
     message: "Sale Price should be greater than 0 if under_sale is true" }, if: :get_under_sale_value?

  private
  def get_under_sale_value?
    (under_sale) ? true : false
  end

end
