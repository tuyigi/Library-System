class AddMovementTypeToStocks < ActiveRecord::Migration[7.0]
  def change
    add_column :stocks, :movement_type, :string
  end
end
