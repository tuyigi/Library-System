class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :release_year
      t.integer :price
      t.string :status

      t.timestamps
    end
  end
end
