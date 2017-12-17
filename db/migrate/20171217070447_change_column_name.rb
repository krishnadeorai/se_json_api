class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :phone_numbers, :phone_number, :mobile
  end
end
