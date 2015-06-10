class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
      t.integer :table_num

      t.timestamps null: false
    end
  end
end
