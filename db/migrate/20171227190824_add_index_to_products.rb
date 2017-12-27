class AddIndexToProducts < ActiveRecord::Migration[5.0]
  def change
    add_index :products, :category
    add_index :products, :price
  end
end
