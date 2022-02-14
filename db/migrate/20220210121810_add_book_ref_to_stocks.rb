class AddBookRefToStocks < ActiveRecord::Migration[7.0]
  def change
    add_reference :stocks, :book, null: false, foreign_key: true
  end
end
