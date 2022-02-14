class AddDetailsToStocks < ActiveRecord::Migration[7.0]
  def change
    add_column :stocks, :quantity, :integer
  end
end
